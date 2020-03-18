//= require jquery3
//= require jquery_ujs
//= require popper
//= require bootstrap-sprockets

var days = ['Domingo','Lunes','Martes','Miércoles','Jueves','Viernes','Sábado'];
var months = ['Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'];

var carousel;
var slider_eventos = [];
var slider_promos = [];
var slider_puntos = [];

var virtual_slider = [];

var number_of_promos = 0; //loaded from HTML (Server)
var number_of_points = 0;
var number_of_events = 0;
var header = "";
var not_available = "";

var time_between_mill = 0;
var last_time_events = 0;
var last_time_promos = 0;

var i_total = 0; //total promos disponibles (puede haber más huecos que promos disponibles)
var j_total = 0;
var k_total = 0;

function get_puntos(){

    return $.get( "/api/v1/getpuntos" ).then(function(data) {
      for (var i = 0; i < data.length; i++) {
        slider_puntos.push(data[i]);
      }
      console.log( "$.get succeeded puntos" );
    }, function() {
      alert( "$.get failed puntos!" );
    }
  );
}

function get_new_eventos(n){

   // Removes expired events
   if (slider_eventos.length > 0) {
     var time_now = Date.now();
     while ( Date.parse(slider_eventos[0].fecha) < time_now ) { //Borra todo!
       slider_eventos.shift();
     }
   }
    // Get new ones
    return $.get( "/api/v1/geteventos", { last_events_retrieval: n } ).then(function(data) {
      for (var i = 0; i < data.length; i++) {
        slider_eventos.push(data[i]);
      }
      console.log( "$.get succeeded eventos" );
    }, function() {
      console.log( "$.get failed eventos!" );
    }
  );
}

function get_new_promos(n){

  //removed unvalid events
  if (slider_promos.length > 0) {
    var time_now = Date.now();
    while ( Date.parse(slider_promos[0].validez) < time_now ) {
      slider_promos.shift();
    }
  }

    return $.get( "/api/v1/getpromos", { last_promos_retrieval: n } ).then(function(data) {
      for (var i = 0; i < data.length; i++) {
        slider_promos.push(data[i]);
      }
      console.log( "$.get succeeded promos" );
    }, function() {
      console.log( "$.get failed promos!" );
    }
  );
}

function create_html_carousel(){
  //Deletion
  $(".carousel").carousel("pause").removeData();
  destroy_html_carousel();
  carousel = $('#carousel-inner');
  // We create the first one with the custom header (loading phase)
  carousel.append (`
    <div class=\"carousel-item\"><img class=\"d-block w-100\" src=${header}></div>
  `);
  virtual_slider.forEach(function(element) {
    create_slide(element);
  });
  // We add an empty one, that won't be showed
  carousel.append("<div class=\"carousel-item\"><img class=\"d-block w-100\"></div>");

  // Activation
  $(".carousel-item:first-child").addClass("active");
  $('.carousel').carousel({
    interval: 2000
  });
  $('.carousel').carousel('cycle').delay(3000);
}

function getDate(string){
  var mydate = new Date(string);

  var weekday = days[ mydate.getDay() ];
  var day = mydate.getDate();
  var month = months[ mydate.getMonth() ];

  return (weekday + " "+ day +" de " + month);
}

function truncateString(str, num) {
  if (str.length <= num) {
    return str
  }
  return str.slice(0, num) + "..." + "<p class=\"my-5 text-center\">Puedes ver la información completa en <strong class=\"highlight text-uppercase\">guiallerena.es</strong></p>"
}

function checkNullImage(image) {
  if (image == null || image == undefined) {
    return noimage; //placeholder
  }
  return image;
}

// It shows proper display deppending on 3 different situation that can ocur: discounted, fixed price or hidden ONLY FOR PROMOS
function determine_price(element){

  if (element.special_price !== "undefined" && element.special_price > 0) {
    return (`
      <h1 class="text-center">ANTES <del class="text-muted">${element.normal_price} €</del> AHORA <span class="price">${element.special_price} €</span></h1>
    `);
  } else if (element.normal_price !== "undefined" && element.normal_price > 0) {
    return (`
      <h1 class="text-center price">${element.normal_price} €</h1>
    `);
  } else {
    //  block of code to be executed if the condition1 is false and condition2 is false
    return "<h1 class=\"text-center price\">Precio a consultar en tienda</h1>";
  }
}

function create_slide(element){

  if (element.imgdestacado){
    carousel.append(`
      <div class="carousel-item">
          <img class="d-block w-100 darken" src="${element.imgdestacado.url}">
          <div class="corner-comercio">
              <span>Turismo</span>
          </div>
          <div class="carousel-caption d-none d-md-block">
              <h1 class="display-1 text-left">${element.titulo}</h1>
              <p class="display-4 text-left">${element.info}</p></div>
          </div>
      </div>
    `);
  }
  if (element.imgpromo){

      carousel.append(`
            <div class="carousel-item" style="background-color: white; height: 1080px; padding: 50px;">
            <div class=\"corner-comercio\"><span>Comercio Local</span></div>

                <div class="row">
                        <div class="col-7"><img src="${checkNullImage(element.imgpromo.url)}" class="img-fluid "></div>
                        <div class="col-5 pr-5 mt-5 pt-5">
                          <div class="text-center my-5"><img src="${element.logo}" class="img-fluid"></div>
                          <div class="h1"><p><mark>${element.titulo}</mark></p></div>
                          <div><p><h2>${element.texto}</h2></p></div>
                          <div>${determine_price(element)}</div>
                          <h2 class="text-center"><p> *** Termina en <span class="price">${element.validez}</span> *** </p></h2>
                          <div><p><h2 class="text-center">Encuéntranos en <strong class="address">${element.address}</strong></h2></p></div>
                        </div>
                </div>
            </div>
        `);

  }
  if (element.imgevento){

      carousel.append(`
            <div class="carousel-item" style="background-color: white; height: 1080px; padding: 50px;">
            <div class=\"corner-comercio\"><span>Actualidad</span></div>
              <div class="row h1 display-4 font-weight-bold mx-3"><p>${getDate(element.fecha)}</p></div>
                <div class="row">
                  <div class="col-6"><img src="${checkNullImage(element.imgevento.url)}" class="img-fluid"></div>
                  <div class="col-6 py-5"><p><h2><strong><mark>${element.titulo}</mark></strong></h2></p><p><h3>${truncateString(element.info,600)}</h3></p></div>
                </div>
            </div>
        `);

  }
}
function refill_virtual_slider(){

  while(virtual_slider.length > 0) { virtual_slider.pop(); }

  // Eventos
  for (var i=0; i < number_of_events; i++) {
    //Given it has made the full loop for holes, it wont insert if there is no events (it consider num max set in config)
    if (typeof slider_eventos[i_total] !== "undefined") {
      virtual_slider.push(slider_eventos[i_total]);
    }

    if (i_total == slider_eventos.length - 1){
      i_total = 0;
    } else {
      i_total++;
     }
  }

  // Promos
  for (var i=0; i < number_of_promos; i++) {
    //Given it has make the full loop for holes, it wont insert if there is no promos
    if (typeof slider_promos[j_total] !== "undefined") {
      virtual_slider.push(slider_promos[j_total]);
    }

    if (j_total == slider_promos.length - 1){
      j_total = 0;
    } else {
      j_total++;
    }
  }

  //Puntos (Puntos are just loaded first time)
  for (var i=0; i < number_of_points; i++) {
    virtual_slider.push(slider_puntos[k_total]);
    if (k_total == slider_puntos.length -1 ) { k_total = 0; } else { k_total++; }
  }
}

function destroy_html_carousel(){
  var el = document.getElementById('carousel-inner');
  while( el.hasChildNodes() ){
      el.removeChild(el.lastChild);
  }
}


function load_everything(){

  $.when(get_puntos(), get_new_eventos(last_time_events), get_new_promos(last_time_promos)).then(function( x ) {
    last_time_events = Date.now(); // updated last time
    last_time_promos = Date.now();
    refill_virtual_slider();
    create_html_carousel();
  });
}

function reload_everything(){

  $.when(get_new_eventos(last_time_events), get_new_promos(last_time_promos)).then(function( x ) {
    last_time_events = Date.now(); // updated last time
    last_time_promos = Date.now();
    refill_virtual_slider();
    create_html_carousel();
  });
}

$(document).ready(function() {

  // Dejamos cargados los valores en memoria (!= 0)
  number_of_promos = parseInt(document.getElementById('number_of_promos').value);
  number_of_points = parseInt(document.getElementById('number_of_points').value);
  number_of_events = parseInt(document.getElementById('number_of_events').value);
  header = document.getElementById('header').value;
  noimage = document.getElementById('noimage').value;
  //time_between_mill = parseInt(document.getElementById('time_between').value);

  load_everything();

  $('.carousel').on('slid.bs.carousel', function ( data ) {
  // $('.carousel').carousel('pause');

  var lastSlide = $('.carousel-item').length - 1;

  if( data.to == lastSlide ) {
    reload_everything();
  }

  });

  //setTimeout(function(){window.location.reload(1);}, 86400000); //at least one full reload every 24 hours
});

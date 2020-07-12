//= require jquery3
//= require jquery_ujs
//= require popper
//= require bootstrap-sprockets

var days = ['Domingo','Lunes','Martes','Miércoles','Jueves','Viernes','Sábado'];
var months = ['Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'];

var carousel;
var slider_eventos = [];
var slider_puntos = [];

var virtual_slider = [];

var number_of_promos = 0; //loaded from HTML (Server)
var number_of_points = 0;
var number_of_events = 0;
var time_between_slides;
var time_delay_with_header;
var header = "";
var not_available = "";
var pantalla_number;

var time_between_mill = 0;
var last_time_events = 0;
var last_time_promos = 0;

var i_total = 0; //total promos disponibles (puede haber más huecos que promos disponibles)
var k_total = 0;

class Empresa {
  constructor(promo, empresa_id) {
    this.turn = 0
    this.empresa_id = empresa_id
    this.promos = new Array()
    this.insertPromoInEmpresa(promo)
  }
  // Hay que determinar numero de existentes y a quien le toca
  takePromoFromEmpresa() {
    let promo = this.promos[this.turn]
    if (this.turn < this.promos.length - 1) {
      this.turn++
    } else {
      this.turn = 0
    }
    return promo
  }
  // dado un valor devuelve la clave. Lo usamos para sustituir con nueva versión
  getKeyByValue(object, value) {
	  return Object.keys(object).find(key => object[key] === value);
  }

  insertPromoInEmpresa(promo) {
    let found = this.promos.find(element => element.id == promo.id);

    if(typeof found === "undefined"){
      this.promos.push(promo)
    }else{
      let index = this.getKeyByValue(this.promos, found) //we just substitute by a recenter version
      this.promos[index] = promo
    }
  }
  // Clean lapsed and removed
  updateAndCleanPromos() {
    var time_now = Date.now()/1000
    let i = this.promos.length - 1
    while (i>= 0) {
      if (this.promos[i].validez < time_now || this.promos[i].version < 0 ) {
        if (this.turn == this.promos.length - 1) {
          if (this.turn > 0) {
            this.turn--
          }
        }
        this.promos.splice(i, 1) //remove
      }
      i--
    }
  }
  checkEmpresaShouldExist() {
    if (this.promos.length == 0) {
      return false;
    } else
      return true;
  }
}

function Marketplace() {
  this.empresas = []
  this.indexes = [] // here we hold the used ones, to ckeck shown ones
  this.turn // the number (index) to be shown

  this.cleanUp = function () {
    empresas = this.empresas
    Object.keys(this.empresas).forEach(function(i){
      empresas[i].updateAndCleanPromos()
       if (!empresas[i].checkEmpresaShouldExist()){
        delete this.empresas[i];
       }
    });
  }

  this.insertPromoInMarketplace = function (promo) {
    empresa_id = promo.empresa_id;

    if (this.empresas[empresa_id] instanceof Empresa) {
      this.empresas[empresa_id].insertPromoInEmpresa(promo);
    } else {
      this.empresas[empresa_id] = new Empresa(promo, empresa_id);
    }
  }

  this.takePromoFromMarketplace = function(){
    // this.turn is undefinedined in the first entrance //reset turn when every empresa has been featured
    // console.log("Índices: " + this.indexes )
    // console.log("turno: " + this.turn)
    // console.log(this.turn == this.indexes.length - 1)
    if (typeof this.turn === 'undefined' || this.turn == this.indexes.length){
      this.cleanUp(); // removes dated, and invalid ones
      this.indexes = Object.keys(this.empresas);
      this.turn = 0;
    }
    if (this.indexes.length != 0){ // hay empresas
      let i = this.indexes[this.turn];
      this.turn++;

      let promo = this.empresas[i].takePromoFromEmpresa();
      if (typeof promo !== "undefined"){
        return promo;
      } else {
        return false; // promo not found in empresa
      }
    } else {
      return false; // there are no empresas
    }
  }
}

// global instance of promos management system
const m = new Marketplace();


function updateStatus(){
    return $.get( "/api/v1/updatestatus/" + pantalla_number ).then(function(data) {
      console.log( "update: " + data.status );
    }, function() {
      console.log( "$.get updateStatus failed!" );
    }
  );
}

function get_puntos(){

    return $.get( "/api/v1/getpuntos" ).then(function(data) {
      for (var i = 0; i < data.length; i++) {
        slider_puntos.push(data[i]);
      }
      console.log( "$.get succeeded puntos" );
    }, function() {
      console.log( "$.get failed puntos!" );
    }
  );
}

function get_new_eventos(n){

  // Removes expired events
  var time_now = Math.floor(Date.now()/1000);
  if (slider_eventos.length > 0) {
    let i = slider_eventos.length - 1;
    while (i>= 0) {
      if (Date.parse(slider_eventos[i].fecha_as_integer) < time_now  ) {
        slider_eventos.splice(i, 1); //remove
      }
      i--;
    }
  }
    // Get new events since last time
    return $.get( "/api/v1/geteventos", { last_events_retrieval: n } ).then(function(data) {
      for (var i = 0; i < data.length; i++) {
        let index = slider_eventos.findIndex(obj => obj.id == data[i].id);
        //we need to delete or modify an existing one
        if (index != -1){
          if (data[i].version == -1) {
            slider_eventos.splice(index, 1); //delete
          } else if (data[i].version > 0) {
            slider_eventos[index] = data[i]; //update
          }
        } else {
          slider_eventos.push(data[i]); // It's new
        }
      }
      console.log( "$.get succeeded eventos" );
    }, function() {
      console.log( "$.get failed eventos!" );
    }
  );
}

function get_new_promos(n){

    return $.get( "/api/v1/getpromos", { last_promos_retrieval: n } ).then(function(data) {
      for (var i = 0; i < data.length; i++) {
        m.insertPromoInMarketplace(data[i]);
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
    interval: time_between_slides,
    pause: false
  });
  $('.carousel').carousel('cycle').delay(time_delay_with_header);
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
  if (image == null || image == "undefined") {
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
                        <div class="col-7"><img src="${checkNullImage(element.imgpromo)}" class="img-fluid "></div>
                        <div class="col-5 pr-5 mt-5 pt-5">
                          <div class="text-center my-5"><img src="${element.logo}" class="img-fluid"></div>
                          <div class="h1"><p><mark>${element.titulo}</mark></p></div>
                          <div><p><h2>${element.texto}</h2></p></div>
                          <div>${determine_price(element)}</div>
                          <h2 class="text-center"><p> *** Termina en <span class="price">${timeTo(element.validez)}</span> *** </p></h2>
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
                  <div class="col-6"><img src="${checkNullImage(element.imgevento)}" class="img-fluid"></div>
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
    let promo = m.takePromoFromMarketplace();
    if (promo !== false) {
      virtual_slider.push(promo);
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

function timeTo(date) {
  var seconds = Math.floor(date - Date.now()/1000);
  var interval = Math.floor(seconds / 31536000);

  if (interval > 1) {
    return interval + " años";
  }
  interval = Math.floor(seconds / 2592000);
  if (interval > 1) {
    return interval + " meses";
  }
  interval = Math.floor(seconds / 86400);
  if (interval > 1) {
    return interval + " días";
  }
  interval = Math.floor(seconds / 3600);
  if (interval > 1) {
    return interval + " horas";
  }
  interval = Math.floor(seconds / 60);
  if (interval > 1) {
    return interval + " minutos";
  }
  return Math.floor(seconds) + " segundos";
}

function refreshAt(hours, minutes, seconds) {
    var now = new Date();
    var then = new Date();

    if(now.getHours() > hours ||
       (now.getHours() == hours && now.getMinutes() > minutes) ||
        now.getHours() == hours && now.getMinutes() == minutes && now.getSeconds() >= seconds) {
        then.setDate(now.getDate() + 1);
    }
    then.setHours(hours);
    then.setMinutes(minutes);
    then.setSeconds(seconds);

    var timeout = (then.getTime() - now.getTime());
    setTimeout(function() { window.location.reload(true); }, timeout);
}


function pauseAt(hours, minutes, seconds) {
    var now = new Date();
    var then = new Date();

    if(now.getHours() > hours ||
       (now.getHours() == hours && now.getMinutes() > minutes) ||
        now.getHours() == hours && now.getMinutes() == minutes && now.getSeconds() >= seconds) {
        then.setDate(now.getDate() + 1);
    }
    then.setHours(hours);
    then.setMinutes(minutes);
    then.setSeconds(seconds);

    var timeout = (then.getTime() - now.getTime());
    setTimeout(function() { $('.carousel').carousel('pause'); }, timeout);
}

function load_everything(){

  $.when(get_puntos(), get_new_eventos(last_time_events), get_new_promos(last_time_promos)).then(function( x ) {
    last_time_events = Date.now(); // updated last time
    last_time_promos = Date.now();
    refill_virtual_slider();
    create_html_carousel();
    updateStatus();
    //$('.carousel').carousel('pause');
  });
}

function reload_everything(){

  $.when(get_new_eventos(last_time_events), get_new_promos(last_time_promos)).then(function( x ) {
    last_time_events = Date.now(); // updated last time
    last_time_promos = Date.now();
    refill_virtual_slider();
    create_html_carousel();
    updateStatus();
  });
}

$(document).ready(function() {

  number_of_promos = parseInt(document.getElementById('number_of_promos').value);
  number_of_points = parseInt(document.getElementById('number_of_points').value);
  number_of_events = parseInt(document.getElementById('number_of_events').value);
  pantalla_number = parseInt(document.getElementById('pantalla_number').value);
  time_between_slides = parseInt(document.getElementById('time_between_slides').value);
  time_delay_with_header = parseInt(document.getElementById('time_delay_with_header').value);

  header = document.getElementById('header').value;
  noimage = document.getElementById('noimage').value;

  load_everything();

  $('.carousel').on('slid.bs.carousel', function ( data ) {


  var lastSlide = $('.carousel-item').length - 1;

  if( data.to == lastSlide ) {

    reload_everything();
  }

  });

  // Everyday pause/sleep at 23:00
  pauseAt(23,0,0);
  // Everyday refresh/restart at 7:30
  refreshAt(7,30,0);
});

//= require jquery3
//= require jquery_ujs
//= require popper
//= require bootstrap-sprockets

var slider_eventos = []
var slider_promos = []
var slider_puntos = []
var d = new Date();

function get_new_eventos(n){

  $.ajax({
    url: "/api/v1/geteventos",
    type: "get",
    data: { last_events_retrieval: n},
    success: function(data) {

      for (var i = 0; i < data.length; i++) {
        slider_eventos.push(data[i]);
      }
      create_html_carousel();

    },
    error: function(data) {}
  })
  return slider_eventos;
}

function get_new_promos(n){

  $.ajax({
    url: "/api/v1/getpromos",
    type: "get",
    data: { last_promos_retrieval: n},
    success: function(data) {
      //cleanEventos();
      //loadNewEventos();

      for (var i = 0; i < data.length; i++) {
        slider_promos.push(data[i]);
      }
    },
    error: function(data) {}
  })
}

function create_html_carousel(){

  $(".carousel").carousel("pause").removeData();

  var carousel = $('#carousel-inner');
  for (var i = 0; i < slider_eventos.length; i++) {
    carousel.append("<div class=\"carousel-item\"><img class=\"d-block w-100\" src="+ slider_eventos[i].imgevento.url +" alt=\"Fuck\"></div>");
  }
  $(".carousel-item:first-child").addClass("active");

  $('.carousel').carousel({
    interval: 2000
  })
}

function destroy_html_carousel(){
  var el = document.getElementById('carousel-inner');
  while( el.hasChildNodes() ){
      el.removeChild(el.lastChild);
  }
}


$(document).ready(function() {


  var current_time = parseFloat(d.getTime());
  get_new_eventos(current_time);

  $('.carousel').on('slid.bs.carousel', function ( data ) {
  var lastSlide = $('.carousel-item').length - 1;
  console.log(lastSlide);
  console.log("Entra");
  console.log(data.to);
  if( data.to == lastSlide ) {
    $(".carousel").carousel("pause"); // <--- Aquí, cuando ha terminado el ciclo entero. Me logea pausa, pero no me lo para
    console.log("PAUSA");
  }
});

  //setTimeout(function(){window.location.reload(1);}, 86400000); //at least one full reload every 24 hours
});

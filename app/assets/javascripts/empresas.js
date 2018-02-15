$(document).on('turbolinks:load', function () {

  $('.timepicker').timepicker({
    defaultTime: '10:00',
    timeFormat: 'H:i',
    step: 30,
    disableTextInput: true,
    noneOption: {
        'label': 'CERRADO',
        'value': ''
     }
    });

  if ($('#checkjornada').change(function() {
    document.getElementById("#empresa_schedule0").reset();
  }));


});

function jornada_partida(checkboxElem) {
  if (checkboxElem.checked) {
    $('#parcial').hide();
    document.getElementById("empresa_schedule2").valueAsDate = null;
    document.getElementById("empresa_schedule3").valueAsDate = null;
    document.getElementById("empresa_schedule6").valueAsDate = null;
    document.getElementById("empresa_schedule7").valueAsDate = null;
    document.getElementById("empresa_schedule10").valueAsDate = null;
    document.getElementById("empresa_schedule11").valueAsDate = null;
    document.getElementById("empresa_schedule14").valueAsDate = null;
    document.getElementById("empresa_schedule15").valueAsDate = null;
    document.getElementById("empresa_schedule18").valueAsDate = null;
    document.getElementById("empresa_schedule19").valueAsDate = null;
    document.getElementById("empresa_schedule22").valueAsDate = null;
    document.getElementById("empresa_schedule23").valueAsDate = null;
    document.getElementById("empresa_schedule26").valueAsDate = null;
    document.getElementById("empresa_schedule27").valueAsDate = null;

  } else {
    $('#parcial').show();
  }
}

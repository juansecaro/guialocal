$(document).ready(function () {

  $('.timepicker').timepicker({
    defaultTime: '10:00',
    timeFormat: 'H:i',
    step: 30
    });

  if ($('#checkjornada').change(function() {
    document.getElementById("#empresa_schedule0").reset();


  }));




});

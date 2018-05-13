$(document).on('turbolinks:load', function () {

  $('.timepicker').timepicker({
    scrollDefault: '10:00',
    timeFormat: 'H:i',
    step: 30,
    disableTextInput: true,
    noneOption: {
        'label': 'CERRADO',
        'value': ''
     }
    });

    $("input[type='submit']").click(function(e){
      var $fileUpload = $("#enviar");
      var max_files = num_files_plan($('#empresa_plan').val());
      if (parseInt($fileUpload.get(0).files.length)>max_files){
        e.preventDefault();
        alert('En tu actual plan, sólo puedes subir ' + max_files + ' fotos');
      }
    });


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

function num_files_plan(plan){
  if (plan == "basic") {return 3;}
  else if (plan == "plus") {return 6;}
  else if (plan == "premium") {return 9;}
  else {return 0;} // no plan
}

function num_tags_plan(plan){
  if (plan == "basic") {return 3;}
  else if (plan == "plus") {return 7;}
  else if (plan == "premium") {return 12;}
  else {return 0;} // no plan
}

$(function () {
    var viewer = ImageViewer();
    $('.gallery-items').click(function () {
        var imgSrc = this.src,
            highResolutionImage = $(this).data('high-res-img');

        viewer.show(imgSrc, highResolutionImage);
    });
});

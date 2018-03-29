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

$(function () {
    var viewer = ImageViewer();
    $('.gallery-items').click(function () {
        var imgSrc = this.src,
            highResolutionImage = $(this).data('high-res-img');

        viewer.show(imgSrc, highResolutionImage);
    });
});

$(function(){
    $("input[type='submit']").click(function(){
        var $fileUpload = $("input[type='file']");
        if (parseInt($fileUpload.get(0).files.length)>2){
         alert("You can only upload a maximum of 2 files");
        }
    });
});

$('#enviar').change(function(){
    if(this.files.length>10)
        alert('Too many files');
        });
$('form').submit(function(){
    if(this.files.length>10)
        return false;
});

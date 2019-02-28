$(document).ready(function() {

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

    //Validation based on plan (tags and pics)
    $("input[type='submit']").click(function(e){
      var $fileUpload = $("#enviar");

      var max_files = num_files_plan($('#empresa_plan').val());
      var max_tags = num_tags_plan($('#empresa_plan').val());
      var role = $('#user_role').val();
      if(role == 'user' || role == 'noplan'){

        if (parseInt($fileUpload.get(0).files.length) > max_files){
          e.preventDefault();
          alert('En tu actual plan, sólo puedes subir ' + max_files + ' fotos');
        }
        if (num_words($('#empresa_tag_list').val()) > max_tags){
          e.preventDefault();
          alert('En tu actual plan, sólo puedes tener ' + max_tags + ' palabras clave (hashtags)');
        }
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

// Returns number of words for hastags
function num_words(str){
  strResult = str.split(",");
  return strResult.length;
}

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "name", "output" ]

  initialize() {
    if ($(".charcounter")[0]){
      $(function() {
        $('.c').characterCountdown({countdownTarget: '.cd', maxChars: 60});
        $('.d').characterCountdown({countdownTarget: '.dd', maxChars: 250});
      });
    }
  }

  connect(){
    if ( $("#promo_normal_price").val() == '0.0' || $("#promo_normal_price").val() == '0' ){
      $('#option2').prop('checked', true);
      $("#precios").hide();
    } else {
      $('#option1').prop('checked', true);
    }
  }

  show() {
    $("#precios").show();
    $('#option1').prop('checked', true);
    $('#option2').prop('checked', false);
    $("#promo_normal_price").val("");
    $("#promo_special_price").val("");
  }

  hide() {
    $("#precios").hide();
    $('#option1').prop('checked', false);
    $('#option2').prop('checked', true);
    $("#promo_normal_price").val(0);
    $("#promo_special_price").val(0);
  }

}

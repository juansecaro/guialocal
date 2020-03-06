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

  show() {
    $("#precios").show();
    $('#option1').prop('checked', true);
    $('#option2').prop('checked', false);
    $("#promo_normal_price").val("");
    $("#promo_special_price").val("");
  }
  hide() {
    $("#precios").hide();
    $('#option2').prop('checked', true);
    $('#option1').prop('checked', false);
    $("#promo_normal_price").val(0);
    $("#promo_special_price").val(0);
  }

}

$(document).on('turbolinks:load', function () {

  $(function() {
  	$('.c').characterCountdown({countdownTarget: '.cd', maxChars: 60});
  	$('.d').characterCountdown({countdownTarget: '.dd', maxChars: 250});
  });

});



function htmlEncode (value){
  return $('<div/>').text(value).html();
}

$(function() {
  $("#generate").click(function() {
    $(".qr-code").attr("src", "https://chart.googleapis.com/chart?cht=qr&chl=" + htmlEncode($("#content").val()) + "&chs=160x160&chld=L|0");
  });
});

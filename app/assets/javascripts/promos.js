$(document).on('turbolinks:load', function () {

  $(function() {
  	$('.c').characterCountdown({countdownTarget: '.cd', maxChars: 60});
  	$('.d').characterCountdown({countdownTarget: '.dd', maxChars: 250});
  });

});

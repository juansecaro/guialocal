// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require jquery_ujs
//= require popper
//= require bootstrap-sprockets
//= require font_awesome5
//= require timepicker
//= require imageviewer
//= require imagemap
//= require charactercount
//= require turbolinks
//= require trix
//= require_tree .


$(document).on('turbolinks:load', function () {
	document.getElementById('capital_city').innerHTML = document.getElementById('city_name').value;
	console.log('loaded')
});


$(document).on('turbolinks:load', function () {
	imageMapResize();
	//load_facebook_widget(document, "script", "facebook-jssdk");

});

/**** THIS CODE HERE IS RELATED TO FACEBOOK WIDGET ***/
// Here the widget loads for the first time
$(document).on('turbolinks:load', function(d, s, id) {
	var js, fjs = d.getElementsByTagName(s)[0];
	console.log(fjs)
    	if (d.getElementById(id)){
    		console.log('returning')
    		return;
    	}
    	js = d.createElement(s); js.id = id;
    	js.src = "https://connect.facebook.net/es_ES/sdk.js#xfbml=1&version=v3.0";
    	fjs.parentNode.insertBefore(js, fjs);
 }(document, 'script', 'facebook-jssdk')
 );

/* Now, after the first load we add this, when the turbolinks 
starts a new request it will save the tag created above, then re insert them
after the turbolinks is reloaded 

Reasons to get rid of turbolinks count: 1
*/

(function($) {
  var fbRoot;

  function saveFacebookRoot() {
  	console.log('holi')
    if ($('#fb-root').length) {
      fbRoot = $('#fb-root').detach();
    }
  };

  function restoreFacebookRoot() {
    if (fbRoot != null) {
      if ($('#fb-root').length) {
        $('#fb-root').replaceWith(fbRoot);
      } else {
        $('body').append(fbRoot);
      }
    }

    if (typeof FB !== "undefined" && FB !== null) { // Instance of FacebookSDK
      FB.XFBML.parse();
    }
  };

  $(document).on('turbolinks:request-start', saveFacebookRoot)
  $(document).on('turbolinks:load', restoreFacebookRoot)
}(jQuery));
/****** END OF FACEBOOK WIDGET HANDLER *****/
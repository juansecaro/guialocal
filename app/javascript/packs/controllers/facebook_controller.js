import { Controller } from "stimulus"
export default class extends Controller{

  static targets = [ "fbbutton" ]

  initialize(){
    (function(d, s, id) {
    	var js, fjs = d.getElementsByTagName(s)[0];
    	console.log(fjs)
        	if (d.getElementById(id)){
        		console.log('returning')
        		return;
        	}
        	js = d.createElement(s); js.id = id;
        	js.src = "https://connect.facebook.net/es_ES/sdk.js#xfbml=1&version=v3.0";
        	fjs.parentNode.insertBefore(js, fjs);
     }(document, 'script', 'facebook-jssdk'));
  }

}



import { Controller } from "stimulus"
export default class extends Controller{

  static targets = [ "pictures" ]

  initialize(){
    $(function () {
        var viewer = ImageViewer();
        $('.gallery-items').click(function () {
            var imgSrc = this.src,
                highResolutionImage = $(this).data('high-res-img');

            viewer.show(imgSrc, highResolutionImage);
        });
    });
  }

}

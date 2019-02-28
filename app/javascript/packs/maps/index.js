

document.addEventListener('DOMContentLoaded', function() {


console.log("Helsslo");
if ($('#map')[0]) {

    var mlat = document.getElementById("mlat").value;
    var mlon = document.getElementById("mlon").value;

    map = new GMaps({
    div: '#map',
    lat: mlat,
    lng: mlon
  });

    map.addMarker({
      lat: mlat,
      lng: mlon,
    title: 'Lima',
    click: function(e) {
      alert('You clicked in this marker');
    }
  });
}


});

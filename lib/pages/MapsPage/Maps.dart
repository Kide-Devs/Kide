import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kide/pages/MapsPage/assets/mapMarkers.dart';

void main() => runApp(MapsPage());

class MapsPage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MapsPage> {
  GoogleMapController mapController;
  final LatLng _center = const LatLng(20.354890, 85.815120);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle(null);
    mapController.setMapStyle('[{"elementType":"geometry","stylers":[{"color":"#f5f5f5"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#f5f5f5"}]},{"featureType":"administrative.land_parcel","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"poi","elementType":"labels.text","stylers":[{"color":"#c6c6c6"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi","elementType":"labels.text.stroke","stylers":[{"visibility":"off"}]},{"featureType":"poi.medical","elementType":"geometry.fill","stylers":[{"color":"#ef2110"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"poi.sports_complex","elementType":"geometry.fill","stylers":[{"color":"#7dec5e"}]},{"featureType":"poi.sports_complex","elementType":"labels.text","stylers":[{"color":"#fafafa"}]},{"featureType":"road","elementType":"geometry","stylers":[{"color":"#ffffff"}]},{"featureType":"road.arterial","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#dadada"}]},{"featureType":"road.highway","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"transit.line","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"transit.station","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#c9c9c9"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]}]');
    _getPermissions();
  }

  Future<void> _getPermissions() async{
    Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.location]);
    PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.location);
    ServiceStatus serviceStatus = await PermissionHandler().checkServiceStatus(PermissionGroup.location);
    bool isShown = await PermissionHandler().shouldShowRequestPermissionRationale(PermissionGroup.location);
    print(isShown);
  }
  
  void _currentLocation() async {
    Position currentLocation = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 18.0,
        tilt: 60,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        markers: markers,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 18.0,
          tilt: 60,
        ),
        buildingsEnabled: true,
        mapToolbarEnabled: false,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        compassEnabled: true,
        zoomGesturesEnabled: true,
        rotateGesturesEnabled: true,
        tiltGesturesEnabled: true,
        indoorViewEnabled: true,
        
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: Icon(Icons.search),
            heroTag: hashCode,
          ),
          SizedBox(
            height: 16,
          ),
          FloatingActionButton(
            child: Icon(Icons.my_location),
            heroTag: hashCode,
            onPressed: _currentLocation,
          ),
        ],
      ),
    );
  }
}

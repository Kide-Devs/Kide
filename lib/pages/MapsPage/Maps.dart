import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kide/pages/MapsPage/assets/GoogleMapsKey.dart';
import 'package:kide/pages/MapsPage/widgets/FilterCategory.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kide/pages/MapsPage/assets/MapMarkers.dart';
import 'dart:math' as math;
import 'package:kide/pages/MapsPage/widgets/FilterCategories.dart';
import 'package:search_map_place/search_map_place.dart';

void main() => runApp(MapsPage());

class MapsPage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MapsPage> with TickerProviderStateMixin {
  //Google Maps controller
  GoogleMapController mapController;
  //Latitude and Lingitude of KIIT
  final LatLng _center = const LatLng(20.354890, 85.815120);

  Set<Marker> _markers = markers[categoriesAll.label];
  List<FilterCategory> _categories = categories;
  FilterCategory _categoriesAll = categoriesAll;
  //Animating FAB
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
  }

  //Initialize the map
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle(null);
    mapController.setMapStyle(
        '[{"elementType":"geometry","stylers":[{"color":"#f5f5f5"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#f5f5f5"}]},{"featureType":"administrative.land_parcel","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"poi","elementType":"labels.text","stylers":[{"color":"#c6c6c6"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi","elementType":"labels.text.stroke","stylers":[{"visibility":"off"}]},{"featureType":"poi.medical","elementType":"geometry.fill","stylers":[{"color":"#ef2110"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"poi.sports_complex","elementType":"geometry.fill","stylers":[{"color":"#7dec5e"}]},{"featureType":"poi.sports_complex","elementType":"labels.text","stylers":[{"color":"#fafafa"}]},{"featureType":"road","elementType":"geometry","stylers":[{"color":"#ffffff"}]},{"featureType":"road.arterial","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#dadada"}]},{"featureType":"road.highway","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"transit.line","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"transit.station","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#c9c9c9"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]}]');
    _getPermissions();
    _currentLocation();
  }

  //Requeest permissions for location
  Future<void> _getPermissions() async {
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler()
            .requestPermissions([PermissionGroup.location]);
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);
    ServiceStatus serviceStatus =
        await PermissionHandler().checkServiceStatus(PermissionGroup.location);
    bool isShown = await PermissionHandler()
        .shouldShowRequestPermissionRationale(PermissionGroup.location);
  }

  //Getting the current loaction for the map
  void _currentLocation() async {
    Position currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 18.0,
        tilt: 60,
      ),
    ));
  }

  //Filtering the markers
  _addSearchFilter(FilterCategory category) {
    setState(() {
      category.toggle();
      if (category.isToggled == true) {
        _markers = _markers.union(markers[category.label]);
        // _markers = markers[categoriesAll.label];
      } else {
        _markers = _markers.difference(markers[category.label]);
      }
    });
  }

  _clearSearchFilter() {
    setState(() {
      _markers = {};
      _categories.forEach((f) => f.isToggled = false);
      _categoriesAll.isToggled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            markers: _markers,
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
          // Container(
          //   width: MediaQuery.of(context).size.width - 64,
          //   height: 40,
          //   margin: EdgeInsets.fromLTRB(32, 50, 0, 0),
          //   color: Colors.white,
          //   child: Text('Search', style: TextStyle(color: Colors.black),),
          // ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(_categories.length, (int index) {
          Widget child = Container(
            height: 70.0,
            width: 56.0,
            alignment: FractionalOffset.topCenter,
            child: ScaleTransition(
              scale: CurvedAnimation(
                parent: _controller,
                curve: Interval(0.0, 1.0 - index / _categories.length / 2.0,
                    curve: Curves.easeOut),
              ),
              child: FloatingActionButton(
                heroTag: null,
                backgroundColor:
                    categories[index].isToggled ? Colors.black : Colors.white,
                mini: true,
                child: Icon(_categories[index].icon,
                    color: categories[index].isToggled
                        ? Colors.white
                        : Colors.black),
                onPressed: () {
                  _addSearchFilter(_categories[index]);
                },
                tooltip: _categories[index].label,
              ),
            ),
          );
          return child;
        }).toList()
          ..add(
            FloatingActionButton(
              heroTag: hashCode,
              child: AnimatedFilterWidget(controller: _controller),
              onPressed: () {
                if (_controller.isDismissed) {
                  _controller.forward();
                  _clearSearchFilter();
                } else {
                  _addSearchFilter(categoriesAll);
                  _controller.reverse();
                }
              },
            ),
          )
          ..add(SizedBox(height: 16))
          ..add(
            FloatingActionButton(
              child: Icon(Icons.my_location),
              heroTag: hashCode,
              onPressed: _currentLocation,
            ),
          ),
      ),
    );
  }
}

class AnimatedFilterWidget extends StatelessWidget {
  const AnimatedFilterWidget({
    Key key,
    @required AnimationController controller,
  })  : _controller = controller,
        super(key: key);

  final AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget child) {
        return Transform(
          transform: Matrix4.rotationZ(_controller.value * 0.5 * math.pi),
          alignment: FractionalOffset.center,
          child: Icon(_controller.isDismissed ? Icons.search : Icons.close),
        );
      },
    );
  }
}

import 'package:Kide/config/Viewport.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:Kide/pages/MapsPage/models/FilterCategory.dart';
import 'package:Kide/pages/MapsPage/widgets/SearchBar.dart';
import 'package:Kide/pages/MapsPage/models/FilterCategories.dart';
import 'package:provider/provider.dart';
import 'package:Kide/providers/getMarkers.dart';
import 'package:location/location.dart';
import 'dart:math' as math;

void main() => runApp(MapsPage());

class MapsPage extends StatefulWidget {
  final String eventMarker;
  MapsPage({this.eventMarker});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MapsPage> with TickerProviderStateMixin {
  //Google Maps controller
  GoogleMapController mapController;
  //Latitude and Lingitude of KIIT
  final LatLng _center = const LatLng(20.354890, 85.815120);

  Set<Marker> _markers;
  bool _initialLoad = true;
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
    _currentLocation();
  }

  // When event marker is set
  void _onMapCreatedWithEventMarker(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle(null);
    mapController.setMapStyle(
        '[{"elementType":"geometry","stylers":[{"color":"#f5f5f5"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#f5f5f5"}]},{"featureType":"administrative.land_parcel","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"poi","elementType":"labels.text","stylers":[{"color":"#c6c6c6"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi","elementType":"labels.text.stroke","stylers":[{"visibility":"off"}]},{"featureType":"poi.medical","elementType":"geometry.fill","stylers":[{"color":"#ef2110"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"poi.sports_complex","elementType":"geometry.fill","stylers":[{"color":"#7dec5e"}]},{"featureType":"poi.sports_complex","elementType":"labels.text","stylers":[{"color":"#fafafa"}]},{"featureType":"road","elementType":"geometry","stylers":[{"color":"#ffffff"}]},{"featureType":"road.arterial","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#dadada"}]},{"featureType":"road.highway","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"transit.line","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"transit.station","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#c9c9c9"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]}]');
  }

  //Getting the current loaction for the map
  void _currentLocation() async {
    LocationData currentLocation;
    var location = Location();
    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print('Permission denied');
      }
      currentLocation = null;
    }

    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 18.0,
        tilt: 60,
      ),
    ));
  }

  CameraPosition _defaultLocation() {
    return CameraPosition(
      target: _center,
      zoom: 18.0,
      tilt: 60,
    );
  }

  //Filtering the markers
  _addSearchFilter(FilterCategory category, GetMarkers getMarkers) {
    setState(() {
      category.toggle();
      if (category.isToggled == true) {
        _markers = _markers.union(getMarkers.markers[category.label]);
      } else {
        _markers = _markers.difference(getMarkers.markers[category.label]);
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

  void _getSearchResult() async {
    Marker searchedMarker = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => SearchBar()));

    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: searchedMarker.position,
        zoom: 30.0,
        tilt: 60,
      ),
    ));
  }

  CameraPosition _goToEventLocation(GetMarkers getMarkers) {
    Marker eventMarkerLoc = getMarkers.markers['all'].singleWhere((loc) {
      return loc.markerId.value == widget.eventMarker;
    });
    print(eventMarkerLoc.markerId.value);
    return CameraPosition(
      target: eventMarkerLoc.position,
      zoom: 30.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Markers Listner
    final _getMarkers = Provider.of<GetMarkers>(context);
    // for markers
    _getMarkers.markers.length == 0
        ? _getMarkers.setMarkers()
        : _getMarkers.setMarkerMap();
    // for suggested markers
    if (_getMarkers.suggestedMarkers.length == 0)
      _getMarkers.setSuggestedMarkers();

    // Set to all Markers initially
    if (_initialLoad) _markers = _getMarkers.markers['all'];
    _initialLoad = false;

    ViewPort().init(context);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only( bottom:20),
          child: Stack(
            children: [
              GoogleMap(              
                onMapCreated: (widget.eventMarker == null)
                    ? _onMapCreated
                    : _onMapCreatedWithEventMarker,
                markers: _markers,
                initialCameraPosition: (widget.eventMarker == null)
                    ? _defaultLocation()
                    : _goToEventLocation(_getMarkers),
                buildingsEnabled: true,
                mapToolbarEnabled: true,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                compassEnabled: true,
                zoomGesturesEnabled: true,
                rotateGesturesEnabled: true,
                tiltGesturesEnabled: true,
                indoorViewEnabled: true,
                zoomControlsEnabled: false,                
                padding: const EdgeInsets.only(top: 64.0, right: 0.0),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Material(
                  borderRadius: BorderRadius.circular(8.0),
                  child: TextField(
                    cursorColor: Color(0x0070f0),
                    onTap: () {
                      _getSearchResult();
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                    enableInteractiveSelection: false,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(16.0),
                      fillColor: Colors.black,
                      filled: true,
                      hintText: 'Search for a location',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: ViewPort.screenHeight * 0.09,
                child: MaterialButton(
                  elevation: 8,
                  shape: CircleBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.my_location,
                      color: Colors.blue,
                    ),
                  ),
                  color: Colors.white,
                  onPressed: _currentLocation,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(_categories.length, (int index) {
          Widget child = Container(
            height: ViewPort.screenHeight * 0.085,
            alignment: FractionalOffset.topRight,
            child: ScaleTransition(
              scale: CurvedAnimation(
                parent: _controller,
                curve: Interval(
                    0.0, 1.0 - (index + 1) / _categories.length / 2.0,
                    curve: Curves.easeOut),
              ),
              child: FloatingActionButton.extended(
                heroTag: null,
                backgroundColor:
                    categories[index].isToggled ? Colors.black : Colors.white,
                // mini: true,
                icon: Icon(_categories[index].icon,
                    color: categories[index].isToggled
                        ? Colors.white
                        : Colors.black),
                onPressed: () {
                  _addSearchFilter(_categories[index], _getMarkers);
                },
                // tooltip: _categories[index].label,
                // isExtended: true,
                label: Text(
                  _categories[index].label,
                  style: TextStyle(
                    color: categories[index].isToggled
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
          );
          return child;
        }).toList()
          ..add(
            Padding(
              padding: EdgeInsets.only(bottom: ViewPort.screenHeight * 0.1),
              child: FloatingActionButton(
                heroTag: hashCode,
                child: AnimatedFilterWidget(controller: _controller),
                onPressed: () {
                  if (_controller.isDismissed) {
                    _controller.forward();
                    _clearSearchFilter();
                  } else {
                    _addSearchFilter(categoriesAll, _getMarkers);
                    _controller.reverse();
                  }
                },
              ),
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
          child: Icon(_controller.isDismissed ? Icons.filter_list : Icons.close),
        );
      },
    );
  }
}

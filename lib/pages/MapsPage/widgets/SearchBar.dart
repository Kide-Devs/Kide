import 'package:Kide/config/Viewport.dart';
import 'package:Kide/providers/getMarkers.dart';
import 'package:Kide/util/constants.dart';
import 'package:Kide/widgets/HeaderWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

void main() => runApp(MaterialApp(home: SearchBar()));

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final key = GlobalKey<ScaffoldState>(debugLabel: '_searchScreenkey');
  final TextEditingController _searchQuery = TextEditingController();
  FocusNode _focus = FocusNode();
  bool _isSearching;
  String _searchText = "";
  List<Marker> _markers;
  bool _initialLoad = true;
  String _headerText;

  _SearchBarState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
          _headerText = PLACES_FOR_YOU;
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _searchQuery.text;
          _headerText = SEARCH_RESULTS;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _isSearching = false;
    _headerText = PLACES_FOR_YOU;
    _focus.addListener(_onFocusChange);
    // init();
  }

  void _onFocusChange() {
    if (_focus.hasFocus == true) {
      _handleSearchStart();
    } else {
      _handleSearchEnd();
    }
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      _isSearching = false;
      _searchQuery.clear();
    });
  }

  List<ChildItem> _buildList() {
    return _markers.map((marker) => ChildItem(marker)).toList();
  }

  List<Widget> _buildSearchList(Set<Marker> allMarkers) {
    if (_searchText.isEmpty) {
      return _markers.map((marker) => ChildItem(marker)).toList();
    } else {
      List<Marker> _searchList = List();
      for (int i = 0; i < allMarkers.length; i++) {
        Marker marker = allMarkers.elementAt(i);
        String title = marker.infoWindow.title;
        String description = marker.infoWindow.snippet;

        if ((title.toLowerCase().contains(_searchText.toLowerCase())) ||
            (description.toLowerCase().contains(_searchText.toLowerCase()))) {
          _searchList.add(marker);
        }
      }
      return _searchList.isNotEmpty
          ? _searchList.map((marker) => ChildItem(marker)).toList()
          : [Center(child: Text(NO_SEARCH_RESULT, softWrap: true))];
    }
  }

  @override
  Widget build(BuildContext context) {
    //Listener
    final _getMarkers = Provider.of<GetMarkers>(context);
    if (_initialLoad) _markers = _getMarkers.suggestedMarkers;
    _initialLoad = false;

    ViewPort().init(context);

    return Scaffold(
      key: key,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Material(
                borderRadius: BorderRadius.circular(8.0),
                child: TextField(
                  controller: _searchQuery,
                  cursorColor: Color(0x0070f0),
                  autofocus: true,
                  focusNode: _focus,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(16.0),
                    fillColor: Colors.black,
                    filled: true,
                    hintText: SEARCH_FOR_A_LOCATION,
                    prefixIcon: Icon(Icons.search),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        width: 1,
                        style: BorderStyle.solid,
                        color: Colors.white,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            HeaderWidget(_headerText, 18, Colors.white),
            Divider(
              indent: ViewPort.screenWidth * 0.02,
              endIndent: ViewPort.screenWidth * 0.02,
              color: Colors.blueAccent,
              thickness: 3,
            ),
            Expanded(
              child: Container(
                height: 500,
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  children: _isSearching
                      ? _buildSearchList(_getMarkers.markers['all'])
                      : _buildList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChildItem extends StatelessWidget {
  final Marker marker;

  ChildItem(this.marker);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: Key(this.marker.infoWindow.title),
      title: Text(this.marker.infoWindow.title),
      subtitle: Text(this.marker.infoWindow.snippet),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
      isThreeLine: true,
      enabled: true,
      trailing: Icon(Icons.place, color: Colors.blueAccent),
      onTap: () {
        Navigator.pop(context, marker);
      },
    );
  }
}

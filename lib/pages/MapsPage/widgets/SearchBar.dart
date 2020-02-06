import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kide/pages/MapsPage/assets/mapMarkers.dart';
import 'package:kide/pages/MapsPage/models/SuggestedMarkers.dart';

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

  _SearchBarState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _isSearching = false;
    _focus.addListener(_onFocusChange);
    init();
  }

  void _onFocusChange() {
    if (_focus.hasFocus == true) {
      _handleSearchStart();
    } else {
      _handleSearchEnd();
    }
  }

  void init() {
    _markers = suggestedMarkers;
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

  List<ChildItem> _buildSearchList() {
    if (_searchText.isEmpty) {
      return _markers.map((marker) => ChildItem(marker)).toList();
    } else {
      List<Marker> _searchList = List();
      for (int i = 0; i < markers['all'].length; i++) {
        Marker marker = markers['all'].elementAt(i);
        String title = marker.infoWindow.title;
        String description = marker.infoWindow.snippet;

        if ((title.toLowerCase().contains(_searchText.toLowerCase())) ||
            (description.toLowerCase().contains(_searchText.toLowerCase()))) {
          _searchList.add(marker);
        }
      }
      return _searchList.map((marker) => ChildItem(marker)).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    hintText: 'Search for a location',
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
                  // onChanged: ,
                  // onSubmitted: ,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 500,
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  children: _isSearching ? _buildSearchList() : _buildList(),
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
      title: Text(this.marker.infoWindow.title),
      subtitle: Text(this.marker.infoWindow.snippet),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
      isThreeLine: true,
      enabled: true,
      onTap: () {
        Navigator.pop(context, marker);
      },
    );
  }
}

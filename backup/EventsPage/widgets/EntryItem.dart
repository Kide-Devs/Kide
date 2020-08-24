import 'package:Kide/config/Viewport.dart';
import 'package:Kide/models/SubEvent.dart';
import 'package:Kide/pages/EventsPage/widgets/ExpansionTitle.dart';
import 'package:Kide/pages/MapsPage/Maps.dart';
import 'package:Kide/providers/bookmarks.dart';
import 'package:Kide/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EntryItem extends StatefulWidget {
  EntryItem(this.entry);

  final SubEvent entry;

  @override
  _EntryItemState createState() => _EntryItemState();
}

class _EntryItemState extends State<EntryItem> {
  bool exp = false;

  void onExpansionChanged(bool val) {
    setState(() {
      exp = val;
    });
  }

  bool searchBookmark(SubEvent root, Bookmarks state) {
    for (int i = 0; i < state.bookmarks.length; i++)
      if (state.bookmarks[i] == root) return true;
    return false;
  }

  double setSpacing(int len, double vw) {
    if (len <= 11)
      return vw * 0.05;
    else if (len > 11 && len <= 14)
      return vw * 0.01;
    else
      return 2;
  }

  Widget _buildTiles(SubEvent root, BuildContext context) {
    final _bookmarksState = Provider.of<Bookmarks>(context);
    ViewPort().init(context);
    double _spacing = setSpacing(root.name.length, ViewPort.screenWidth);
    return Theme(
      data: ThemeData(
        textTheme: TextTheme(
          subhead: TextStyle(
              color: Colors.white,
              letterSpacing: exp ? 5 : 2,
              fontWeight: FontWeight.w600),
        ),
        unselectedWidgetColor: Colors.amber,
        accentColor: Colors.white,
      ),
      child: ExpansionTile(
        trailing: SizedBox(height: 0, width: 0),
        key: PageStorageKey<Key>(root.id),
        title: ExpansionTitle(context: context, exp: exp, root: root),
        children: <Widget>[
          Container(
            height: 20,
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Icon(
                      Icons.event_note,
                      color: Color.fromRGBO(0, 112, 240, 100),
                      size: 24.0,
                    ),
                  ),
                  Expanded(child: Text(root.date)),
                  Expanded(
                    child: Icon(
                      Icons.access_time,
                      color: Color.fromRGBO(0, 112, 240, 100),
                      size: 24.0,
                    ),
                  ),
                  Expanded(child: Text(root.time)),
                  Expanded(
                    child: IconButton(
                      icon: Icon(
                        searchBookmark(root, _bookmarksState)
                            ? Icons.turned_in
                            : Icons.turned_in_not,
                        color: Color.fromRGBO(253, 42, 42, 100),
                        size: 24.0,
                      ),
                      onPressed: () {
                        searchBookmark(root, _bookmarksState)
                            ? _bookmarksState.removeBookmark(root)
                            : _bookmarksState.addBookmark(root);
                      },
                    ),
                  ),
                ],
              ),
              Container(
                height: 20,
              ),
              Container(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 16,
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MapsPage(eventMarker: widget.entry.location),
                        ),
                      );
                    },
                    textColor: Color.fromRGBO(253, 42, 42, 1),
                    child: const Text(
                      "Go to Maps",
                      style: TextStyle(fontSize: 10),
                    ),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Container(
                    width: 16,
                  ),
                ],
              ),
              Container(
                height: 8,
              ),
            ],
          ),
        ],
        onExpansionChanged: this.onExpansionChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          // print('Card tapped.'); // TODO
        },
        child: Stack(
          children: <Widget>[
            Container(
                constraints: new BoxConstraints(
                  minHeight: 100.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      EVENTS_PAGE_EVENT_JPG,
                    ),
                  ),
                ),
                margin: const EdgeInsets.fromLTRB(
                    0.0, 00.0, 0.0, 0.0) // ADD ANIMATION to push image down.
                ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                  constraints: new BoxConstraints(
                    minHeight: 100.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.64),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: _buildTiles(widget.entry, context)),
            ),
          ],
        ),
      ),
      margin: const EdgeInsets.fromLTRB(0.0, 14.0, 0.0, 14.0),
    );
  }
}

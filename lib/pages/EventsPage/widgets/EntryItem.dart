import 'package:flutter_svg/flutter_svg.dart';
import 'package:kide/pages/EventsPage/ExpansionTitle.dart';
import 'package:kide/models/SubEvent.dart';
import 'package:flutter/material.dart';


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
      exp= val;
    });
  }

  Widget _buildTiles(SubEvent root) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Theme(
        data: ThemeData(
          textTheme: TextTheme(
            subhead: TextStyle(
              color: Colors.white,
              letterSpacing: exp == true ? 5 : 20,
              fontWeight: FontWeight.w600
            ),
          ),
          unselectedWidgetColor: Colors.amber,
          accentColor: Colors.white,
        ),
        child: ExpansionTile(
          trailing: SizedBox(
            height: 0,
            width: 0
          ),
          key: PageStorageKey<Key>(root.id),
          title: ExpansionTitle(context: context, exp: exp, root: root),
          
          children: <Widget>[
            Container(height: 20,),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(width: 16,),
                    Icon(
                      Icons.event_note,
                      color: Color.fromRGBO(0, 112, 240, 100),
                      size: 24.0,
                    ),
                    Container(width: 10,),
                    Text(root.date),
                    Container(width: 40,),
                    Icon(
                      Icons.access_time,
                      color: Color.fromRGBO(0, 112, 240, 100),
                      size: 24.0,
                    ),
                    Container(width: 10,),
                    Text(root.time),
                    Container(width: 60,),
                    Icon(
                      Icons.turned_in,
                      color: Color.fromRGBO(253, 42, 42, 100),
                      size: 24.0,
                    ),
                  ],
                ),
                Container(height: 20,),
                Row(
                  children: <Widget>[
                    Container(width: 16,),
                    Flexible(
                      child: Container(
                        child: Text(
                          root.description,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                            
                          ),
                        ),
                      ),
                    ),
                    Container(width: 16,),
                  ],
                ),
                Container(height: 20,),
                Row(
                  children: <Widget>[
                    Container(width: 190,),
                    FlatButton(
                      onPressed: () {print("details");},
                      textColor: Colors.white,
                      child: const Text(
                        'DETAILS',
                        style: TextStyle(fontSize: 10)
                      ),
                    ),

                    Container(width: 16,),
                    RaisedButton(
                      onPressed: () {print("register");},
                      textColor: Color.fromRGBO(253, 42, 42, 1),
                      child: const Text(
                        'REGISTER',
                        style: TextStyle(fontSize: 10)
                      ),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      )
                    ),

                  ],
                ),
                Container(height: 8,),
              ],
            ),
          ],
          onExpansionChanged: this.onExpansionChanged,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0)
      ),
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: ()  {
          // Navigator.of(context).pushNamed(
          //   SubEvents.routeName,
          //   arguments: _eventList.eventCategories[position]
          // );
          print('Card tapped.');
        },
        child: Stack(children: <Widget>[
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
                  './lib/assets/event.jpg',
                ),
              ),
            ),
            margin:  const EdgeInsets.fromLTRB(0.0, 00.0, 0.0, 0.0) // ADD ANIMATION to push image down.
          ),
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Container(
              constraints: new BoxConstraints(
                minHeight: 100.0,
              ),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.64),
                  borderRadius: BorderRadius.circular(8.0)
              ),
              child: _buildTiles(widget.entry)
            ),
          ),
        ]), 
      ),
      margin: const EdgeInsets.fromLTRB(0.0, 14.0, 0.0, 14.0),
    );
  }
}
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactCardDiallable extends StatelessWidget {
  final String name;
  final String number;
  final String desc;

  ContactCardDiallable(
    this.name,
    this.number,
    this.desc,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(8, 20, 8, 20),
      color: DynamicTheme.of(context).data.cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: new InkWell(
          onTap: () {
            launch('tel:\\$number');
            print('Contact Card tapped');
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    '$name',
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: DynamicTheme.of(context).data.cardTheme.color,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                if (desc != null)
                  Center(
                    child: Text(
                      '$desc',
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                Center(
                  child: Text(
                    '$number',
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color:
                          DynamicTheme.of(context).brightness == Brightness.dark
                              ? Colors.blueAccent.shade200
                              : Colors.deepPurpleAccent,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyCard extends StatelessWidget {
  const EmergencyCard(this.iconAsset, this.name, this.number,
      {this.backgroundColor = Colors.red});

  final Color backgroundColor;
  final String iconAsset;
  final String name;
  final String number;

  @override
  Widget build(BuildContext context) {
    return new Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      margin: EdgeInsets.all(18),
      color: backgroundColor,
      child: new InkWell(
        onTap: () {
          launch("tel://$number");
        },
        child: new Center(
          child: new Padding(
            padding: const EdgeInsets.fromLTRB(0, 0.0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 3, 8),
                  child: SvgPicture.asset(
                    iconAsset,
                    alignment: Alignment.center,
                    width: 20,
                    fit: BoxFit.scaleDown,
                    color: Colors.white,
                  ),
                ),
                Center(
                  child: Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.5,
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

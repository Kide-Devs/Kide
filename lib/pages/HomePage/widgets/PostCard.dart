
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {

  final String title, subtitle, image, body, date, id;

  PostCard(
    {this.id, this.title, this.subtitle, this.image, this.body, this.date}
  );

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Card(
      color: DynamicTheme.of(context).data.cardColor,
      elevation: 3,
      child: InkWell(
        onTap: () {

        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            widget.image != null
              ? Stack(
                children: <Widget>[
                  Container(
                    height: deviceHeight * 0.3,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(widget.image)
                      )
                    ),
                  ),
                  Container(
                    height: deviceHeight * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      gradient: LinearGradient(
                        begin: FractionalOffset.bottomCenter,
                        end: FractionalOffset.center,
                        colors: [
                          Colors.black.withOpacity(0.55),
                          Colors.black.withOpacity(0.15)
                        ],
                        stops: [
                          0.5,
                          3
                        ]
                      )
                    ),
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            top: deviceHeight * 0.125,
                            left: 8.0,
                            right: 8.0,
                            bottom: 3                           
                          ),
                          child: Text(
                            widget.title,
                            style: TextStyle(
                              height: 1.25,
                              fontSize: deviceHeight * 0.03,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
              : Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 15.0),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: deviceHeight * 0.023,
                    color: Colors.black
                  ),
                ),
              ),
            SizedBox(height: 6.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                widget.subtitle != null ? widget.subtitle : widget.body,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: deviceHeight * 0.02
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "334 Views",
                    style: TextStyle(
                      color: Colors.blue[400]
                    ),
                  ),
                  Text(
                    "120 likes",
                    style: TextStyle(
                      color: Colors.blue[400]
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:Kide/util/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:share/share.dart';

class PostDetailsPage extends StatefulWidget {
  final String title, body, image, subtitle, date, likes, views, postType, id;

  PostDetailsPage(
      {this.id,
      this.postType,
      this.title,
      this.body,
      this.image,
      this.subtitle,
      this.date,
      this.likes,
      this.views});

  @override
  _PostDetailsPageState createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  incrementViews() {
    Firestore firestore = Firestore.instance;
    int views = int.parse(widget.views);
    views++;

    firestore
        .collection('${widget.postType}')
        .document(widget.id)
        .updateData({'views': views});
  }

  @override
  void initState() {
    incrementViews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).iconTheme.color,
        child: Icon(Icons.share),
        onPressed: () async {
          // TODO : SHARE
          print(widget.postType);
          final DynamicLinkParameters parameters = DynamicLinkParameters(
              uriPrefix: 'https://kiitdev.page.link',
              link: Uri.parse(
                  'https://kiitdev.page.link/post/?id=${widget.id}&type=${widget.postType}'),
              androidParameters: AndroidParameters(
                packageName: 'com.kiitdev.Kide',
              ),
              socialMetaTagParameters: SocialMetaTagParameters(
                  description: widget.subtitle,
                  title: widget.title,
                  imageUrl: Uri.parse(widget.image)),
              dynamicLinkParametersOptions: DynamicLinkParametersOptions(
                  shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short)
              // NOT ALL ARE REQUIRED ===== HERE AS AN EXAMPLE =====
              );
          final ShortDynamicLink shortDynamicLink =
              await parameters.buildShortLink();
          final Uri shortUrl = shortDynamicLink.shortUrl;
          print(shortUrl);
          Share.share("${shortUrl}");
        },
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.grey.shade700,
            elevation: 0,
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Material(
                  color: Colors.transparent,
                  elevation: 0,
                  borderRadius: BorderRadius.circular(50),
                  child: InkWell(
                    child: Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
            expandedHeight: deviceHeight * 0.31,
            pinned: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              background: widget.image != null
                  ? Hero(
                      tag: widget.image,
                      child: Stack(
                        children: <Widget>[
                          CachedNetworkImage(
                            imageUrl: widget.image,
                            fit: BoxFit.fill,
                            errorWidget: (context, url, error) => SizedBox(
                              child: Icon(Icons.warning),
                              width: 90,
                              height: 90,
                            ),
                          ),
                          Container(
                            width: double.maxFinite,
                            height: deviceHeight * 0.18,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black54,
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Chip(
                              backgroundColor: DynamicTheme.of(context)
                                  .data
                                  .scaffoldBackgroundColor,
                              avatar: Icon(
                                Icons.access_time,
                                color: DynamicTheme.of(context)
                                    .data
                                    .indicatorColor,
                              ),
                              label: Text(
                                widget.date,
                                style: TextStyle(
                                  color: DynamicTheme.of(context)
                                      .data
                                      .indicatorColor,
                                ),
                              ),
                            ),
                            Spacer(),
                            Chip(
                              backgroundColor: DynamicTheme.of(context)
                                  .data
                                  .scaffoldBackgroundColor,
                              avatar: Icon(
                                Icons.remove_red_eye,
                                color: DynamicTheme.of(context)
                                    .data
                                    .indicatorColor,
                              ),
                              label: Text(
                                "${widget.views} views",
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  color: DynamicTheme.of(context)
                                      .data
                                      .indicatorColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 25.0,
                            fontFamily: "PlayfairDisplay",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 10,
                        ),
                        child: Text(
                          widget.body,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: deviceHeight * 0.0245,
                            fontFamily: "Quicksand",
                          ),
                        ),
                      ),
                      SizedBox(height: 70),
                    ],
                  ),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

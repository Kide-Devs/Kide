import 'package:Kide/pages/HomePage/widgets/PostCard.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostsPage extends StatefulWidget {
  final String postType;
  PostsPage({this.postType});

  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  _buildBlogPosts() {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("Blog ${index.toString()}"),
          );
        });
  }

  _buildNewsPosts() {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("News ${index.toString()}"),
          );
        });
  }

  _buildEventPosts() {
    return StreamBuilder(
      stream: Firestore.instance.collection("events_home").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(itemBuilder: (context, index) {
            return PostCard(
              title: snapshot.data.documents[index]['title'],
              subtitle: snapshot.data.documents[index]['subtitle'],
              body: snapshot.data.documents[index]['body'],
              image: snapshot.data.documents[index]['imageUrl'],
              likes: snapshot.data.documents[index]['likes'].toString(),
              views: snapshot.data.documents[index]['views'].toString(),
            );
          });
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.postType == "blogs") {
      return _buildBlogPosts();
    } else if (widget.postType == "news") {
      return _buildNewsPosts();
    } else if (widget.postType == "events") {
      return _buildEventPosts();
    }
  }
}

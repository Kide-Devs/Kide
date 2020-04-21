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
  List<DocumentSnapshot> posts = [];
  bool isLoading = false, isLoadingNext = false;
  bool hasMore = true;
  int documentLimit = 5;
  DocumentSnapshot lastDocument;
  ScrollController _scrollController = ScrollController();
  Firestore firestore = Firestore.instance;

  @override
  void initState() {
    print("Inside initState()");
    getPosts();
    _scrollController.addListener(listScrollListener);
    super.initState();
  }

  getPosts() async {
    print("Inside getPosts()");
    if (lastDocument == null) {
      setState(() {
        isLoading = true;
      });
    } else {
      setState(() {
        setState(() {
          isLoadingNext = true;
        });
      });
    }

    QuerySnapshot querySnapshot;
    if (lastDocument == null) {
      querySnapshot = await firestore
          .collection(widget.postType)
          .orderBy('title')
          .limit(documentLimit)
          .getDocuments()
          .then((snapshot) {
        setState(() {
          posts.addAll(snapshot.documents);
          lastDocument = posts.last;
        });
        print("First time fetch");
        if (snapshot.documents.length < documentLimit) {
          setState(() {
            hasMore = false;
          });
        }
      }).catchError((e) {
        print(e);
      });
    } else {
      querySnapshot = await firestore
          .collection(widget.postType)
          .orderBy('title')
          .startAtDocument(lastDocument)
          .limit(documentLimit)
          .getDocuments()
          .then((snapshot) {
        setState(() {
          posts.addAll(snapshot.documents);
          lastDocument = posts.last;
        });
        print("nth time fetch");
        if (snapshot.documents.length < documentLimit) {
          setState(() {
            hasMore = false;
          });
        }
      }).catchError((e) {
        print(e);
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  listScrollListener() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;
    double delta = MediaQuery.of(context).size.height * 0.20;
    if (maxScroll - currentScroll <= delta) {
      getPosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Inside build()");
    return Container(
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              controller: _scrollController,
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return (index == posts.length - 1)
                    ? !hasMore
                        ? SizedBox()
                        : Center(child: CircularProgressIndicator())
                    : PostCard(
                        title: posts[index].data['title'],
                        subtitle: posts[index].data['subtitle'],
                        body: posts[index].data['body'],
                        image: posts[index].data['imageUrl'],
                        likes: posts[index].data['likes'].toString(),
                        views: posts[index].data['views'].toString(),
                      );
              },
            ),
    );
  }
}

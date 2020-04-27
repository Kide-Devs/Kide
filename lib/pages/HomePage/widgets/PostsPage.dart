import 'package:Kide/pages/HomePage/widgets/PostCard.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostsPage extends StatefulWidget {
  final String postType;
  PostsPage({this.postType});

  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> with AutomaticKeepAliveClientMixin<PostsPage> {
  List<DocumentSnapshot> posts = [];
  bool isLoading = false, isLoadingNext = false;
  bool hasMore = true;
  int documentLimit = 6;
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

  @override
  get wantKeepAlive => true;

  Future<void> getPosts() async {
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
          .orderBy('date', descending: true)
          .limit(documentLimit)
          .getDocuments()
          .then((snapshot) {
        setState(() {
          posts.addAll(snapshot.documents);
          lastDocument = posts.last;
        });
        print("First time fetch");
        if (snapshot.documents.length < documentLimit - 1) {
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
          .orderBy('date', descending: true)
          .startAtDocument(lastDocument)
          .limit(documentLimit)
          .getDocuments()
          .then((snapshot) {
        setState(() {
          posts.addAll(snapshot.documents);
          lastDocument = posts.last;
        });
        print("nth time fetch");
        if (snapshot.documents.length < documentLimit - 1) {
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


    // Other technique

  }

  listScrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
      print("At the end of list");
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
          : RefreshIndicator(
              child: ListView.builder(
              padding: const EdgeInsets.only(top: 5),
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
                          date: posts[index].data['date'],
                        );
                },
              ),
              onRefresh: getPosts,
          ),
    );
  }
}

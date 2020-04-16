
import 'package:Kide/pages/HomePage/widgets/PostCard.dart';
import 'package:flutter/material.dart';

class PostsPage extends StatefulWidget {
  final String postType;
  PostsPage({this.postType});

  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {


  _buildBlogPosts() {

  }

  _buildNewsPosts() {

  }

  _buildEventPosts() {

  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 3),
      itemCount: 5,
      itemBuilder: (context, index) {
        return PostCard(
          title: "Sample title",
          subtitle: "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit",
          body: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          date: "12-march-2020",
          id: "blog_1",
          image: "https://hoodline.imgix.net/uploads/story/image/397082/..destination_photo_url..ORFA-sky.jpg.jpg?auto=format",
        );
      },
    );
  }
}
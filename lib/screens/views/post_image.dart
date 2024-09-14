import 'package:college_updates/model/post_model.dart';
import 'package:college_updates/screens/post_view.dart';
import 'package:flutter/material.dart';

class ImagePostView extends StatelessWidget {
  const ImagePostView({
    required this.posts,
    super.key,
  });
  final List<PostModel> posts;

  @override
  Widget build(BuildContext context) {
    final imagePosts = posts.where((post) {
      return post.media.isNotEmpty && post.media[0]['type'] == 'image';
    }).toList();
    return imagePosts.isEmpty
        ? Center(
            child: Text('No Image Posts'),
          )
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: imagePosts.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  final List<PostModel> post = [imagePosts[index]];
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostViewPage(
                        posts: post,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: Image.network(imagePosts[index].media[0]['url'],
                      fit: BoxFit.cover),
                ),
              );
            },
          );
  }
}

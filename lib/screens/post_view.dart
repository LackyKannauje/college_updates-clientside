import 'package:college_updates/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';

class PostViewPage extends StatelessWidget {
  final List<PostModel> posts;
  const PostViewPage({required this.posts, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10),
        itemCount: posts.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          final post = posts[index];
          final imagePosts = post.media.where((media) {
            return media != [] && media['type'] == 'image';
          }).toList();
          print(imagePosts);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(post.user.profilePicture == ''
                      ? 'https://randomuser.me/api/portraits/thumb/women/81.jpg'
                      : post.user.profilePicture),
                ),
                title: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    post.user.username,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                  ),
                ),
                subtitle: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    post.user.bio == '' ? 'Student' : post.user.bio,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                trailing: Icon(Icons.more_vert),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  padEnds: false,
                  aspectRatio: 1,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: false,
                  initialPage: 0,
                ),
                items: imagePosts.map(
                  (imagePost) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          // margin: EdgeInsets.symmetric(horizontal: 5.0),
                          color: Colors.black,
                          child: Image.network(
                            imagePost['url'],
                            fit: BoxFit.scaleDown,
                          ),
                        );
                      },
                    );
                  },
                ).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        iconSize: 30,
                        onPressed: () {},
                        icon: Icon(Icons.favorite_border),
                      ),
                      Text(post.likes.toString()),
                      SizedBox(width: 20),
                      IconButton(
                        iconSize: 30,
                        onPressed: () {},
                        icon: Icon(Icons.comment_outlined),
                      ),
                      Text(post.comments.length.toString()),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Text(post.uploadTime.toString().substring(0, 10),
                        style: TextStyle(color: Colors.grey)),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Text("${post.title} ● ",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    Text("${post.description}"),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
        },
      ),
    );
  }
}

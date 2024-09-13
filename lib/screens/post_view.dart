import 'package:college_updates/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PostViewPage extends StatelessWidget {
  final PostModel post;
  const PostViewPage({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    final imagePosts = post.media.where((media) {
      return media != [] && media['type'] == 'image';
    }).toList();
    print(imagePosts);
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'),
            ),
            title: Text('Username'),
            subtitle: Text('Bio'),
            trailing: Icon(Icons.more_vert),
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: 400.0,
              enableInfiniteScroll: false,
              initialPage: 0,
              autoPlay: true,
            ),
            items: imagePosts.map(
              (imagePost) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      // margin: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Image.network(
                        imagePost['url'],
                        // fit: BoxFit.contain,
                      ),
                    );
                  },
                );
              },
            ).toList(),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                Icon(Icons.favorite_border),
                SizedBox(width: 5),
                Text("100"),
                SizedBox(width: 20),
                Icon(Icons.comment_outlined),
                SizedBox(width: 5),
                Text("100"),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Title of the post",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text("Description of the post"),
          ),
        ],
      ),
    );
  }
}

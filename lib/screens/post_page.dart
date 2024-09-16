// import 'package:college_updates/screens/views/media_view.dart';
// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
// import 'package:college_updates/model/post_model.dart';
// import 'profile.dart';

// class PostViewPage extends StatefulWidget {
//   final List<PostModel> posts;
//   final int postIndex;

//   const PostViewPage({required this.posts, required this.postIndex, super.key});

//   @override
//   State<PostViewPage> createState() => _PostViewPageState();
// }

// class _PostViewPageState extends State<PostViewPage> {
//   final ItemScrollController _scrollController = ItemScrollController();

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _scrollController.scrollTo(
//         index: widget.postIndex,
//         duration: Duration(milliseconds: 500),
//         curve: Curves.easeInOut,
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Posts'),
//       ),
//       body: ScrollablePositionedList.builder(
//         padding: EdgeInsets.symmetric(vertical: 10),
//         itemCount: widget.posts.length,
//         itemScrollController: _scrollController,
//         shrinkWrap: true,
//         scrollDirection: Axis.vertical,
//         itemBuilder: (BuildContext context, int index) {
//           final post = widget.posts[index];

//           // Filter for all media in the post (image, video, pdf)
//           final mediaPosts = post.media.where((media) {
//             return media.isNotEmpty;
//           }).toList();

//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => ProfilePage(id: post.user.id),
//                     ),
//                   );
//                 },
//                 child: ListTile(
//                   leading: CircleAvatar(
//                     backgroundImage: NetworkImage(post.user.profilePicture == ''
//                         ? 'https://randomuser.me/api/portraits/thumb/women/81.jpg'
//                         : post.user.profilePicture),
//                   ),
//                   title: Text(
//                     post.user.username,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
//                   ),
//                   subtitle: Text(
//                     post.user.bio == '' ? 'Student' : post.user.bio,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(fontSize: 13),
//                   ),
//                   trailing: Icon(Icons.more_vert),
//                 ),
//               ),

//               // Media Carousel
//               CarouselSlider(
//                 options: CarouselOptions(
//                   padEnds: false,
//                   aspectRatio: 1,
//                   viewportFraction: 1.0,
//                   enableInfiniteScroll: false,
//                   autoPlay: true,
//                   initialPage: 0,
//                 ),
//                 items: mediaPosts.map((mediaPost) {
//                   return MediaView(media: mediaPost);
//                 }).toList(),
//               ),

//               // Likes, Comments, and Post Details
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       IconButton(
//                         iconSize: 30,
//                         onPressed: () {},
//                         icon: Icon(Icons.favorite_border),
//                       ),
//                       Text(post.likes.toString()),
//                       SizedBox(width: 20),
//                       IconButton(
//                         iconSize: 30,
//                         onPressed: () {},
//                         icon: Icon(Icons.comment_outlined),
//                       ),
//                       Text(post.comments.length.toString()),
//                     ],
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(right: 15),
//                     child: Text(
//                       post.uploadTime.toString().substring(0, 10),
//                       style: TextStyle(color: Colors.grey),
//                     ),
//                   ),
//                 ],
//               ),

//               // Post Title and Description
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 15),
//                 child: Row(
//                   children: [
//                     Text("${post.title} ● ",
//                         style: TextStyle(fontWeight: FontWeight.w500)),
//                     Text("${post.description}"),
//                   ],
//                 ),
//               ),

//               SizedBox(height: 20),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:college_updates/screens/views/media_view.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:college_updates/model/post_model.dart';
import 'profile.dart';

class PostViewPage extends StatefulWidget {
  final List<PostModel> posts;
  final int postIndex;

  const PostViewPage({required this.posts, required this.postIndex, super.key});

  @override
  State<PostViewPage> createState() => _PostViewPageState();
}

class _PostViewPageState extends State<PostViewPage> {
  final ItemScrollController _scrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.scrollTo(
        index: widget.postIndex,
        duration: Duration(milliseconds: 500),
        curve: Curves.fastEaseInToSlowEaseOut,
        // curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: ScrollablePositionedList.builder(
        padding: EdgeInsets.symmetric(vertical: 10),
        itemCount: widget.posts.length,
        itemScrollController: _scrollController,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          final post = widget.posts[index];

          // Directly access mediaPosts without filtering repeatedly
          final mediaPosts = post.media;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(id: post.user.id),
                    ),
                  );
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      post.user.profilePicture.isEmpty
                          ? 'https://randomuser.me/api/portraits/thumb/women/81.jpg'
                          : post.user.profilePicture,
                    ),
                  ),
                  title: Text(
                    post.user.username,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                  ),
                  subtitle: Text(
                    post.user.bio.isEmpty ? 'Student' : post.user.bio,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13),
                  ),
                  trailing: Icon(Icons.more_vert),
                ),
              ),

              // Media Carousel
              if (mediaPosts.length == 1) MediaView(media: mediaPosts[0]),
              if (mediaPosts.length > 1)
                CarouselSlider.builder(
                  itemBuilder: (context, itemIndex, pageViewIndex) {
                    return MediaView(media: mediaPosts[itemIndex]);
                  },
                  itemCount: mediaPosts.length,
                  options: CarouselOptions(
                    pauseAutoPlayOnTouch: true,
                    aspectRatio: 9 / 16.5,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: false,
                    initialPage: 0,
                  ),
                ),

              // Likes, Comments, and Post Details
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
                    child: Text(
                      post.uploadTime.toString().substring(0, 10),
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),

              // Post Title and Description
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Text(
                      "${post.title} ● ",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Flexible(
                      child: Text(
                        post.description,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}

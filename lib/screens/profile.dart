// import 'package:college_updates/auth/auth.dart';
// import 'package:college_updates/model/profile_model.dart';
// import 'package:college_updates/services/api.dart';
// import 'package:college_updates/setting.dart';
// import 'package:flutter/cupertino.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';

// class ProfilePage extends StatefulWidget {
//   final String id;
//   const ProfilePage({required this.id, super.key});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage>
//     with TickerProviderStateMixin {
//   bool isMyAccount = false;
//   bool isLoading = true;
//   bool isLoadingFollow = false;
//   bool isFollower = false;

//   late ProfileModel profileDetails;

//   final ApiService _apiService = ApiService();

//   @override
//   void initState() {
//     fetchProfileDetails();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

// // {"_id":"66d968e810063abb257e601a","username":"Anil sahu","email":"lkjigamer@gmail.com","profilePicture":"","bio":"","followers":[],"following":[],"createdAt":"2024-09-05T08:16:40.412Z","__v":0}
//   Future<void> fetchProfileDetails() async {
//     String? token = await _apiService.getToken();
//     if (token != null) {
//       String myId = JwtDecoder.decode(token)['user']['id'];
//       ProfileModel? profile = await _apiService.fetchProfileDetails(widget.id);

//       if (!isMyAccount) {
//         isFollower =
//             await _apiService.checkIsfollower(myId, widget.id) ?? false;
//       }
//       if (profile != null) {
//         setState(() {
//           profileDetails = profile;
//           isMyAccount = myId == widget.id;
//           isLoading = false;
//         });
//       }
//     } else {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => AuthScreen(),
//         ),
//       );
//     }
//   }

//   Future<void> toggleFollow() async {
//     setState(() {
//       isLoadingFollow = true;
//     });
//     String msg = await _apiService.toggleFollow(widget.id, isFollower);
//     if (msg == 'Error') {
//       _showSnackBar('Something went wrong! login again');
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => AuthScreen(),
//         ),
//       );
//     }
//     isFollower
//         ? profileDetails.followers.remove(widget.id)
//         : profileDetails.followers.add(widget.id);
//     setState(() {
//       isFollower = !isFollower;
//       isLoadingFollow = false;
//     });
//     _showSnackBar(msg);
//   }

//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         duration: const Duration(seconds: 1),
//       ),
//     );
//   }

//   Future<void> showAllFollowersOrFollowing(String listUsersOf) async {
//     final userId = widget.id;
//     final followerList = await _apiService.fetchUsers(userId, listUsersOf);
//     if (followerList.isEmpty) {
//       _showSnackBar("User has no Followers");
//       return;
//     }
//     _userFollowListView(followerList);
//   }

//   Future<dynamic> _userFollowListView(followerList) {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           backgroundColor: Colors.white,
//           content: SizedBox(
//             height: MediaQuery.of(context).size.height * 0.6,
//             width: MediaQuery.of(context).size.width * 0.8,
//             child: ListView.builder(
//               scrollDirection: Axis.vertical,
//               shrinkWrap: true,
//               itemCount: followerList.length,
//               itemBuilder: (context, index) {
//                 final follower = followerList[index];

//                 return GestureDetector(
//                   onTap: () {
//                     // Navigator.pop(context);
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ProfilePage(
//                           id: follower['_id'],
//                         ),
//                       ),
//                     );
//                   },
//                   child: ListTile(
//                     title: Text(
//                       follower['username'],
//                       style: TextStyle(fontSize: 17),
//                     ),
//                     subtitle: SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.5,
//                       child: Text(
//                         follower['bio'] == ''
//                             ? 'College Student'
//                             : follower['bio'],
//                         style: TextStyle(fontSize: 12, color: Colors.grey),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     leading: ClipRRect(
//                       borderRadius: BorderRadius.circular(100),
//                       child: Image.network(
//                         follower['profilePicture'] == ''
//                             ? 'https://picsum.photos/200/300'
//                             : follower['profilePicture'],
//                         width: 50,
//                         height: 50,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // fetchProfileDetails();
//     TabController _tabController = TabController(length: 3, vsync: this);
//     return Scaffold(
//       body: isLoading
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
//           : SingleChildScrollView(
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 40,
//                   ),
//                   _topBarView(context),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   _ProfilePicView(),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   Text(
//                     profileDetails.username,
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   SizedBox(
//                     width: 300,
//                     child: Text(
//                       profileDetails.bio,
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: Colors.grey,
//                       ),
//                       maxLines: 2,
//                       textAlign: TextAlign.center,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   _profileDescriptionView(),
//                   SizedBox(
//                     height: 25,
//                   ),
//                   isMyAccount ? SizedBox() : _followMessageView(),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     child: TabBar(
//                       labelColor: Colors.black,
//                       unselectedLabelColor: Colors.grey,
//                       controller: _tabController,
//                       tabs: [
//                         Tab(
//                           text: "Videos",
//                         ),
//                         Tab(
//                           text: "Images",
//                         ),
//                         Tab(
//                           text: "Pdfs",
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     width: double.maxFinite,
//                     height: 300, //example
//                     child: TabBarView(
//                       controller: _tabController,
//                       children: [
//                         Text("hi"),
//                         Text("hey"),
//                         Text("hello"),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//     );
//   }

//   Row _followMessageView() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         isLoadingFollow
//             ? SizedBox(
//                 width: 110,
//                 child: Center(
//                     child: CircularProgressIndicator(
//                   color: Color(0xFFC683E5),
//                 )),
//               )
//             : GestureDetector(
//                 onTap: () => toggleFollow(),
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: isFollower ? null : Color(0xFFC683E5),
//                     border: Border.all(color: Color(0xFFC683E5)),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Row(
//                     children: [
//                       Icon(
//                         Icons.person_add_alt_1_outlined,
//                         color: isFollower ? Color(0xFFC683E5) : Colors.white,
//                         size: 20,
//                       ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       Text(
//                         isFollower ? "Following" : "Follow",
//                         style: TextStyle(
//                           color: isFollower ? Color(0xFFC683E5) : Colors.white,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//         SizedBox(
//           width: 15,
//         ),
//         GestureDetector(
//           onTap: () => _showSnackBar("Message feature is coming soon!"),
//           child: Container(
//             padding: EdgeInsets.symmetric(
//               horizontal: 15,
//               vertical: 6,
//             ),
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: Color(
//                   0xFFC683E5,
//                 ),
//               ),
//               borderRadius: BorderRadius.circular(
//                 15,
//               ),
//             ),
//             child: Row(
//               children: [
//                 Icon(
//                   Icons.sms,
//                   color: Color(
//                     0xFFC683E5,
//                   ),
//                   size: 20,
//                 ),
//                 SizedBox(
//                   width: 5,
//                 ),
//                 Text(
//                   "Message",
//                   style: TextStyle(
//                     color: Color(
//                       0xFFC683E5,
//                     ),
//                     fontSize: 16,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Row _profileDescriptionView() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         _profileDescription("Posts", "100", true),
//         GestureDetector(
//           onTap: () => showAllFollowersOrFollowing("followers"),
//           child: _profileDescription(
//               "Followers", profileDetails.followers.length.toString(), true),
//         ),
//         GestureDetector(
//           onTap: () => showAllFollowersOrFollowing("following"),
//           child: _profileDescription(
//               "Following", "${profileDetails.following.length}", true),
//         ),
//         _profileDescription("Likes", "100", false),
//       ],
//     );
//   }

//   Container _ProfilePicView() {
//     return Container(
//       decoration: BoxDecoration(borderRadius: BorderRadius.circular(200)),
//       child: ClipRRect(
//         child: Image.network(
//           profileDetails.profilePicture == ''
//               ? "https://picsum.photos/200/300"
//               : profileDetails.profilePicture,
//           height: 120,
//           width: 120,
//           fit: BoxFit.cover,
//         ),
//         borderRadius: BorderRadius.circular(200),
//       ),
//     );
//   }

//   Row _topBarView(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         InkWell(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Icon(
//             Icons.arrow_back_ios,
//             size: 20,
//           ),
//         ),
//         Text(
//           "${profileDetails.username}✅",
//           style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
//         ),
//         isMyAccount
//             ? InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => SettingPage(),
//                     ),
//                   );
//                 },
//                 child: Icon(
//                   Icons.settings,
//                   size: 22,
//                 ),
//               )
//             : SizedBox(
//                 width: 20,
//               )
//       ],
//     );
//   }

//   Container _profileDescription(String text, String number, bool isLeftBorder) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 18),
//       decoration: BoxDecoration(
//         border: isLeftBorder
//             ? Border(
//                 right: BorderSide(color: Colors.grey, width: 0.5),
//               )
//             : null,
//       ),
//       child: Column(
//         children: [
//           Text(
//             number,
//             style: TextStyle(
//               fontSize: 17,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           Text(
//             text,
//             style: TextStyle(
//               color: Colors.black54,
//               fontSize: 13,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:college_updates/auth/auth.dart';
import 'package:college_updates/model/post_model.dart';
import 'package:college_updates/model/profile_model.dart';
import 'package:college_updates/screens/views/follow_message.dart';
import 'package:college_updates/screens/views/followers_following.dart';
import 'package:college_updates/screens/views/post_image.dart';
import 'package:college_updates/screens/views/profile_upper.dart';
import 'package:college_updates/services/post_api.dart';
import 'package:college_updates/services/user_api.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ProfilePage extends StatefulWidget {
  final String id;
  const ProfilePage({required this.id, super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  bool isMyAccount = false;
  bool isLoading = true;
  bool isLoadingFollow = false;
  bool isFollower = false;
  int _selectedIndex = 0;
  var _tabController;
  late ProfileModel profileDetails;
  late List<PostModel> posts = [];

  final UserApiService _apiService = UserApiService();
  final PostApiService _postApiService = PostApiService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });

    fetchProfileDetails();
    fetchPostDetails();
  }

  @override
  void dispose() {
    super.dispose();
  }

// {"_id":"66d968e810063abb257e601a","username":"Anil sahu","email":"lkjigamer@gmail.com","profilePicture":"","bio":"","followers":[],"following":[],"createdAt":"2024-09-05T08:16:40.412Z","__v":0}
  Future<void> fetchProfileDetails() async {
    String? token = await _apiService.getToken();
    if (token != null) {
      String myId = JwtDecoder.decode(token)['user']['id'];
      ProfileModel? profile = await _apiService.fetchProfileDetails(widget.id);

      if (!isMyAccount) {
        isFollower =
            await _apiService.checkIsfollower(myId, widget.id) ?? false;
      }
      if (profile != null) {
        setState(() {
          profileDetails = profile;
          isMyAccount = myId == widget.id;
          isLoading = false;
        });
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AuthScreen(),
        ),
      );
    }
  }

  Future<void> fetchPostDetails() async {
    List<PostModel>? postList = await _postApiService.fetchPosts(widget.id);
    if (postList!.isNotEmpty) {
      setState(() {
        posts = postList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfffafdff),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        ProfileDescriptionView(
                            profileDetails: profileDetails,
                            isMyAccount: isMyAccount),
                        SizedBox(height: 30),
                        AllFollowDetails(
                          profileDetails: profileDetails,
                          id: widget.id,
                        ),
                        SizedBox(height: 25),
                        isMyAccount
                            ? SizedBox()
                            : FollowMessageView(
                                isLoadingFollow: isLoadingFollow,
                                isFollower: isFollower,
                                profileDetails: profileDetails,
                                id: widget.id,
                              ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverAppBarDelegate(
                      TabBar(
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Color(0xFFC683E5),
                        controller: _tabController,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorPadding: EdgeInsets.symmetric(horizontal: 25),
                        indicatorWeight: 3,
                        tabs: [
                          Tab(
                            icon: Icon(
                              _selectedIndex == 0
                                  ? Icons.window
                                  : Icons.window_outlined,
                              size: 35,
                              color: Color(0xFFC683E5),
                            ),
                          ),
                          Tab(
                            icon: Icon(
                              _selectedIndex == 1
                                  ? Icons.video_library
                                  : Icons.video_library_outlined,
                              size: 35,
                              color: Color(0xFFC683E5),
                            ),
                          ),
                          Tab(
                            icon: Icon(
                              _selectedIndex == 2
                                  ? Icons.picture_as_pdf
                                  : Icons.picture_as_pdf_outlined,
                              size: 35,
                              color: Color(0xFFC683E5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                body: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ImagePostView(
                        posts: posts,
                      ),
                      Text("hey"),
                      Text("hello"),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color:
          Color(0xfffafdff), // Optional: Set the background color of the TabBar
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

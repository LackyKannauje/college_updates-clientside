// // import 'package:college_updates/auth/auth.dart';
// // import 'package:college_updates/model/post_model.dart';
// // import 'package:college_updates/model/profile_model.dart';
// // import 'package:college_updates/screens/views/follow_message.dart';
// // import 'package:college_updates/screens/views/followers_following.dart';
// // import 'package:college_updates/screens/views/post_media.dart';
// // import 'package:college_updates/screens/views/profile_upper.dart';
// // import 'package:college_updates/services/post_api.dart';
// // import 'package:college_updates/services/user_api.dart';
// // import 'package:flutter/material.dart';
// // import 'package:jwt_decoder/jwt_decoder.dart';

// // class ProfilePage extends StatefulWidget {
// //   final String id;
// //   const ProfilePage({required this.id, super.key});

// //   @override
// //   State<ProfilePage> createState() => _ProfilePageState();
// // }

// // class _ProfilePageState extends State<ProfilePage>
// //     with TickerProviderStateMixin {
// //   bool isMyAccount = false;
// //   bool isLoading = true;
// //   bool isLoadingFollow = false;
// //   bool isFollower = false;
// //   int _selectedIndex = 0;
// //   var _tabController;
// //   late ProfileModel profileDetails;
// //   late List<PostModel> posts = [];

// //   final UserApiService _apiService = UserApiService();
// //   final PostApiService _postApiService = PostApiService();

// //   @override
// //   void initState() {
// //     super.initState();
// //     _tabController = TabController(length: 3, vsync: this);

// //     _tabController.addListener(() {
// //       setState(() {
// //         _selectedIndex = _tabController.index;
// //       });
// //     });

// //     fetchProfileDetails();
// //     fetchPostDetails();
// //   }

// //   @override
// //   void dispose() {
// //     super.dispose();
// //   }

// // // {"_id":"66d968e810063abb257e601a","username":"Anil sahu","email":"lkjigamer@gmail.com","profilePicture":"","bio":"","followers":[],"following":[],"createdAt":"2024-09-05T08:16:40.412Z","__v":0}
// //   Future<void> fetchProfileDetails() async {
// //     String? token = await _apiService.getToken();
// //     if (token != null) {
// //       String myId = JwtDecoder.decode(token)['user']['id'];
// //       ProfileModel? profile = await _apiService.fetchProfileDetails(widget.id);

// //       if (!isMyAccount) {
// //         isFollower =
// //             await _apiService.checkIsfollower(myId, widget.id) ?? false;
// //       }
// //       if (profile != null) {
// //         setState(() {
// //           profileDetails = profile;
// //           isMyAccount = myId == widget.id;
// //           isLoading = false;
// //         });
// //       }
// //     } else {
// //       Navigator.pushReplacement(
// //         context,
// //         MaterialPageRoute(
// //           builder: (context) => AuthScreen(),
// //         ),
// //       );
// //     }
// //   }

// //   Future<void> fetchPostDetails() async {
// //     List<PostModel>? postList = await _postApiService.fetchPosts(widget.id);
// //     if (postList!.isNotEmpty) {
// //       setState(() {
// //         posts = postList;
// //       });
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: Scaffold(
// //         backgroundColor: Color(0xfffafdff),
// //         body: isLoading
// //             ? const Center(
// //                 child: CircularProgressIndicator(),
// //               )
// //             : NestedScrollView(
// //                 headerSliverBuilder: (context, innerBoxIsScrolled) => [
// //                   SliverToBoxAdapter(
// //                     child: Column(
// //                       children: [
// //                         SizedBox(height: 30),
// //                         ProfileDescriptionView(
// //                             profileDetails: profileDetails,
// //                             isMyAccount: isMyAccount),
// //                         SizedBox(height: 30),
// //                         AllFollowDetails(
// //                           profileDetails: profileDetails,
// //                           id: widget.id,
// //                         ),
// //                         SizedBox(height: 25),
// //                         isMyAccount
// //                             ? SizedBox()
// //                             : FollowMessageView(
// //                                 isLoadingFollow: isLoadingFollow,
// //                                 isFollower: isFollower,
// //                                 profileDetails: profileDetails,
// //                                 id: widget.id,
// //                               ),
// //                         SizedBox(height: 20),
// //                       ],
// //                     ),
// //                   ),
// //                   SliverPersistentHeader(
// //                     pinned: true,
// //                     delegate: _SliverAppBarDelegate(
// //                       TabBar(
// //                         labelColor: Colors.black,
// //                         unselectedLabelColor: Colors.grey,
// //                         indicatorColor: Color(0xFFC683E5),
// //                         controller: _tabController,
// //                         indicatorSize: TabBarIndicatorSize.tab,
// //                         indicatorPadding: EdgeInsets.symmetric(horizontal: 25),
// //                         indicatorWeight: 3,
// //                         tabs: [
// //                           Tab(
// //                             icon: Icon(
// //                               _selectedIndex == 0
// //                                   ? Icons.window
// //                                   : Icons.window_outlined,
// //                               size: 35,
// //                               color: Color(0xFFC683E5),
// //                             ),
// //                           ),
// //                           Tab(
// //                             icon: Icon(
// //                               _selectedIndex == 1
// //                                   ? Icons.video_library
// //                                   : Icons.video_library_outlined,
// //                               size: 35,
// //                               color: Color(0xFFC683E5),
// //                             ),
// //                           ),
// //                           Tab(
// //                             icon: Icon(
// //                               _selectedIndex == 2
// //                                   ? Icons.picture_as_pdf
// //                                   : Icons.picture_as_pdf_outlined,
// //                               size: 35,
// //                               color: Color(0xFFC683E5),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //                 body: Container(
// //                   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
// //                   child: TabBarView(
// //                     controller: _tabController,
// //                     children: [
// //                       MediaPostView(posts: posts, mediaType: 'image'),
// //                       MediaPostView(posts: posts, mediaType: 'video'),
// //                       MediaPostView(posts: posts, mediaType: 'pdf'),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //       ),
// //     );
// //   }
// // }

// // class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
// //   final TabBar _tabBar;

// //   _SliverAppBarDelegate(this._tabBar);

// //   @override
// //   double get minExtent => _tabBar.preferredSize.height;
// //   @override
// //   double get maxExtent => _tabBar.preferredSize.height;

// //   @override
// //   Widget build(
// //       BuildContext context, double shrinkOffset, bool overlapsContent) {
// //     return Container(
// //       color:
// //           Color(0xfffafdff), // Optional: Set the background color of the TabBar
// //       child: _tabBar,
// //     );
// //   }

// //   @override
// //   bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
// //     return false;
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:college_updates/auth/auth.dart';
// import 'package:college_updates/model/post_model.dart';
// import 'package:college_updates/model/profile_model.dart';
// import 'package:college_updates/services/post_api.dart';
// import 'package:college_updates/services/user_api.dart';
// import 'package:college_updates/screens/views/followers_following.dart';
// import 'package:college_updates/screens/views/follow_message.dart';
// import 'package:college_updates/screens/views/profile_upper.dart';
// import 'package:college_updates/screens/views/post_media.dart';

// class ProfilePage extends StatefulWidget {
//   final String id;
//   const ProfilePage({required this.id, Key? key}) : super(key: key);

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage>
//     with TickerProviderStateMixin {
//   bool isMyAccount = false;
//   bool isLoading = true;
//   bool isLoadingFollow = false;
//   bool isFollower = false;
//   int _selectedIndex = 0;
//   late TabController _tabController;
//   late ProfileModel profileDetails;
//   List<PostModel> posts = [];

//   final UserApiService _apiService = UserApiService();
//   final PostApiService _postApiService = PostApiService();

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this)
//       ..addListener(() {
//         if (mounted) {
//           setState(() {
//             _selectedIndex = _tabController.index;
//           });
//         }
//       });
//     _initializeData();
//   }

//   void updateFollowers() {
//     setState(() {});
//   }

//   Future<void> _initializeData() async {
//     await Future.wait([
//       fetchProfileDetails(),
//       fetchPostDetails(),
//     ]);
//     setState(() {
//       if (mounted) {
//         isLoading = false;
//       }
//     });
//   }

//   Future<void> fetchProfileDetails() async {
//     String? token = await _apiService.getToken();
//     if (token != null) {
//       String myId = JwtDecoder.decode(token)['user']['id'];
//       final profile = await _apiService.fetchProfileDetails(widget.id);

//       if (!isMyAccount) {
//         isFollower =
//             await _apiService.checkIsfollower(myId, widget.id) ?? false;
//       }

//       if (mounted && profile != null) {
//         profileDetails = profile;
//         isMyAccount = myId == widget.id;
//       }
//     } else {
//       if (mounted) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => AuthScreen()),
//         );
//       }
//     }
//   }

//   Future<void> fetchPostDetails() async {
//     final postList = await _postApiService.fetchPosts(widget.id);
//     if (mounted && postList != null && postList.isNotEmpty) {
//       posts = postList;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: const Color(0xfffafdff),
//         body: isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : NestedScrollView(
//                 headerSliverBuilder: (context, innerBoxIsScrolled) => [
//                   SliverToBoxAdapter(
//                     child: Column(
//                       children: [
//                         const SizedBox(height: 30),
//                         ProfileDescriptionView(
//                             profileDetails: profileDetails,
//                             isMyAccount: isMyAccount),
//                         const SizedBox(height: 30),
//                         AllFollowDetails(
//                             profileDetails: profileDetails, id: widget.id),
//                         const SizedBox(height: 25),
//                         if (!isMyAccount)
//                           FollowMessageView(
//                             isLoadingFollow: isLoadingFollow,
//                             isFollower: isFollower,
//                             profileDetails: profileDetails,
//                             id: widget.id,
//                             onFollowersUpdated: updateFollowers,
//                           ),
//                         const SizedBox(height: 20),
//                       ],
//                     ),
//                   ),
//                   SliverPersistentHeader(
//                     pinned: true,
//                     delegate: _SliverAppBarDelegate(
//                       TabBar(
//                         labelColor: Colors.black,
//                         unselectedLabelColor: Colors.grey,
//                         indicatorColor: const Color(0xFFC683E5),
//                         controller: _tabController,
//                         indicatorSize: TabBarIndicatorSize.tab,
//                         indicatorPadding:
//                             const EdgeInsets.symmetric(horizontal: 25),
//                         indicatorWeight: 3,
//                         tabs: [
//                           _buildTabIcon(Icons.window, Icons.window_outlined, 0),
//                           _buildTabIcon(Icons.video_library,
//                               Icons.video_library_outlined, 1),
//                           _buildTabIcon(Icons.picture_as_pdf,
//                               Icons.picture_as_pdf_outlined, 2),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//                 body: Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
//                   child: TabBarView(
//                     controller: _tabController,
//                     children: [
//                       MediaPostView(posts: posts, mediaType: 'image'),
//                       MediaPostView(posts: posts, mediaType: 'video'),
//                       MediaPostView(posts: posts, mediaType: 'pdf'),
//                     ],
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }

//   Tab _buildTabIcon(IconData selectedIcon, IconData unselectedIcon, int index) {
//     return Tab(
//       icon: Icon(
//         _selectedIndex == index ? selectedIcon : unselectedIcon,
//         size: 35,
//         color: const Color(0xFFC683E5),
//       ),
//     );
//   }
// }

// class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
//   final TabBar _tabBar;
//   _SliverAppBarDelegate(this._tabBar);

//   @override
//   double get minExtent => _tabBar.preferredSize.height;
//   @override
//   double get maxExtent => _tabBar.preferredSize.height;

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Container(
//       color: const Color(0xfffafdff),
//       child: _tabBar,
//     );
//   }

//   @override
//   bool shouldRebuild(covariant _SliverAppBarDelegate oldDelegate) {
//     return false;
//   }
// }

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:college_updates/auth/auth.dart';
import 'package:college_updates/model/post_model.dart';
import 'package:college_updates/model/profile_model.dart';
import 'package:college_updates/services/post_api.dart';
import 'package:college_updates/services/user_api.dart';
import 'package:college_updates/screens/views/followers_following.dart';
import 'package:college_updates/screens/views/follow_message.dart';
import 'package:college_updates/screens/views/profile_upper.dart';
import 'package:college_updates/screens/views/post_media.dart';

class ProfilePage extends StatefulWidget {
  final String id;
  const ProfilePage({required this.id, Key? key}) : super(key: key);

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
  late TabController _tabController;
  late ProfileModel profileDetails;
  List<PostModel> posts = [];
  bool _isMounted = false;

  final UserApiService _apiService = UserApiService();
  final PostApiService _postApiService = PostApiService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_isMounted) {
        setState(() {
          _selectedIndex = _tabController.index;
        });
      }
    });
    _isMounted = true;
    _initializeData();
  }

  void updateFollowers() {
    if (_isMounted) {
      setState(() {});
    }
  }

  Future<void> _initializeData() async {
    try {
      await Future.wait([fetchProfileDetails(), fetchPostDetails()]);
    } catch (e) {
      // Handle exceptions if needed
    } finally {
      if (_isMounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> fetchProfileDetails() async {
    String? token = await _apiService.getToken();
    if (token != null) {
      String myId = JwtDecoder.decode(token)['user']['id'];
      final profile = await _apiService.fetchProfileDetails(widget.id);

      if (!isMyAccount) {
        isFollower =
            await _apiService.checkIsfollower(myId, widget.id) ?? false;
      }

      if (profile != null && _isMounted) {
        setState(() {
          profileDetails = profile;
          isMyAccount = myId == widget.id;
        });
      }
    } else {
      if (_isMounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthScreen()),
        );
      }
    }
  }

  Future<void> fetchPostDetails() async {
    final postList = await _postApiService.fetchPosts(widget.id);
    if (postList != null && postList.isNotEmpty && _isMounted) {
      setState(() {
        posts = postList;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _isMounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xfffafdff),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        ProfileDescriptionView(
                            profileDetails: profileDetails,
                            isMyAccount: isMyAccount),
                        const SizedBox(height: 30),
                        AllFollowDetails(
                            profileDetails: profileDetails, id: widget.id),
                        const SizedBox(height: 25),
                        if (!isMyAccount)
                          FollowMessageView(
                            isLoadingFollow: isLoadingFollow,
                            isFollower: isFollower,
                            profileDetails: profileDetails,
                            id: widget.id,
                            onFollowersUpdated: updateFollowers,
                          ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverAppBarDelegate(
                      TabBar(
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: const Color(0xFFC683E5),
                        controller: _tabController,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorPadding:
                            const EdgeInsets.symmetric(horizontal: 25),
                        indicatorWeight: 3,
                        tabs: [
                          _buildTabIcon(Icons.window, Icons.window_outlined, 0),
                          _buildTabIcon(Icons.video_library,
                              Icons.video_library_outlined, 1),
                          _buildTabIcon(Icons.picture_as_pdf,
                              Icons.picture_as_pdf_outlined, 2),
                        ],
                      ),
                    ),
                  ),
                ],
                body: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      MediaPostView(posts: posts, mediaType: 'image'),
                      MediaPostView(posts: posts, mediaType: 'video'),
                      MediaPostView(posts: posts, mediaType: 'pdf'),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Tab _buildTabIcon(IconData selectedIcon, IconData unselectedIcon, int index) {
    return Tab(
      icon: Icon(
        _selectedIndex == index ? selectedIcon : unselectedIcon,
        size: 35,
        color: const Color(0xFFC683E5),
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
      color: const Color(0xfffafdff),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

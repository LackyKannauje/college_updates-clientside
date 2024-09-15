import 'package:college_updates/auth/auth.dart';
import 'package:college_updates/model/post_model.dart';
import 'package:college_updates/model/profile_model.dart';
import 'package:college_updates/screens/views/follow_message.dart';
import 'package:college_updates/screens/views/followers_following.dart';
import 'package:college_updates/screens/views/post_media.dart';
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

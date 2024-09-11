// import 'dart:convert';

// import 'package:college_updates/const.dart';
// import 'package:college_updates/setting.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:http/http.dart' as http;
// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ProfilePage extends StatefulWidget {
//   final String id;
//   const ProfilePage({required this.id, super.key});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   bool isMyAccount = false;
//   bool isLoading = true;
//   bool isFollower = false;

//   var profileDetails;
//   @override
//   void initState() {
//     fetchProfileDetails();
//     super.initState();
//   }

// // {"_id":"66d968e810063abb257e601a","username":"Anil sahu","email":"lkjigamer@gmail.com","profilePicture":"","bio":"","followers":[],"following":[],"createdAt":"2024-09-05T08:16:40.412Z","__v":0}
//   Future<void> fetchProfileDetails() async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? token = prefs.getString('token');
//       if (token != null) {
//         String id = JwtDecoder.decode(token)['user']['id'];
//         String userId = widget.id;
//         final response =
//             await http.get(Uri.parse(userBaseUrl + userId), headers: {
//           'x-auth-token': token,
//         });
//         final jsonBody = jsonDecode(response.body);
//         print(jsonBody);
//         setState(() {
//           isMyAccount = userId == id;
//           profileDetails = jsonBody;
//           isLoading = false;
//         });
//         if (!isMyAccount) {
//           await checkIsfollower(id, userId);
//         }
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<void> checkIsfollower(String id, String userId) async {
//     try {
//       final followers = await fetchUsers("followers");
//       if (followers.isEmpty) {
//         return;
//       }
//       for (var follower in followers) {
//         if (follower['_id'] == id) {
//           setState(() {
//             isFollower = true;
//           });
//           return;
//         }
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<void> toggleFollow() async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? token = prefs.getString('token');

//       String followUnFollow = isFollower ? "unfollow" : "follow";
//       if (token != null) {
//         String userId = widget.id;

//         final response = await http.post(
//           Uri.parse("${userBaseUrl}${followUnFollow}/${userId}"),
//           headers: {
//             'x-auth-token': token,
//           },
//         );
//         if (response.statusCode == 200 || response.statusCode == 201) {
//           setState(() {
//             isFollower = !isFollower;
//           });
//           final jsonBody = jsonDecode(response.body);
//           print(jsonBody);
//           _showSnackBar(jsonBody['msg']);
//         }
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<dynamic> fetchUsers(String listUsersOf) async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? token = prefs.getString('token');
//       if (token != null) {
//         String userId = widget.id;
//         final response = await http.get(
//             Uri.parse("${userBaseUrl}/${userId}/${listUsersOf}"),
//             headers: {
//               'x-auth-token': token,
//             });
//         final jsonBody = jsonDecode(response.body);
//         print(jsonBody);
//         return jsonBody;
//       }
//     } catch (e) {
//       print(e);
//       return [];
//     }
//   }

//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }

//   Future<void> showAllFollowersOrFollowing(String listUsersOf) async {
//     final followerList = await fetchUsers(listUsersOf);
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
//           content: SizedBox(
//             height: MediaQuery.of(context).size.height * 0.4,
//             width: MediaQuery.of(context).size.width * 0.8,
//             child: ListView.builder(
//               itemCount: followerList.length,
//               itemBuilder: (context, index) {
//                 final follower = followerList[index];
//                 print(follower);
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
//                       style: TextStyle(fontSize: 16),
//                     ),
//                     subtitle: Text("Student"),
//                     leading: ClipRRect(
//                       borderRadius: BorderRadius.circular(100),
//                       child: Image.network(
//                         follower['profilePicture'],
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
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(''),
//         automaticallyImplyLeading: false,
//       ),
//       body: isLoading
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
//           : profileDetails == null
//               ? const Center(
//                   child: Text("Failed to load profile"),
//                 )
//               : Column(
//                   children: [
//                     _topBarView(context),
//                     SizedBox(
//                       height: 25,
//                     ),
//                     _ProfilePicView(),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Text(
//                       profileDetails["username"] ?? "Username",
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     SizedBox(
//                       width: 300,
//                       child: Text(
//                         profileDetails["bio"] ?? "App Developer",
//                         style: TextStyle(
//                           fontSize: 13,
//                           color: Colors.grey,
//                         ),
//                         maxLines: 2,
//                         textAlign: TextAlign.center,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     _profileDescriptionView(),
//                     SizedBox(
//                       height: 25,
//                     ),
//                     isMyAccount ? SizedBox() : _followMessageView(),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Container(
//                       child: Text("posts"),
//                     )
//                   ],
//                 ),
//     );
//   }

//   Row _followMessageView() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         GestureDetector(
//           onTap: () => toggleFollow(),
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//             decoration: BoxDecoration(
//               color: isFollower ? null : Color(0xFFC683E5),
//               border: isFollower ? Border.all(color: Color(0xFFC683E5)) : null,
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Row(
//               children: [
//                 Icon(
//                   Icons.person_add_alt_1_outlined,
//                   color: isFollower ? Color(0xFFC683E5) : Colors.white,
//                   size: 20,
//                 ),
//                 SizedBox(
//                   width: 5,
//                 ),
//                 Text(
//                   isFollower ? "Following" : "Follow",
//                   style: TextStyle(
//                     color: isFollower ? Color(0xFFC683E5) : Colors.white,
//                     fontSize: 16,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(
//           width: 15,
//         ),
//         GestureDetector(
//           onTap: () => _showSnackBar("Message feature is coming soon!"),
//           child: Container(
//             padding: EdgeInsets.symmetric(
//               horizontal: 20,
//               vertical: 8,
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
//               "Followers", profileDetails["followers"].length.toString(), true),
//         ),
//         GestureDetector(
//           onTap: () => showAllFollowersOrFollowing("following"),
//           child: _profileDescription(
//               "Following", profileDetails["following"].length.toString(), true),
//         ),
//         _profileDescription("Likes", "100", false),
//       ],
//     );
//   }

//   Container _ProfilePicView() {
//     return Container(
//       decoration: BoxDecoration(
//           border: Border.all(color: Color(0xFFC683E5), width: 5),
//           borderRadius: BorderRadius.circular(200)),
//       child: ClipRRect(
//         child: Image.network(
//           profileDetails['profilePicture'] ?? "https://picsum.photos/200/300",
//           height: 125,
//           width: 125,
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
//           ),
//         ),
//         Text(
//           profileDetails['username'] ?? "Username",
//           style: TextStyle(
//             fontSize: 18,
//           ),
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
//                 right: BorderSide(color: Colors.black87),
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
//               color: Colors.black87,
//               fontSize: 14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:college_updates/model/profile_model.dart';
import 'package:college_updates/services/api.dart';
import 'package:college_updates/setting.dart';

import 'package:flutter/material.dart';

import 'package:jwt_decoder/jwt_decoder.dart';

class ProfilePage extends StatefulWidget {
  final String id;
  const ProfilePage({required this.id, super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isMyAccount = false;
  bool isLoading = true;
  bool isFollower = false;
  late ProfileModel profileDetails;

  final ApiService _apiService = ApiService();

  @override
  void initState() {
    fetchProfileDetails();
    super.initState();
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
        isFollower = await _apiService.checkIsfollower(myId, widget.id);
      }
      if (profile != null) {
        setState(() {
          profileDetails = profile;
          isMyAccount = myId == widget.id;
          isLoading = false;
        });
      }
    }
  }

  Future<void> toggleFollow() async {
    String msg = await _apiService.toggleFollow(widget.id, isFollower);
    isFollower
        ? profileDetails.followers.remove(widget.id)
        : profileDetails.followers.add(widget.id);
    setState(() {
      isFollower = !isFollower;
    });
    _showSnackBar(msg);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> showAllFollowersOrFollowing(String listUsersOf) async {
    final userId = widget.id;
    final followerList = await _apiService.fetchUsers(userId, listUsersOf);
    if (followerList.isEmpty) {
      _showSnackBar("User has no Followers");
      return;
    }
    _userFollowListView(followerList);
  }

  Future<dynamic> _userFollowListView(followerList) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.8,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: followerList.length,
              itemBuilder: (context, index) {
                final follower = followerList[index];
                print(follower);
                return GestureDetector(
                  onTap: () {
                    // Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(
                          id: follower['_id'],
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(
                      follower['username'],
                      style: TextStyle(fontSize: 16),
                    ),
                    subtitle: Text("Student"),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        follower['profilePicture'] == ''
                            ? 'https://picsum.photos/200/300'
                            : follower['profilePicture'],
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // fetchProfileDetails();
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                _topBarView(context),
                SizedBox(
                  height: 25,
                ),
                _ProfilePicView(),
                SizedBox(
                  height: 15,
                ),
                Text(
                  profileDetails.username,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: 300,
                  child: Text(
                    profileDetails.bio,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                _profileDescriptionView(),
                SizedBox(
                  height: 25,
                ),
                isMyAccount ? SizedBox() : _followMessageView(),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text("posts"),
                )
              ],
            ),
    );
  }

  Row _followMessageView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => toggleFollow(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: isFollower ? null : Color(0xFFC683E5),
              border: isFollower ? Border.all(color: Color(0xFFC683E5)) : null,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.person_add_alt_1_outlined,
                  color: isFollower ? Color(0xFFC683E5) : Colors.white,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  isFollower ? "Following" : "Follow",
                  style: TextStyle(
                    color: isFollower ? Color(0xFFC683E5) : Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        GestureDetector(
          onTap: () => _showSnackBar("Message feature is coming soon!"),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(
                  0xFFC683E5,
                ),
              ),
              borderRadius: BorderRadius.circular(
                15,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.sms,
                  color: Color(
                    0xFFC683E5,
                  ),
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Message",
                  style: TextStyle(
                    color: Color(
                      0xFFC683E5,
                    ),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row _profileDescriptionView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _profileDescription("Posts", "100", true),
        GestureDetector(
          onTap: () => showAllFollowersOrFollowing("followers"),
          child: _profileDescription(
              "Followers", profileDetails.followers.length.toString(), true),
        ),
        GestureDetector(
          onTap: () => showAllFollowersOrFollowing("following"),
          child: _profileDescription(
              "Following", profileDetails.following.length.toString(), true),
        ),
        _profileDescription("Likes", "100", false),
      ],
    );
  }

  Container _ProfilePicView() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFC683E5), width: 5),
          borderRadius: BorderRadius.circular(200)),
      child: ClipRRect(
        child: Image.network(
          profileDetails.profilePicture == ''
              ? "https://picsum.photos/200/300"
              : profileDetails.profilePicture,
          height: 125,
          width: 125,
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(200),
      ),
    );
  }

  Row _topBarView(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        Text(
          profileDetails.username,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        isMyAccount
            ? InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingPage(),
                    ),
                  );
                },
                child: Icon(
                  Icons.settings,
                ),
              )
            : SizedBox(
                width: 20,
              )
      ],
    );
  }

  Container _profileDescription(String text, String number, bool isLeftBorder) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        border: isLeftBorder
            ? Border(
                right: BorderSide(color: Colors.black87),
              )
            : null,
      ),
      child: Column(
        children: [
          Text(
            number,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

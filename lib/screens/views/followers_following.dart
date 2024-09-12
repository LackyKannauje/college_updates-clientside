import 'package:college_updates/model/profile_model.dart';
import 'package:college_updates/screens/profile.dart';
import 'package:college_updates/services/user_api.dart';
import 'package:college_updates/snackbar.dart';
import 'package:flutter/material.dart';

class AllFollowDetails extends StatelessWidget {
  AllFollowDetails({
    super.key,
    required this.profileDetails,
    required this.id,
  });

  final ProfileModel profileDetails;
  final String id;

  @override
  Widget build(BuildContext context) {
    final ApiService _apiService = ApiService();
    Future<void> showAllFollowersOrFollowing(String listUsersOf) async {
      final userId = id;
      final followerList = await _apiService.fetchUsers(userId, listUsersOf);
      if (followerList.isEmpty) {
        showSnackBar("User has no Followers", context);
        return;
      }
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color(0xfffafdff),
            scrollable: true,
            content: SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width * 0.8,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: followerList.length,
                itemBuilder: (context, index) {
                  final follower = followerList[index];

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
                        style: TextStyle(fontSize: 17),
                      ),
                      subtitle: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          follower['bio'] == ''
                              ? 'College Student'
                              : follower['bio'],
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
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

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ProfileFollowDesc(text: "Posts", number: "100", isLeftBorder: true),
        GestureDetector(
          onTap: () => showAllFollowersOrFollowing("followers"),
          child: ProfileFollowDesc(
              text: "Followers",
              number: profileDetails.followers.length.toString(),
              isLeftBorder: true),
        ),
        GestureDetector(
          onTap: () => showAllFollowersOrFollowing("following"),
          child: ProfileFollowDesc(
              text: "Following",
              number: "${profileDetails.following.length}",
              isLeftBorder: true),
        ),
        ProfileFollowDesc(text: "Likes", number: "100", isLeftBorder: false),
      ],
    );
  }
}

class ProfileFollowDesc extends StatelessWidget {
  const ProfileFollowDesc({
    super.key,
    required this.text,
    required this.number,
    required this.isLeftBorder,
  });

  final String text;
  final String number;
  final bool isLeftBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        border: isLeftBorder
            ? Border(
                right: BorderSide(color: Colors.grey, width: 0.5),
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
              color: Colors.black54,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

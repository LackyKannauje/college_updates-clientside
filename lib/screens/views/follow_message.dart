import 'package:college_updates/auth/auth.dart';
import 'package:college_updates/model/profile_model.dart';
import 'package:college_updates/services/user_api.dart';
import 'package:college_updates/snackbar.dart';
import 'package:flutter/material.dart';

class FollowMessageView extends StatefulWidget {
  FollowMessageView({
    super.key,
    required this.id,
    required this.isLoadingFollow,
    required this.isFollower,
    required this.profileDetails,
  });
  final String id;
  bool isLoadingFollow;
  bool isFollower;
  ProfileModel profileDetails;

  @override
  State<FollowMessageView> createState() => _FollowMessageViewState();
}

class _FollowMessageViewState extends State<FollowMessageView> {
  final ApiService _apiService = ApiService();
  Future<void> toggleFollow() async {
    setState(() {
      widget.isLoadingFollow = true;
    });
    String msg = await _apiService.toggleFollow(widget.id, widget.isFollower);
    if (msg == 'Error') {
      showSnackBar('Something went wrong! login again', context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AuthScreen(),
        ),
      );
    }
    widget.isFollower
        ? widget.profileDetails.followers.remove(widget.id)
        : widget.profileDetails.followers.add(widget.id);
    setState(() {
      widget.isFollower = !widget.isFollower;
      widget.isLoadingFollow = false;
    });
    showSnackBar(msg, context);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget.isLoadingFollow
            ? SizedBox(
                width: 110,
                child: Center(
                    child: CircularProgressIndicator(
                  color: Color(0xFFC683E5),
                )),
              )
            : GestureDetector(
                onTap: () => toggleFollow(),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                  decoration: BoxDecoration(
                    color: widget.isFollower ? null : Color(0xFFC683E5),
                    border: Border.all(color: Color(0xFFC683E5)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person_add_alt_1_outlined,
                        color: widget.isFollower
                            ? Color(0xFFC683E5)
                            : Colors.white,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.isFollower ? "Following" : "Follow",
                        style: TextStyle(
                          color: widget.isFollower
                              ? Color(0xFFC683E5)
                              : Colors.white,
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
          onTap: () => showSnackBar('Message Feature Coming Soon!!', context),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 6,
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
}

import 'package:college_updates/model/profile_model.dart';
import 'package:college_updates/services/user_api.dart';
import 'package:college_updates/snackbar.dart';
import 'package:flutter/material.dart';

class FollowMessageView extends StatefulWidget {
  const FollowMessageView({
    super.key,
    required this.id,
    required this.isLoadingFollow,
    required this.isFollower,
    required this.profileDetails,
  });
  final String id;
  final bool isLoadingFollow;
  final bool isFollower;
  final ProfileModel profileDetails;

  @override
  State<FollowMessageView> createState() => _FollowMessageViewState();
}

class _FollowMessageViewState extends State<FollowMessageView> {
  bool isLoadingFollow = false;
  bool isFollower = false;
  final UserApiService _apiService = UserApiService();
  Future<void> toggleFollow() async {
    setState(() {
      isLoadingFollow = true;
    });
    String msg = await _apiService.toggleFollow(widget.id, isFollower);
    if (msg == 'Error') {
      showSnackBar('Something went wrong! try again', context);
    }
    isFollower
        ? widget.profileDetails.followers.remove(widget.id)
        : widget.profileDetails.followers.add(widget.id);
    setState(() {
      isFollower = !isFollower;
      isLoadingFollow = false;
    });
    showSnackBar(msg, context);
  }

  @override
  void initState() {
    super.initState();
    isFollower = widget.isFollower;
    isLoadingFollow = widget.isLoadingFollow;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        isLoadingFollow
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
                    color: isFollower ? null : Color(0xFFC683E5),
                    border: Border.all(color: Color(0xFFC683E5)),
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

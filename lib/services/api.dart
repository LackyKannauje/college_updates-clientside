import 'dart:convert';
import 'package:college_updates/model/profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../const.dart';

class ApiService {
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<ProfileModel?> fetchProfileDetails(String userId) async {
    String? token = await getToken();
    if (token == null) return null;

    final response = await http.get(Uri.parse(userBaseUrl + userId), headers: {
      'x-auth-token': token,
    });

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      return ProfileModel.fromJson(jsonBody);
    } else {
      return null;
    }
  }

  Future<List<dynamic>> fetchUsers(String userId, String listUsersOf) async {
    String? token = await getToken();
    if (token == null) return [];

    final response = await http.get(
        Uri.parse("$userBaseUrl/$userId/$listUsersOf"),
        headers: {'x-auth-token': token});

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return [];
    }
  }

  Future<String> toggleFollow(String userId, bool isFollower) async {
    String? token = await getToken();
    String followUnfollow = isFollower ? 'unfollow' : 'follow';

    final response = await http.post(
      Uri.parse("$userBaseUrl$followUnfollow/$userId"),
      headers: {'x-auth-token': token!},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonBody = jsonDecode(response.body);
      return jsonBody['msg'];
    } else {
      return 'Error';
    }
  }

  //check is follower
  Future<dynamic> checkIsfollower(String id, String userId) async {
    try {
      final followers = await fetchUsers(userId, 'followers');
      if (followers.isEmpty) {
        return false;
      }
      for (var follower in followers) {
        if (follower['_id'] == id) {
          return true;
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<dynamic>> searchUser(String searchedValue) async {
    String? token = await getToken();
    if (token == null) return [];

    final response = await http
        .get(Uri.parse("${userBaseUrl}search/${searchedValue}"), headers: {
      'x-auth-token': token,
    });

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return [];
    }
  }
}

import 'dart:convert';

import 'package:college_updates/const.dart';
import 'package:college_updates/model/post_model.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PostApiService {
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) return null;
    final isTokenExpired = JwtDecoder.isExpired(token);
    if (isTokenExpired) {
      prefs.remove('token');
      return null;
    }
    return token;
  }

  Future<List<PostModel>>? fetchPosts(String userId) async {
    String? token = await getToken();
    if (token == null) return [];

    final response = await http.get(Uri.parse("${postBaseUrl}user/$userId"),
        headers: {'x-auth-token': token});

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      print(jsonBody);
      return PostModel.fromJsonList(jsonBody);
    } else {
      return [];
    }
  }

  Future<String?> doLikePost(String postId) async {
    String? token = await getToken();
    if (token == null) return null;

    final response = await http.post(
      Uri.parse("${postBaseUrl}like/$postId"),
      headers: {'x-auth-token': token},
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      return jsonBody['message'];
    } else {
      return null;
    }
  }
}

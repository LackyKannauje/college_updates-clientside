import 'package:college_updates/auth/login.dart';
import 'package:college_updates/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String? token;
  String? id;

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  Future<void> checkAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      final isTokenExpired = JwtDecoder.isExpired(token);
      if (isTokenExpired) {
        this.token = null;
        return;
      }
      setState(() {
        id = JwtDecoder.decode(token)['user']['id'];
        this.token = token;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return token == null
        ? LoginScreen()
        : HomePage(
            id: id!,
          );
  }
}

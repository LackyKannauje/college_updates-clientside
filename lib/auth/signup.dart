// import 'dart:convert';
// import 'package:college_updates/auth/auth.dart';
// import 'package:college_updates/auth/login.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/material.dart';
// import 'package:college_updates/const.dart';
// import 'package:http/http.dart' as http;

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   bool isPasswordVisible = true;
//   TextEditingController usernameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   Future<void> signup() async {
//     try {
//       final response = await http.post(Uri.parse(signupUrl), body: {
//         "username": usernameController.text,
//         "email": emailController.text,
//         "password": passwordController.text,
//       });
//       final body = response.body;
//       final jsonBody = jsonDecode(body);
//       final token = jsonBody['token'];
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       prefs.setString('token', token);
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => AuthScreen(),
//         ),
//       );
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.black,
//       body: Column(
//         children: [
//           Expanded(
//             flex: 2,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Image.network(
//                   ssipmtImageUrl,
//                   height: 80,
//                   width: 80,
//                 ),
//                 Text(
//                   "SSIPMT Updates",
//                   style: TextStyle(
//                       fontSize: 25,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 6,
//             child: Container(
//               padding: EdgeInsets.all(15),
//               margin: EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(40),
//               ),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 30,
//                   ),
//                   Text("Sign Up",
//                       style: TextStyle(
//                           fontSize: 35,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold)),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 5,
//                           blurRadius: 7,
//                           offset: Offset(0, 3), // changes position of shadow
//                         ),
//                       ],
//                     ),
//                     margin: const EdgeInsets.all(15),
//                     child: TextField(
//                       controller: usernameController,
//                       keyboardType: TextInputType.name,
//                       decoration: InputDecoration(
//                         hintText: "Username",
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 5,
//                           blurRadius: 7,
//                           offset: Offset(0, 3), // changes position of shadow
//                         ),
//                       ],
//                     ),
//                     margin: const EdgeInsets.all(15),
//                     child: TextField(
//                       controller: emailController,
//                       keyboardType: TextInputType.emailAddress,
//                       decoration: InputDecoration(
//                         hintText: "Email",
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 5,
//                           blurRadius: 7,
//                           offset: Offset(0, 3), // changes position of shadow
//                         ),
//                       ],
//                     ),
//                     margin: const EdgeInsets.all(15),
//                     child: TextField(
//                       controller: passwordController,
//                       obscureText: isPasswordVisible,
//                       decoration: InputDecoration(
//                         hintText: "Password",
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         suffixIcon: IconButton(
//                           icon: isPasswordVisible
//                               ? Icon(Icons.visibility)
//                               : Icon(Icons.visibility_off),
//                           onPressed: () {
//                             setState(
//                               () {
//                                 isPasswordVisible = !isPasswordVisible;
//                               },
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   ElevatedButton(
//                     onPressed: () => signup(),
//                     child: Text("SignUp",
//                         style: TextStyle(fontSize: 15, color: Colors.white)),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.black,
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 50, vertical: 20),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "Already have an account? ",
//                   style: TextStyle(fontSize: 16, color: Colors.white),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => LoginScreen(),
//                       ),
//                     );
//                   },
//                   child: Text(
//                     "Login",
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.cyan,
//                       decoration: TextDecoration.underline,
//                       decorationColor: Colors.cyan,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:college_updates/auth/auth.dart';
import 'package:college_updates/auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:college_updates/const.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isPasswordVisible = true;
  bool isLoading = false; // Add loading state
  String? errorMessage; // For storing error messages
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> signup() async {
    setState(() {
      isLoading = true; // Show loading spinner
      errorMessage = null; // Reset any previous errors
    });

    try {
      final response = await http.post(Uri.parse(signupUrl), body: {
        "username": usernameController.text,
        "email": emailController.text.trim(),
        "password": passwordController.text,
      });

      final body = response.body;
      final jsonBody = jsonDecode(body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final token = jsonBody['token'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);

        // Navigate to AuthScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AuthScreen(),
          ),
        );
      } else {
        // Handle different types of errors
        setState(() {
          final error1 = jsonBody['msg'];
          final error2 = error1 ?? jsonBody['errors'][0]['msg'];
          errorMessage = error2 ?? 'An error occurred during sign-up.';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage =
            'Something went wrong. Please check your internet connection.';
      });
    } finally {
      setState(() {
        isLoading = false; // Hide loading spinner
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  ssipmtImageUrl,
                  height: 80,
                  width: 80,
                ),
                Text(
                  "SSIPMT Updates",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Text(
                      "Sign Up",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),

                    // Show error message if any
                    if (errorMessage != null)
                      Text(
                        errorMessage!,
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),

                    SizedBox(height: 10),

                    // Username Input
                    buildTextField(
                        usernameController, 'Username', TextInputType.name),

                    // Email Input
                    buildTextField(
                        emailController, 'Email', TextInputType.emailAddress),

                    // Password Input
                    buildPasswordField(),

                    SizedBox(height: 20),

                    // Show loading spinner while processing
                    if (isLoading)
                      CircularProgressIndicator()
                    else
                      ElevatedButton(
                        onPressed: () => signup(),
                        child: Text("Sign Up",
                            style:
                                TextStyle(fontSize: 15, color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.cyan,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.cyan,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // Helper method for TextFields
  Widget buildTextField(
      TextEditingController controller, String hint, TextInputType type) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      margin: const EdgeInsets.all(15),
      child: TextField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  // Helper method for Password Field with visibility toggle
  Widget buildPasswordField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      margin: const EdgeInsets.all(15),
      child: TextField(
        controller: passwordController,
        obscureText: isPasswordVisible,
        decoration: InputDecoration(
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white),
          ),
          suffixIcon: IconButton(
            icon: isPasswordVisible
                ? Icon(Icons.visibility)
                : Icon(Icons.visibility_off),
            onPressed: () {
              setState(() {
                isPasswordVisible = !isPasswordVisible;
              });
            },
          ),
        ),
      ),
    );
  }
}

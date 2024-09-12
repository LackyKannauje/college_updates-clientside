import 'dart:io';
import 'package:college_updates/auth/auth.dart';
import 'package:college_updates/const.dart';
import 'package:college_updates/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  // Controllers for text fields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  // Image variables
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  String _selectedImageSource = "";

  @override
  void dispose() {
    // Dispose controllers when not needed
    _usernameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  /// Method to pick image from gallery
  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _selectedImageSource = "Gallery";
      });
    } else {
      print("No image selected from gallery.");
    }
  }

  /// Method to pick image from camera
  Future<void> _pickImageFromCamera() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _selectedImageSource = "Camera";
      });
    } else {
      print("No image captured from camera.");
    }
  }

  /// Method to submit the profile form
  Future<void> _submitForm() async {
    final File? image = _selectedImage;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null) {
      print("Token is missing");
      return;
    }

    try {
      // Create a multipart request for file upload
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse('${userBaseUrl}profile'),
      );

      // Set headers
      request.headers['x-auth-token'] = token;

      // Set fields
      request.fields['username'] = _usernameController.text;
      request.fields['bio'] = _bioController.text;

      // Add image file if it exists
      if (image != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'profilePicture',
            image.path,
          ),
        );
      }

      // Send the request
      final http.StreamedResponse response = await request.send();

      // Handle response
      if (response.statusCode == 200) {
        final http.Response responseBody =
            await http.Response.fromStream(response);
        print("Success: ${responseBody.body}");

        // Close the dialog
        Navigator.pop(context);

        // Show success snackbar
        showSnackBar('Profile updated successfully!', context);
      } else {
        print("Error: ${response.statusCode}");
        showSnackBar('Failed to update profile.', context);
      }
    } catch (e) {
      print("Error: $e");
      showSnackBar('An error occurred. Please try again.', context);
    }
  }

  /// Method to log out the user
  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    // Navigate to AuthScreen and remove all previous routes
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const AuthScreen()),
      (route) => false,
    );
  }

  /// Method to show the edit profile dialog
  void _showEditProfileDialog() {
    showDialog(
      context: context,
      builder: (context) {
        // Use StatefulBuilder to manage dialog state
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        "Edit Profile",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    _buildTextField(
                      controller: _usernameController,
                      hint: "Username",
                      inputType: TextInputType.text,
                    ),
                    _buildTextField(
                      controller: _bioController,
                      hint: "Bio",
                      inputType: TextInputType.text,
                    ),
                    const SizedBox(height: 10),
                    _buildImagePickerOptions(setState),
                    const SizedBox(height: 25),
                    _buildSubmitButton(),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// Widget to build the image picker options
  Widget _buildImagePickerOptions(StateSetter setState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildImageOption(
          icon: Icons.upload_file_outlined,
          label: "Upload Image",
          selectedLabel: "Selected",
          isSelected: _selectedImageSource == "Gallery",
          onPressed: () async {
            await _pickImageFromGallery();
            setState(() {});
          },
        ),
        const SizedBox(width: 20),
        _buildImageOption(
          icon: Icons.add_a_photo,
          label: "Upload Camera",
          selectedLabel: "Selected",
          isSelected: _selectedImageSource == "Camera",
          onPressed: () async {
            await _pickImageFromCamera();
            setState(() {});
          },
        ),
      ],
    );
  }

  /// Widget to build each image option (Gallery or Camera)
  Widget _buildImageOption({
    required IconData icon,
    required String label,
    required String selectedLabel,
    required bool isSelected,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: 30,
            color: isSelected
                ? const Color.fromARGB(255, 205, 184, 215)
                : const Color(0xFFC683E5),
          ),
        ),
        Text(
          isSelected ? selectedLabel : label,
          style: const TextStyle(fontSize: 13),
        ),
      ],
    );
  }

  /// Widget to build a text field
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required TextInputType inputType,
  }) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  /// Widget to build the submit button
  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _submitForm,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFC683E5),
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 15,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: const Text(
        "Submit",
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  /// Widget to build a generic button used in the settings page
  Widget _buildSettingsButton({
    required VoidCallback onPressed,
    required Color color,
    required String text,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Main scaffold
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildSettingsButton(
              onPressed: _showEditProfileDialog,
              color: const Color(0xFFC683E5),
              text: "Edit Profile 📝",
            ),
            const SizedBox(height: 30),
            _buildSettingsButton(
              onPressed: () {
                // Add functionality here
                showSnackBar('Feature coming soon!', context);
              },
              color: const Color(0xFFC683E5),
              text: "Something 🤔",
            ),
            const SizedBox(height: 30),
            _buildSettingsButton(
              onPressed: _logout,
              color: Colors.redAccent,
              text: "Logout ↪️",
            ),
          ],
        ),
      ),
    );
  }
}

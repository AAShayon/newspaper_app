import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class PasswordDialog extends StatelessWidget {


  const PasswordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();
    final AuthController authController = Get.find<AuthController>();

    return AlertDialog(
      title: Text("Set Password"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Please set a password for future email/password login."),
          SizedBox(height: 16),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            final password = passwordController.text.trim();
            if (password.isNotEmpty) {
              // Call the controller to update the password
              authController.handleUpdatePassword(password).then((_) {
                Navigator.of(context).pop();
              });
            } else {
              Get.snackbar('Error', 'Password cannot be empty');
            }
          },
          child: Text("Set Password"),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnpro/controllers/auth_controller.dart';
import 'package:learnpro/screens/auth/auth_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Learn Pro'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              await prefs.clear();
              final authController = Get.find<AuthController>();
              authController.userRole.value = '';
              Get.offAll(() => AuthScreen());
            },
          ),
        ],
      ),
      body: Center(
        child: Obx(() {
          final role = authController.userRole.value;
          return role == 'instructor' ? InstructorContent() : StudentContent();
        }),
      ),
    );
  }
}

class InstructorContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text("Welcome, Instructor");
  }
}

class StudentContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text("Welcome, Student");
  }
}

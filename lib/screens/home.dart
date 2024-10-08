import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnpro/controllers/auth_controller.dart';
import 'package:learnpro/screens/instructor/home.dart';
import 'package:learnpro/screens/students/home.dart';
import 'package:learnpro/screens/auth/auth_screen.dart';

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
              await authController.logout();
            },
          ),
        ],
      ),
      body: Obx(() {
        final role = authController.userRole.value;
        if (role == 'instructor') {
          return InstructorHomeScreen();
        } else if (role == 'student') {
          return const StudentHome();
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.offAll(() => AuthScreen());
          });
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}

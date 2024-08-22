import 'package:flutter/material.dart';
import 'package:learnpro/controllers/auth/auth_controller.dart';
import 'package:learnpro/controllers/course/course_controller.dart';
import 'package:learnpro/controllers/instructor/instructor_controller.dart';
import 'package:learnpro/screens/auth/auth_screen.dart';
import 'package:get/get.dart';
import 'package:learnpro/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  runApp(MyApp(token: token));

  //register auth controller othervise app shows an error aith controllr not found
  // ("AuthController" not found. You need to call "Get.put(AuthController())" or "Get.lazyPut(()=>AuthController())")

  Get.put(AuthController());
  Get.put(CourseController());
  Get.put(InstructorController());
}

class MyApp extends StatelessWidget {
  final String? token;
  const MyApp({super.key, this.token});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'LearnPro',
      home: token == null ? AuthScreen() : HomeScreen(),
    );
  }
}

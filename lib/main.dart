import 'package:flutter/material.dart';
import 'package:learnpro/controllers/auth_controller.dart';
import 'package:learnpro/controllers/course_controller.dart';
import 'package:learnpro/controllers/instructor_controller.dart';
import 'package:learnpro/screens/auth/auth_screen.dart';
import 'package:get/get.dart';
import 'package:learnpro/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

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
    const Color appColor = Colors.blue;
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: appColor,
        statusBarIconBrightness:
            Brightness.light,
      ),
    );
    return SafeArea(
      child: GetMaterialApp(
        title: 'LearnPro',
        home: token == null ? AuthScreen() : HomeScreen(),
      ),
    );
  }
}

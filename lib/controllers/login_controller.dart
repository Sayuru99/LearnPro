import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:learnpro/controllers/auth_controller.dart';
import 'package:learnpro/screens/home.dart';
import 'package:learnpro/screens/utils/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> loginUser() async {
    try {
      var headers = {'content-type': 'application/json'};
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.loginUser);
      Map body = {
        'email': emailController.text,
        'password': passwordController.text
      };

      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['status'] == 'success') {
          var token = json['token'];
          var role = json['user']['role'];

          final SharedPreferences prefs = await _prefs;
          await prefs.setString('token', token);
          await prefs.setString('role', role);
          final authController = Get.find<AuthController>();
          authController.userRole.value = role;

          emailController.clear();
          passwordController.clear();
          Get.offAll(() => HomeScreen());
        } else {
          throw jsonDecode(response.body)["message"] ?? "Unknown Error";
        }
      } else {
        throw jsonDecode(response.body)["message"] ?? "Unknown Error";
      }
    } catch (e) {
      print(e);
      Get.back();
      showDialog(
        context: Get.context!,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Error'),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(e.toString()),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('OK'),
              )
            ],
          );
        },
      );
    }
  }
}

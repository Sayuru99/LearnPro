import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:learnpro/screens/home.dart';
import 'package:learnpro/screens/utils/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final RxBool passwordStrong = false.obs;

  void validatePass(String password) {
    final bool hasUpperCase = password.contains(RegExp(r'[A-Z]'));
    final bool hasLowerCase = password.contains(RegExp(r'[a-z]'));
    final bool hasDigit = password.contains(RegExp(r'\d'));

    passwordStrong.value =
        hasUpperCase && hasLowerCase && hasDigit && password.length >= 8;
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> regUser() async {
    try {
      validatePass(passwordController.text);

      if (!passwordStrong.value) {
        Get.snackbar('Password Error', "Example Password: 'Abc12345'");
        return;
      }
      var headers = {'content-type': 'application/json'};
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.registerUser);
      Map body = {
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text
      };

      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['status'] == 'success') {
          var token = json['token'];

          final SharedPreferences prefs = await _prefs;
          await prefs.setString('token', token);

          nameController.clear();
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

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:learnpro/screens/utils/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> regUser() async {
    try {
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
          print(token);

          final SharedPreferences prefs = await _prefs;
          await prefs.setString('token', token);
          nameController.clear();
          emailController.clear();
          passwordController.clear();
        } else {
          throw jsonDecode(response.body)["message"] ?? "Unkown Error";
        }
      } else {
        throw jsonDecode(response.body)["message"] ?? "Unkown Error";
      }
    } catch (e) {
      print(e);
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(e.toString()),
                ),
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('OK'))
              ],
            );
          });
    }
  }
}

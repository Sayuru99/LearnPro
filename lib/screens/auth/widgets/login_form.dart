import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnpro/controllers/login_controller.dart';
import 'package:learnpro/screens/auth/widgets/input_fields.dart';
import 'package:learnpro/screens/auth/widgets/submit_button.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());

    return Column(
      children: [
        InputField(
          controller: loginController.emailController,
          label: 'Email',
        ),
        InputField(
          controller: loginController.passwordController,
          label: 'Password',
          obscureText: true,
        ),
        SizedBox(height: 20),
        SubmitButton(
          label: 'Login',
          onPressed: () => loginController.loginUser(),
        ),
      ],
    );
  }
}

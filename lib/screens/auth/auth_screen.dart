import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnpro/controllers/auth_controller.dart';
import 'package:learnpro/screens/auth/widgets/login_form.dart';
import 'package:learnpro/screens/auth/widgets/reg_form.dart';

class AuthScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GetBuilder<AuthController>(
          builder: (controller) => Center(
            child: Text(controller.isLogin.value ? 'Login' : 'Register'),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/bee.png',
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 20),
            GetBuilder<AuthController>(
              builder: (controller) =>
                  controller.isLogin.value ? LoginForm() : RegistrationForm(),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => authController.toggleAuthMode(),
              child: Text(authController.isLogin.value
                  ? "Don't have an account? Register"
                  : "Already have an account? Login"),
            ),
          ],
        ),
      ),
    );
  }
}

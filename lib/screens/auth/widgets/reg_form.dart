import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnpro/controllers/reg_controller.dart';
import 'package:learnpro/screens/auth/widgets/input_fields.dart';
import 'package:learnpro/screens/auth/widgets/submit_button.dart';

class RegistrationForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RegistrationController regController =
        Get.put(RegistrationController());

    return Column(
      children: [
        InputField(
          controller: regController.nameController,
          label: 'Name',
        ),
        InputField(
          controller: regController.emailController,
          label: 'Email',
        ),
        GetBuilder<RegistrationController>(
          builder: (controller) => InputField(
            controller: regController.passwordController,
            label: 'Password',
            obscureText: true,
          ),
        ),
        const SizedBox(height: 20),
        GetBuilder<RegistrationController>(
          builder: (controller) => controller.passwordStrong.value
              ? SubmitButton(
                  label: 'Register',
                  onPressed: () => regController.regUser(),
                )
              : Container(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    'Password is not strong enough',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
        ),
      ],
    );
  }
}

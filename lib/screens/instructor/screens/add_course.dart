import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnpro/controllers/instructor_controller.dart';
import 'package:learnpro/screens/instructor/screens/widgets/inout_fields.dart';
import 'package:learnpro/screens/instructor/screens/widgets/button.dart';

class AddCourse extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final InstructorController instructorController =
      Get.find<InstructorController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Course'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(
              controller: titleController,
              label: 'Course Title',
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: categoryController,
              label: 'Course Category',
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: descriptionController,
              label: 'Course Description',
            ),
            const SizedBox(height: 20),
            CustomElevatedButton(
              onPressed: () async {
                await instructorController.addCourse(
                  titleController.text,
                  categoryController.text,
                  descriptionController.text,
                );
                Get.back();
              },
              label: 'Add Course',
            ),
          ],
        ),
      ),
    );
  }
}

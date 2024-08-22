import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnpro/controllers/instructor/instructor_controller.dart';

class AddCourseScreen extends StatelessWidget {
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
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Course Title'),
            ),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: 'Course Category'),
            ),
            TextField(
              controller: descriptionController,
              decoration:
                  const InputDecoration(labelText: 'Course Description'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await instructorController.addCourse(
                  titleController.text,
                  categoryController.text,
                  descriptionController.text,
                );
                Get.back();
              },
              child: const Text('Add Course'),
            ),
          ],
        ),
      ),
    );
  }
}

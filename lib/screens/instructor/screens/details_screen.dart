import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnpro/controllers/instructor/instructor_controller.dart';
import 'package:learnpro/models/course.dart';

class CourseDetailsScreen extends StatelessWidget {
  final Course course;
  final InstructorController instructorController =
      Get.find<InstructorController>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  CourseDetailsScreen({required this.course}) {
    titleController.text = course.title;
    categoryController.text = course.category;
    descriptionController.text = course.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Course Title'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: 'Course Category'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: descriptionController,
              decoration:
                  const InputDecoration(labelText: 'Course Description'),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    instructorController.updateCourse(
                      course.id,
                      titleController.text,
                      categoryController.text,
                      descriptionController.text,
                    );
                    Get.back();
                  },
                  child: const Text('Update Course'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    instructorController.deleteCourse(course.id);
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Delete Course'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

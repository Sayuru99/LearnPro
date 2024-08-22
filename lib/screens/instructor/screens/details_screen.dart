import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnpro/controllers/instructor_controller.dart';
import 'package:learnpro/models/course.dart';
import 'package:learnpro/screens/instructor/screens/widgets/button.dart';
import 'package:learnpro/screens/instructor/screens/widgets/inout_fields.dart';

class CourseDetails extends StatelessWidget {
  final Course course;
  final InstructorController instructorController =
      Get.find<InstructorController>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  CourseDetails({required this.course}) {
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
            const SizedBox(height: 16),
            Row(
              children: [
                CustomElevatedButton(
                  onPressed: () {
                    instructorController.updateCourse(
                      course.id,
                      titleController.text,
                      categoryController.text,
                      descriptionController.text,
                    );
                    Get.back();
                  },
                  label: 'Update Course',
                ),
                const SizedBox(width: 16),
                CustomElevatedButton(
                  onPressed: () {
                    instructorController.deleteCourse(course.id);
                    Get.back();
                  },
                  label: 'Delete Course',
                  color: Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

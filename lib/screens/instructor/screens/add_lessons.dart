import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnpro/controllers/course_controller.dart';
import 'package:learnpro/controllers/instructor_controller.dart';
import 'package:learnpro/screens/instructor/screens/widgets/button.dart';
import 'package:learnpro/screens/instructor/screens/widgets/inout_fields.dart';

class AddLesson extends StatelessWidget {
  final CourseController courseController = Get.find<CourseController>();
  final InstructorController instructorController =
      Get.find<InstructorController>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Lesson'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() {
              if (courseController.isLoading.value) {
                return const CircularProgressIndicator();
              }

              return DropdownButtonFormField<int>(
                decoration: const InputDecoration(labelText: 'Select Course'),
                value: courseController.selectedCourse.value?.id,
                items: courseController.courses.map((course) {
                  return DropdownMenuItem<int>(
                    value: course.id,
                    child: Text(course.title),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    courseController.fetchCourseDetails(value);
                  }
                },
              );
            }),
            const SizedBox(height: 16),
            CustomTextField(
              controller: titleController,
              label: 'Lesson Title',
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: descriptionController,
              label: 'Lesson Description',
            ),
            const SizedBox(height: 20),
            CustomElevatedButton(
              onPressed: () {},
              label: 'Add Lesson',
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}

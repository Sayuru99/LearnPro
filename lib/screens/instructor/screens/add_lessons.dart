import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnpro/controllers/course/course_controller.dart';
import 'package:learnpro/controllers/instructor/instructor_controller.dart';

class AddLessonScreen extends StatelessWidget {
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
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Lesson Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration:
                  const InputDecoration(labelText: 'Lesson Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Add Lesson'),
            ),
          ],
        ),
      ),
    );
  }
}

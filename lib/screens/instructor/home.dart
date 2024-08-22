import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnpro/controllers/course/course_controller.dart';
import 'package:learnpro/controllers/instructor/instructor_controller.dart';
import 'package:learnpro/models/course.dart';
import 'package:learnpro/screens/instructor/screens/add_course.dart';
import 'package:learnpro/screens/instructor/screens/add_lessons.dart';
import 'package:learnpro/screens/instructor/screens/details_screen.dart';

class InstructorHomeScreen extends StatelessWidget {
  final InstructorController instructorController =
      Get.put(InstructorController());
  final CourseController courseController = Get.put(CourseController());

  Future<void> _refreshData() async {
    await instructorController.fetchCourses();
    await courseController.fetchCourses();
  }

  @override
  Widget build(BuildContext context) {
    instructorController.fetchCourses();
    courseController.fetchCourses();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Instructor Dashboard'),
      ),
      body: Obx(() {
        if (instructorController.isLoading.value ||
            courseController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        List<Course> instructorCourses = instructorController.courses
            .where((course) =>
                course.instructorId == instructorController.instructorId.value)
            .toList();

        if (instructorCourses.isEmpty) {
          return const Center(child: Text('No courses found.'));
        }

        return RefreshIndicator(
          onRefresh: _refreshData,
          child: ListView(
            children: [
              ListTile(
                title: const Text('Add New Course'),
                leading: const Icon(Icons.add),
                onTap: () {
                  Get.to(() => AddCourseScreen())?.then((_) => _refreshData());
                },
              ),
              ListTile(
                title: const Text('Add New Lesson'),
                leading: const Icon(Icons.add),
                onTap: () {
                  Get.to(() => AddLessonScreen())?.then((_) => _refreshData());
                },
              ),
              ...instructorCourses.map((course) {
                return ListTile(
                  title: Text(course.title),
                  subtitle: Text(course.description),
                  onTap: () {
                    Get.to(() => CourseDetailsScreen(course: course));
                  },
                );
              }),
            ],
          ),
        );
      }),
    );
  }
}

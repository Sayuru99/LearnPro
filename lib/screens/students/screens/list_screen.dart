import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnpro/controllers/course/course_controller.dart';
import 'package:learnpro/screens/students/screens/course_details.dart';

class CourseListScreen extends StatelessWidget {
  final String category;

  CourseListScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    final CourseController courseController = Get.find<CourseController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Courses in $category'),
      ),
      body: Obx(() {
        if (courseController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        final courses = courseController.categories[category] ?? [];

        if (courses.isEmpty) {
          return Center(child: Text('No courses available in this category.'));
        }

        return ListView.builder(
          itemCount: courses.length,
          itemBuilder: (context, index) {
            final course = courses[index];
            return ListTile(
              title: Text(course.title),
              subtitle: Text(course.description),
              onTap: () {
                Get.to(() => CourseDetailScreen(courseId: course.id));
              },
            );
          },
        );
      }),
    );
  }
}

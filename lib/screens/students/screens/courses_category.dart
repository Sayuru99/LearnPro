import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnpro/controllers/course_controller.dart';
import 'package:learnpro/screens/students/screens/widgets/course_card.dart';

class CoursesByCategory extends StatelessWidget {
  final String category;

  const CoursesByCategory({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final CourseController courseController = Get.find<CourseController>();
    final courses = courseController.coursesByCategory[category] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Courses in $category'),
      ),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return CourseCard(course: course); // Use custom course card widget
        },
      ),
    );
  }
}

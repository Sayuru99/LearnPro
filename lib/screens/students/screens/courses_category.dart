import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnpro/controllers/course/course_controller.dart';
import 'package:learnpro/screens/students/screens/course_details.dart';

class CoursesByCategoryScreen extends StatelessWidget {
  final String category;

  CoursesByCategoryScreen({required this.category});

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
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(course.title),
              subtitle: Text(
                  'Instructor: ${course.instructor.name}\n${course.description}'),
              onTap: () {
                Get.to(() => CourseDetailScreen(courseId: course.id));
              },
            ),
          );
        },
      ),
    );
  }
}

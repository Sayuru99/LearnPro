import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnpro/screens/students/screens/course_details.dart';
import 'package:learnpro/models/course.dart';

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(course.title),
        subtitle: Text(
          'Instructor: ${course.instructor.name}\n${course.description}',
        ),
        onTap: () {
          Get.to(() => CourseDetail(courseId: course.id));
        },
      ),
    );
  }
}

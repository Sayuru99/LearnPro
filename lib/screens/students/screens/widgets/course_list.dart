import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnpro/screens/students/screens/course_details.dart';
import 'package:learnpro/models/course.dart';

class CourseListTile extends StatelessWidget {
  final Course course;

  const CourseListTile({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(course.title),
      subtitle: Text(course.description),
      onTap: () {
        Get.to(() => CourseDetail(courseId: course.id));
      },
    );
  }
}

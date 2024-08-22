import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnpro/controllers/course_controller.dart';

class CourseDetail extends StatelessWidget {
  final int courseId;

  CourseDetail({required this.courseId});

  @override
  Widget build(BuildContext context) {
    final CourseController courseController = Get.find<CourseController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Course Details'),
      ),
      body: FutureBuilder(
        future: courseController.fetchCourseDetails(courseId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final course = courseController.selectedCourse.value;

          if (course == null) {
            return Center(child: Text('Course not found.'));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  course.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(course.description),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Instructor: ${course.instructor.name}'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: course.lessons.length,
                  itemBuilder: (context, index) {
                    final lesson = course.lessons[index];
                    return ListTile(
                      title: Text(lesson.title),
                      subtitle: Text(lesson.content),
                      onTap: () {},
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

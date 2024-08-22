import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnpro/controllers/course/course_controller.dart';
import 'package:learnpro/screens/students/screens/courses_category.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CourseController courseController = Get.find<CourseController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: Obx(() {
        if (courseController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        final categories = courseController.coursesByCategory.keys.toList();

        return ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return ListTile(
              title: Text(category),
              onTap: () {
                Get.to(() => CoursesByCategoryScreen(category: category));
              },
            );
          },
        );
      }),
    );
  }
}

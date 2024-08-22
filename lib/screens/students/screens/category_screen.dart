import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnpro/controllers/course_controller.dart';
import 'package:learnpro/screens/students/screens/courses_category.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CourseController courseController = Get.find<CourseController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Categories'),
      ),
      body: Obx(() {
        if (courseController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final categories = courseController.coursesByCategory.keys.toList();

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 1.0,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return GestureDetector(
              onTap: () {
                Get.to(() => CoursesByCategory(category: category));
              },
              child: Card(
                elevation: 4.0,
                child: Center(
                  child: Text(
                    category,
                    style: const TextStyle(fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

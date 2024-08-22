// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:learnpro/screens/utils/api_endpoints.dart';
// import 'package:learnpro/models/lesson.dart';
// import 'package:learnpro/models/course.dart';

// class CourseDetailsController extends GetxController {
//   var course = Course(
//     id: 0,
//     instructorId: 0,
//     title: '',
//     category: '',
//     description: '',
//     createdAt: DateTime.now(),
//     updatedAt: DateTime.now(),
//     instructor: Instructor(id: 0, name: ''),
//     lessons: [],
//   ).obs;
//   var isLoading = true.obs;
//   var errorMessage = ''.obs;

//   Future<void> fetchCourse(int courseId) async {
//     try {
//       isLoading(true);
//       var url = Uri.parse('${ApiEndPoints.baseUrl}/courses/$courseId');
//       var response = await http.get(url);

//       if (response.statusCode == 200) {
//         var jsonResponse = jsonDecode(response.body);
//         course.value = Course.fromJson(jsonResponse);
//       } else {
//         throw 'Failed to load course';
//       }
//     } catch (e) {
//       errorMessage.value = e.toString();
//     } finally {
//       isLoading(false);
//     }
//   }

//   Future<void> fetchLessons(int courseId) async {
//     try {
//       var url = Uri.parse('${ApiEndPoints.baseUrl}/courses/$courseId/lessons');
//       var response = await http.get(url);

//       if (response.statusCode == 200) {
//         List jsonResponse = jsonDecode(response.body);
//         course.update((course) {
//           course!.lessons =
//               jsonResponse.map((data) => Lesson.fromJson(data)).toList();
//         });
//       } else {
//         throw 'Failed to load lessons';
//       }
//     } catch (e) {
//       errorMessage.value = e.toString();
//     }
//   }
// }

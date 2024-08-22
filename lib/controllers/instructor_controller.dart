import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:learnpro/models/course.dart';
import 'package:learnpro/screens/utils/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InstructorController extends GetxController {
  var isLoading = true.obs;
  var courses = <Course>[].obs;
  var instructorId = 0.obs;

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> addCourse(
      String title, String category, String description) async {
    isLoading.value = true;
    try {
      final token = await _getToken();
      final url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.instructorEndPoints.addCourse);
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'title': title,
          'category': category,
          'description': description,
        }),
      );

      if (response.statusCode == 201) {
        await fetchCourses();
      } else {
        throw 'Failed to create a course';
      }
    } catch (e) {
      // print('Error creating courses $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchUserDetails() async {
    isLoading.value = true;
    try {
      final token = await _getToken();
      final url =
          Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.authUser);

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        instructorId.value = data['id'];
      } else {
        throw 'Failed to get user details';
      }
    } catch (e) {
      // print('Error getting user details $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCourses() async {
    isLoading.value = true;
    try {
      await fetchUserDetails();
      final token = await _getToken();
      final url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.courseEndPoints.courses);

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        courses.value = data.map((json) => Course.fromJson(json)).toList();
      } else {
        throw 'Failed to load courses';
      }
    } catch (e) {
      // print('Error getting courses $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateCourse(
      int courseId, String title, String category, String description) async {
    isLoading.value = true;
    try {
      final token = await _getToken();
      final url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.instructorEndPoints.updateCourse);
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'title': title,
          'category': category,
          'description': description,
        }),
      );

      if (response.statusCode != 200) {
        throw 'Failed to update course';
      }
    } catch (e) {
      // print('Error updating course $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteCourse(int courseId) async {
    isLoading.value = true;
    try {
      final token = await _getToken();
      final url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.instructorEndPoints.deleteCourse);
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        throw 'Failed to delete course';
      }
    } catch (e) {
      // print('Error deleting course $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addLesson(int courseId, String title, String description) async {
    isLoading.value = true;
    try {
      final token = await _getToken();
      final url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.instructorEndPoints.addLesson);
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'courseId': courseId,
          'title': title,
          'description': description,
        }),
      );

      if (response.statusCode == 201) {
        await fetchCourses();
      } else {
        throw 'Failed to create lesson';
      }
    } catch (e) {
      // print('Error createing lesson$e');/
    } finally {
      isLoading.value = false;
    }
  }
}

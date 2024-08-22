import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:learnpro/screens/utils/api_endpoints.dart';
import 'package:learnpro/models/course.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CourseController extends GetxController {
  var courses = <Course>[].obs;
  var isLoading = true.obs;
  var selectedCourse = Rxn<Course>();
  var categories = <String, List<Course>>{}.obs;

  Map<String, List<Course>> get coursesByCategory {
    final Map<String, List<Course>> groupedCourses = {};
    for (var course in courses) {
      if (!groupedCourses.containsKey(course.category)) {
        groupedCourses[course.category] = [];
      }
      groupedCourses[course.category]?.add(course);
    }
    return groupedCourses;
  }

  @override
  void onInit() {
    super.onInit();
    fetchCourses();
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> fetchCourses() async {
    try {
      final token = await _getToken();
      final url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.courseEndPoints.courses);

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        courses.value = data.map((json) => Course.fromJson(json)).toList();
      } else {
        throw 'Failed to load courses';
      }
    } catch (e) {
      print('Error fetching courses: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCourseDetails(int courseId) async {
    try {
      final token = await _getToken();
      final url = Uri.parse(
          '${ApiEndPoints.baseUrl}${ApiEndPoints.courseEndPoints.courses}/$courseId');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        selectedCourse.value = Course.fromJson(jsonDecode(response.body));
      } else {
        throw 'Failed to load course details';
      }
    } catch (e) {
      print('Error fetching course details: $e');
    }
  }
}

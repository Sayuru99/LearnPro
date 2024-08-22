import 'package:json_annotation/json_annotation.dart';
import 'lesson.dart';
import 'instructor.dart';

part 'course.g.dart';

@JsonSerializable()
class Course {
  final int id;
  final int instructorId;
  final String title;
  final String category;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Instructor instructor;
  final List<Lesson> lessons;

  Course({
    required this.id,
    required this.instructorId,
    required this.title,
    required this.category,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.instructor,
    required this.lessons,
  });

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
  Map<String, dynamic> toJson() => _$CourseToJson(this);
}

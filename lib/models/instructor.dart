import 'package:json_annotation/json_annotation.dart';

part 'instructor.g.dart';

@JsonSerializable()
class Instructor {
  final int id;
  final String name;
  final String role;
  final String email;
  final DateTime? emailVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  Instructor({
    required this.id,
    required this.name,
    required this.role,
    required this.email,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Instructor.fromJson(Map<String, dynamic> json) =>
      _$InstructorFromJson(json);
  Map<String, dynamic> toJson() => _$InstructorToJson(this);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instructor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Instructor _$InstructorFromJson(Map<String, dynamic> json) => Instructor(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      role: json['role'] as String,
      email: json['email'] as String,
      emailVerifiedAt: json['email_verified_at'] == null
          ? null
          : DateTime.parse(json['email_verified_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$InstructorToJson(Instructor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'role': instance.role,
      'email': instance.email,
      'email_verified_at': instance.emailVerifiedAt?.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

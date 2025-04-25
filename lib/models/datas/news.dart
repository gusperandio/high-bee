import 'package:uuid/uuid.dart';

class NewsModel {
  final String? id;
  final String title;
  final String argument;
  final List<String> tags;
  final String userId;
  final bool important;
  final int? minReads;
  final bool aiValidate;
  final String cape;
  final String? photo1;
  final String? photo1desc;
  final String? photo2;
  final String? photo2desc;
  final String? photo3;
  final String? photo3desc;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int likes;
  final String font; // New attribute

  NewsModel({
    this.id,
    required this.title,
    required this.argument,
    required this.tags,
    required this.userId,
    required this.important,
    this.minReads,
    this.aiValidate = false,
    required this.cape,
    this.photo1,
    this.photo1desc,
    this.photo2,
    this.photo2desc,
    this.photo3,
    this.photo3desc,
    required this.createdAt,
    required this.updatedAt,
    this.likes = 0, 
    required this.font, 
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'argument': argument,
      'tags': tags,
      'userId': userId,
      'important': important,
      'minReads': minReads,
      'aiValidate': aiValidate,
      'cape': cape,
      'photo1': photo1,
      'photo1desc': photo1desc,
      'photo2': photo2,
      'photo2desc': photo2desc,
      'photo3': photo3,
      'photo3desc': photo3desc,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'likes': likes, // Include likes in toJson
      'font': font, // Include font in toJson
    };
  }

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'],
      title: json['title'],
      argument: json['argument'],
      tags: List<String>.from(json['tags']),
      userId: json['userId'],
      important: json['important'],
      minReads: json['minReads'],
      aiValidate: json['aiValidate'],
      cape: json['cape'],
      photo1: json['photo1'],
      photo1desc: json['photo1desc'],
      photo2: json['photo2'],
      photo2desc: json['photo2desc'],
      photo3: json['photo3'],
      photo3desc: json['photo3desc'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      likes: json['likes'] ?? 0, 
      font: json['font'], 
    );
  }
}

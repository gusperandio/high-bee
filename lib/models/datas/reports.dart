import 'package:uuid/uuid.dart';

class ReportModel {
  final String id;
  final String idNews;
  final String userId;
  final String argument;

  ReportModel({id, required this.idNews,
    required this.userId, required this.argument})
    : id = id ?? Uuid().v4();

  Map<String, dynamic> toJson() => {
    'id': id,
    'idNews': idNews,
    'userId': userId,
    'argument': argument,
  };

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'],
      idNews: json['idNews'],
      userId: json['userId'],
      argument: json['argument'],
    );
  }
}

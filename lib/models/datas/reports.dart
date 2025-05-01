class ReportModel {
  final String? id;
  final String newsId;
  final String userId;
  final String reason;
  final String createdAt;

  ReportModel({
    this.id,
    required this.newsId,
    required this.userId,
    required this.reason,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'newsId': newsId,
    'userId': userId,
    'reason': reason,
    'createdAt': createdAt,
  };

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'] ?? "",
      newsId: json['newsId'] ?? "",
      userId: json['userId'] ?? "",
      reason: json['reason'] ?? "",
      createdAt: json['createdAt'] ?? "",
    );
  }
}

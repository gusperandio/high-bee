import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:high_bee/models/datas/news.dart';
import 'package:high_bee/models/datas/user.dart';
import 'package:high_bee/services/auth/auth_service.dart';
import 'package:high_bee/services/user/user_service.dart';
import 'package:uuid/uuid.dart';

class NewsService {
  static final NewsService _instance = NewsService._internal();

  factory NewsService() {
    return _instance;
  }

  NewsService._internal();

  final _db = FirebaseDatabase.instance;

  Future<List<NewsModel>?> fetchAllNews() async {
   final snapshot =
        await _db.ref('news').orderByChild('createdAt').limitToLast(20).get();


    if (!snapshot.exists) return [];

    final newsList = <NewsModel>[];

    final data = snapshot.value as Map;
    for (var entry in data.entries) {
      final news = NewsModel.fromJson(Map<String, dynamic>.from(entry.value));
      newsList.add(news);
    }

    return newsList.reversed.toList();
  }

  Future<void> createNews(NewsModel news) async {
    await _db.ref('news/${news.id}').set(news.toJson());
  }

  Future<void> updateNews(NewsModel news) async {
    final snapshot = await _db.ref('news/${news.id}/userId').get();
    if (snapshot.exists && snapshot.value == UserService().uid) {
      await _db.ref('news/${news.id}').update(news.toJson());
    } else {
      throw Exception('Acesso negado: você não é o autor.');
    }
  }

  Future<void> deleteNews(String newsId) async {
    final snapshot = await _db.ref('news/$newsId/userId').get();
    if (snapshot.exists && snapshot.value == UserService().uid) {
      await _db.ref('news/$newsId').remove();
    } else {
      throw Exception('Acesso negado: você não é o autor.');
    }
  }
}

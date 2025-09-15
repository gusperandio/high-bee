import 'package:firebase_database/firebase_database.dart';
import 'package:high_bee/infra/models/datas/news.dart'; 
import 'package:high_bee/services/user/user_service.dart'; 

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
      news.id = entry.key;
      newsList.add(news);
    }

    return newsList.reversed.toList();
  }

  Future<void> createNews(NewsModel news, String userId) async {
    final newsRef = _db.ref('news').push();
    final id = newsRef.key!;
    await newsRef.set(news.toJson());

    final userNewsRef = _db.ref('users/$userId/news');
    final snapshot = await userNewsRef.get();

    final newsList =
        snapshot.exists && snapshot.value is List
            ? List<String>.from(snapshot.value as List)
            : <String>[];

    if (!newsList.contains(id)) {
      newsList.add(id);
      await userNewsRef.set(newsList);
    }
  }

  // Future<void> updateNews(NewsModel news) async {
  //   final snapshot = await _db.ref('news/${news.id}/userId').get();
  //   if (snapshot.exists && snapshot.value == UserService().userId) {
  //     await _db.ref('news/${news.id}').update(news.toJson());
  //   } else {
  //     throw Exception('Acesso negado: você não é o autor.');
  //   }
  // }

  Future<void> deleteNews(String newsId) async {
    final snapshot = await _db.ref('news/$newsId/userId').get();
    if (snapshot.exists && snapshot.value == UserService().userId) {
      await _db.ref('news/$newsId').remove();
    } else {
      throw Exception('Acesso negado: você não é o autor.');
    }
  }
}

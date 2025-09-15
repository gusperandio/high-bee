import 'package:high_bee/infra/models/infra/cache_model.dart'; 

abstract class ICacheRepository {
  Future<dynamic> rememberCallback<T>(
    String id,
    Future<T> Function() callback, {
    T Function(Map<String, dynamic> json)? fromJson,
    T Function(List<dynamic> json)? fromJsonToList,
    int addMinutes = 0,
    int addHour = 0,
    int addDays = 0,
    int addMonth = 0,
    int addYear = 1,
    String? tag,
  });

  Future<void> set<T>(
    String id,
    T value, {
    int addMinutes = 0,
    int addHour = 0,
    int addDays = 0,
    int addMonth = 0,
    int addYear = 1,
    String? tag,
  });

  Future<dynamic> get<T>(
    String id, {
    T Function(Map<String, dynamic> json)? fromJson,
    T Function(List<dynamic> json)? fromJsonToList,
  });

  Future<void> update<T>(
    String id,
    T value, {
    int addMinutes = 0,
    int addHour = 0,
    int addDays = 0,
    int addMonth = 0,
    int addYear = 1,
    String? tag,
  });

  Future<void> delete(String id);

  Future<List<CacheModel>> listAll<T>();
}

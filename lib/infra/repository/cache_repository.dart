import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:high_bee/domain/interfaces/cache_interface.dart';
import 'package:high_bee/infra/models/infra/cache_model.dart';
import 'package:high_bee/util/cache.dart'; 
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cache_repository.g.dart';

@riverpod
CacheRepository cacheRepository(Ref ref) {
  return CacheRepository();
}

class CacheRepository implements ICacheRepository {
  @override
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
  }) => Cache.rememberCallback(
    id,
    callback,
    fromJson: fromJson,
    fromJsonToList: fromJsonToList,
    addMinutes: addMinutes,
    addHour: addHour,
    addDays: addDays,
    addMonth: addMonth,
    addYear: addYear,
    tag: tag,
  );

  @override
  Future<void> set<T>(
    String id,
    T value, {
    int addMinutes = 0,
    int addHour = 0,
    int addDays = 0,
    int addMonth = 0,
    int addYear = 1,
    String? tag,
  }) => Cache.set(
    id,
    value,
    addMinutes: addMinutes,
    addHour: addHour,
    addDays: addDays,
    addMonth: addMonth,
    addYear: addYear,
    tag: tag,
  );

  @override
  Future<dynamic> get<T>(
    String id, {
    T Function(Map<String, dynamic> json)? fromJson,
    T Function(List<dynamic> json)? fromJsonToList,
  }) => Cache.get(id, fromJson: fromJson, fromJsonToList: fromJsonToList);

  @override
  Future<void> update<T>(
    String id,
    T value, {
    int addMinutes = 0,
    int addHour = 0,
    int addDays = 0,
    int addMonth = 0,
    int addYear = 1,
    String? tag,
  }) => Cache.update(
    id,
    value,
    addMinutes: addMinutes,
    addHour: addHour,
    addDays: addDays,
    addMonth: addMonth,
    addYear: addYear,
    tag: tag,
  );

  @override
  Future<void> delete(String id) => Cache.delete(id);

  @override
  Future<List<CacheModel>> listAll<T>() => Cache.listAll();
}

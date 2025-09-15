import 'dart:convert';  
import 'package:high_bee/infra/models/infra/cache_model.dart';
import 'package:high_bee/infra/singletons/database_singleton.dart'; 
import 'package:sqflite/sqflite.dart'; 

class Cache {
  static Future<dynamic> rememberCallback<T>(
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
  }) async {
    dynamic dataCache = await get<T>(
      id,
      fromJson: fromJson,
      fromJsonToList: fromJsonToList,
    );
    if (dataCache != null) {
      return dataCache;
    }

    dataCache = await callback();
    if (dataCache == null) return dataCache;

    await set<T>(
      id,
      dataCache,
      addMinutes: addMinutes,
      addHour: addHour,
      addDays: addDays,
      addMonth: addMonth,
      addYear: addYear,
    );
    return dataCache;
  }

  static Future<void> set<T>(
    String id,
    T value, {
    int addMinutes = 0,
    int addHour = 0,
    int addDays = 0,
    int addMonth = 0,
    int addYear = 1,
    String? tag,
  }) async {
    final db = await DatabaseSingleton.instance.database;
    // Volta para o default de 1 ano caso algum outro valor for passado
    if ((addMinutes != 0 || addHour != 0 || addDays != 0 || addMonth != 0) &&
        addYear == 1) {
      addYear = 0;
    }
    DateTime exp = _mountExp(addMinutes, addHour, addDays, addMonth, addYear);

    CacheModel data = CacheModel(
      id: id,
      value: jsonEncode(value),
      exp: exp,
      tag: tag,
    );
    await db.insert(
      'cache',
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<dynamic> get<T>(
    String id, {
    T Function(Map<String, dynamic> json)? fromJson,
    T Function(List<dynamic> json)? fromJsonToList,
  }) async {
    final db = await DatabaseSingleton.instance.database;
    final List<Map<String, Object?>> result = await db.query(
      'cache',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (!result.isNotEmpty) return null;

    Map<String, Object?> row = result.first;
    // Verificação da data de validade do cache
    DateTime exp = DateTime.parse(row['exp'] as String);
    if (DateTime.now().isAfter(exp)) {
      delete(id);
      return null;
    }

    String valueString = row['value'] as String;
    try {
      dynamic dynamicValue = jsonDecode(valueString);
      if (dynamicValue is List) {
        return fromJsonToList != null
            ? fromJsonToList(dynamicValue)
            : dynamicValue;
      }
      return fromJson != null ? fromJson(dynamicValue) : dynamicValue;
    } catch (err) {
      return valueString;
    }
  }

  static Future<void> update<T>(
    String id,
    T value, {
    int addMinutes = 0,
    int addHour = 0,
    int addDays = 0,
    int addMonth = 0,
    int addYear = 1,
    String? tag,
  }) async {
    // Get a reference to the database.
    final db = await DatabaseSingleton.instance.database;
    // Volta para o default de 1 ano caso algum outro valor for passado
    if ((addMinutes != 0 || addHour != 0 || addDays != 0 || addMonth != 0) &&
        addYear == 1) {
      addYear = 0;
    }
    DateTime exp = _mountExp(addMinutes, addHour, addDays, addMonth, addYear);
    CacheModel data = CacheModel(
      id: id,
      value: jsonEncode(value),
      exp: exp,
      tag: tag,
    );
    await db.update('cache', data.toMap(), where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> delete(String id) async {
    // Get a reference to the database.
    final db = await DatabaseSingleton.instance.database;

    await db.delete('cache', where: 'id = ?', whereArgs: [id]);
  }

  // Este método retorna todos os dados do cache mesmo estando vencidos e também não remove dados vencidos,
  // então cuidado ao utilizar.
  // Recomendado utilizar sempre o método get para recuperação de dados direto
  static Future<List<CacheModel>> listAll<T>() async {
    final db = await DatabaseSingleton.instance.database;
    final List<Map<String, Object?>> result = await db.query('cache');

    return [
      for (final Map<String, Object?> map in result)
        CacheModel(
          id: map['id'] as String,
          value: map['value'] as String,
          exp: DateTime.parse(map['exp'] as String),
        ),
    ];
  }

  static DateTime _mountExp(
    int addMinutes,
    int addHour,
    int addDays,
    int addMonth,
    int addYear,
  ) {
    DateTime exp = DateTime.now().add(
      Duration(minutes: addMinutes, hours: addHour, days: addDays),
    );
    if (addMonth != 0 || addYear != 0) {
      int newYear = exp.year + addYear;
      int newMonth = exp.month + addMonth;

      // Ajusta o ano e o mês caso os meses adicionados excedam 12
      while (newMonth > 12) {
        newYear += 1;
        newMonth -= 12;
      }

      exp = DateTime(
        newYear,
        newMonth,
        exp.day,
        exp.hour,
        exp.minute,
        exp.second,
      );
    }
    return exp;
  }

  static Future<void> deleteAll() async {
    final db = await DatabaseSingleton.instance.database;
    await db.delete('cache');
  }

  static Future<void> clear() async {
    final clearCacheIgnore = [
      'quick-access',
      'access-token',
      'AuthenticationState',
    ];
    final db = await DatabaseSingleton.instance.database;
    final placeholders = List.filled(
      clearCacheIgnore.length, '?').join(', ');
    final whereClause = 'id NOT IN ($placeholders)';
    await db.delete('cache', where: whereClause, whereArgs: clearCacheIgnore);
  }
}

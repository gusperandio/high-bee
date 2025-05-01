import 'package:firebase_database/firebase_database.dart';
import 'package:high_bee/models/datas/strain.dart';

class StrainService {
  static final StrainService _instance = StrainService._internal();

  factory StrainService() {
    return _instance;
  }

  StrainService._internal();

  final _db = FirebaseDatabase.instance;

  Future<List<StrainModel>> getAllStrains() async {
    try {
       final snapshot = await _db.ref('strains').get();
      if (!snapshot.exists) return [];

      final strainList = <StrainModel>[];

      final data = snapshot.value as Map;
      for (var entry in data.entries) {
        final strain = StrainModel.fromJson(Map<String, dynamic>.from(entry.value));
        strainList.add(strain);
      }
      return strainList;
      
    } catch (e) {
      throw Exception('Failed to fetch strains: $e');
    }
  }
}

import 'package:firebase_database/firebase_database.dart';
import 'package:high_bee/infra/models/datas/reports.dart';

class ReportsService {
  static final ReportsService _instance = ReportsService._internal();

  factory ReportsService() {
    return _instance;
  }

  ReportsService._internal();

  final _db = FirebaseDatabase.instance;

  Future<void> addReport(ReportModel report) async {
    final reportRef = _db.ref('reports').push();
    final id = reportRef.key!;
    await reportRef.set(report.toJson());

    final userReportsRef = _db.ref('users/${report.userId}/reports');
    final snapshot = await userReportsRef.get();

    final newsList =
        snapshot.exists && snapshot.value is List
            ? List<String>.from(snapshot.value as List)
            : <String>[];

    newsList.add(id);
    await userReportsRef.set(newsList);
  }
}

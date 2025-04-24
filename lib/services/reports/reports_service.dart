import 'package:firebase_database/firebase_database.dart';
import 'package:high_bee/models/datas/reports.dart'; 

class ReportsService {
  static final ReportsService _instance = ReportsService._internal();

  factory ReportsService() {
    return _instance;
  }

  ReportsService._internal();

  final _db = FirebaseDatabase.instance;

  Future<void> createReport(ReportModel report) async {
    await _db.ref('reports/$report.id').set(report.toJson());
  }
}

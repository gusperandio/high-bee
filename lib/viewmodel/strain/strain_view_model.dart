import 'package:flutter/material.dart';
import 'package:high_bee/models/datas/strain.dart';
import 'package:high_bee/util/cache.dart';

class StrainViewModel extends ChangeNotifier{
  final Cache cache;
  bool isLoading = true;
  List<StrainModel> strains = [];
  StrainViewModel(this.cache);

   Future<void> loadSavedStrains() async {
    isLoading = true;
    notifyListeners();
    strains = await cache.getListStrains();
    isLoading = false;
    notifyListeners();
  }
}
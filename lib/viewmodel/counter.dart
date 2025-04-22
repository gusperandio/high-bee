// viewmodel/counter_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:high_bee/models/pages/counter_model.dart';


class CounterViewModel extends ChangeNotifier {
  final CounterModel _counterModel = CounterModel();

  int get count => _counterModel.count;

  void incrementCounter() {
    _counterModel.increment();
    notifyListeners();  
  }
}

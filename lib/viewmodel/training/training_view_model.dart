import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:high_bee/util/cache.dart';
import 'package:high_bee/views/training/widgets/page1.dart';
import 'package:high_bee/views/training/widgets/page2.dart';
import 'package:high_bee/views/training/widgets/page3.dart';
import 'package:high_bee/views/training/widgets/page4.dart';
import 'package:high_bee/views/training/widgets/page5.dart';
import 'package:high_bee/views/training/widgets/page6.dart';

class TrainingViewModel extends ChangeNotifier {
  final CarouselSliderController carouselController =
      CarouselSliderController();
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  void setCurrentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  final List<Widget> pages = [
    Page1(),
    Page2(),
    Page3(),
    Page4(),
    Page5(),
    Page6(),
  ];

  Future<void> youAreTrained()async{
    await Cache().setTrained();
  }
}

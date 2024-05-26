import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroController extends GetxController {
  final PageController pageController = PageController();
  var activePage = 0.obs;

  final List<Map<String, dynamic>> pages = [
    {
      'color': '#59d9a6',
      'title': 'Care Your Plant',
      'image': 'assets/images/s10.png',
      'skip': true,
    },
    {
      'color': '#2dd9a6',
      'title': 'Detect Diseases',
      'image': 'assets/images/s12.png',
      'skip': true,
    },
    {
      'color': '#2db320',
      'title': 'Take Experiences',
      'image': 'assets/images/s13.png',
      'skip': false,
    },
  ];

  void onPageChanged(int page) {
    activePage.value = page;
  }

  void onNextPage() {
    if (activePage.value < pages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastEaseInToSlowEaseOut,
      );
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

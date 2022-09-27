import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/pages/base/navigation/navigation_tabs.dart';

class NavigationController extends GetxController {
  late PageController _pageController;

  late RxInt _currentIndex;

  PageController get pageController => _pageController;

  int get currentIndex => _currentIndex.value;

  @override
  void onInit() {
    super.onInit();

    _initNavigation(
      pageController: PageController(initialPage: NavigationTabs.home),
      currentIndex: NavigationTabs.home,
    );
  }

  void _initNavigation({
    required PageController pageController,
    required int currentIndex,
  }) {
    _pageController = pageController;
    _currentIndex = currentIndex.obs;
  }

  void navigatePageView(int page) {
    if (_currentIndex.value == page) {
      return;
    }
    _pageController.jumpToPage(page);
    _currentIndex.value = page;
  }
}

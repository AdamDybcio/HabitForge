import 'package:flutter/foundation.dart';

/// Controller managing the currently selected app tab.
class NavigationController extends ChangeNotifier {
  int _currentIndex = 0;

  /// Selected tab index in bottom navigation.
  int get currentIndex => _currentIndex;

  /// Selects a bottom navigation tab.
  void selectTab(int index) {
    if (index == _currentIndex) {
      return;
    }

    _currentIndex = index;
    notifyListeners();
  }
}

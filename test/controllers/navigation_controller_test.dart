import 'package:flutter_test/flutter_test.dart';
import 'package:habit_forge/controllers/navigation_controller.dart';

void main() {
  group('NavigationController', () {
    test('starts with home tab selected', () {
      final controller = NavigationController();

      expect(controller.currentIndex, 0);
    });

    test('updates currentIndex when selecting a different tab', () {
      final controller = NavigationController();
      var notifications = 0;
      controller.addListener(() => notifications++);

      controller.selectTab(1);

      expect(controller.currentIndex, 1);
      expect(notifications, 1);
    });

    test('does not notify when selecting already selected tab', () {
      final controller = NavigationController();
      var notifications = 0;
      controller.addListener(() => notifications++);

      controller.selectTab(0);

      expect(controller.currentIndex, 0);
      expect(notifications, 0);
    });
  });
}

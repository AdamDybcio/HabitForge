import 'package:flutter/material.dart';
import 'package:habit_forge/controllers/home_controller.dart';
import 'package:habit_forge/controllers/navigation_controller.dart';
import 'package:habit_forge/core/helpers/app_localizations_helper.dart';
import 'package:habit_forge/views/components/main_navigation_item.dart';
import 'package:habit_forge/views/home_screen.dart';
import 'package:habit_forge/views/profile_screen.dart';
import 'package:habit_forge/widgets/habit/create_habit_bottom_sheet.dart';
import 'package:habit_forge/widgets/home/blurred_add_habit_fab.dart';
import 'package:provider/provider.dart';

/// App shell with bottom navigation and center add-habit action.
class MainNavigationScreen extends StatelessWidget {
  static const _bottomBarHeight = 84.0;
  static const _fabGapWidth = 92.0;

  /// Creates [MainNavigationScreen].
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationController = context.watch<NavigationController>();
    final currentIndex = navigationController.currentIndex;
    final l10n = appL10n(context);

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          HomeScreen(onCreateHabit: () => _openCreateHabitSheet(context)),
          const ProfileScreen(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BlurredAddHabitFab(
        onPressed: () => _openCreateHabitSheet(context),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        elevation: 10,
        shadowColor: Theme.of(
          context,
        ).colorScheme.onSurface.withValues(alpha: 0.08),
        height: _bottomBarHeight,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Row(
          children: [
            Expanded(
              child: MainNavigationItem(
                icon: Icons.home_rounded,
                label: l10n.appHomeTab,
                isSelected: currentIndex == 0,
                onTap: () => navigationController.selectTab(0),
              ),
            ),
            const SizedBox(width: _fabGapWidth),
            Expanded(
              child: MainNavigationItem(
                icon: Icons.person_rounded,
                label: l10n.appProfileTab,
                isSelected: currentIndex == 1,
                onTap: () => navigationController.selectTab(1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openCreateHabitSheet(BuildContext context) {
    final controller = context.read<HomeController>();

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) {
        return CreateHabitBottomSheet(controller: controller);
      },
    );
  }
}

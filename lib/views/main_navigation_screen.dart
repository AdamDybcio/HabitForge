import 'package:flutter/material.dart';
import 'package:habit_forge/controllers/home_controller.dart';
import 'package:habit_forge/controllers/navigation_controller.dart';
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
              child: _NavItem(
                icon: Icons.home_rounded,
                label: 'Home',
                isSelected: currentIndex == 0,
                onTap: () => navigationController.selectTab(0),
              ),
            ),
            const SizedBox(width: _fabGapWidth),
            Expanded(
              child: _NavItem(
                icon: Icons.person_rounded,
                label: 'Profile',
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

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final color = isSelected
        ? colorScheme.primary
        : colorScheme.onSurfaceVariant;
    final fontWeight = isSelected ? FontWeight.w700 : FontWeight.w600;
    final baseLabelStyle =
        Theme.of(context).textTheme.labelSmall ??
        const TextStyle(fontSize: 12, fontWeight: FontWeight.w600);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        onTap: onTap,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutBack,
          scale: isSelected ? 1 : 0.96,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? colorScheme.surfaceContainerLowest
                  : Colors.transparent,
              borderRadius: const BorderRadius.all(Radius.circular(14)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedScale(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutBack,
                  scale: isSelected ? 1.08 : 1,
                  child: Icon(icon, color: color),
                ),
                const SizedBox(height: 2),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  style: baseLabelStyle.copyWith(
                    color: color,
                    fontWeight: fontWeight,
                  ),
                  child: Text(label),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

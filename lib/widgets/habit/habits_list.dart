import 'package:flutter/material.dart';
import 'package:habit_forge/controllers/home_controller.dart';
import 'package:habit_forge/core/theme/colors.dart';
import 'package:habit_forge/models/habit.dart';
import 'package:habit_forge/widgets/habit/habit_list_item.dart';
import 'package:habit_forge/widgets/home/home_empty_state.dart';

/// Home content showing loading, empty state or habits list.
class HabitsList extends StatefulWidget {
  /// Controller providing habits data and actions.
  final HomeController controller;

  /// Action used to start create-habit flow.
  final VoidCallback onCreateHabit;

  /// Action used to start edit-habit flow.
  final ValueChanged<Habit> onEditHabit;

  /// Action used to request deleting a habit.
  final ValueChanged<Habit> onDeleteHabit;

  /// Creates [HabitsList].
  const HabitsList({
    required this.controller,
    required this.onCreateHabit,
    required this.onEditHabit,
    required this.onDeleteHabit,
    super.key,
  });

  @override
  State<HabitsList> createState() => _HabitsListState();
}

class _HabitsListState extends State<HabitsList> {
  static const _bottomPadding = 20.0;
  static const _itemGap = 16.0;
  static const _edgeFadeHeight = 26.0;

  final _animatedListKey = GlobalKey<AnimatedListState>();
  final List<Habit> _displayedHabits = <Habit>[];

  @override
  void initState() {
    super.initState();
    _displayedHabits.addAll(widget.controller.habits);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 260),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      child: _displayedHabits.isEmpty
          ? HomeEmptyState(
              key: const ValueKey<String>('empty-state'),
              onCreate: widget.onCreateHabit,
            )
          : ClipRect(
              child: Stack(
                children: [
                  AnimatedList(
                    key: _animatedListKey,
                    padding: const EdgeInsets.only(bottom: _bottomPadding),
                    initialItemCount: _displayedHabits.length,
                    itemBuilder: (_, index, animation) {
                      final habit = _displayedHabits[index];

                      return _AnimatedHabitListEntry(
                        animation: animation,
                        gap: _itemGap,
                        child: HabitListItem(
                          habit: habit,
                          onToggle: () =>
                              widget.controller.toggleHabitCompletion(habit.id),
                          onEdit: () => widget.onEditHabit(habit),
                          onDelete: () => widget.onDeleteHabit(habit),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: IgnorePointer(
                      child: Container(
                        height: _edgeFadeHeight,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.background.withValues(alpha: 0),
                              AppColors.background,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  void didUpdateWidget(covariant HabitsList oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncAnimatedList(widget.controller.habits);
  }

  void _syncAnimatedList(List<Habit> nextHabits) {
    final nextIds = nextHabits.map((habit) => habit.id).toSet();

    for (var i = _displayedHabits.length - 1; i >= 0; i--) {
      final habit = _displayedHabits[i];

      if (!nextIds.contains(habit.id)) {
        final removed = _displayedHabits.removeAt(i);
        _animatedListKey.currentState?.removeItem(
          i,
          (_, animation) => _AnimatedHabitListEntry(
            animation: animation,
            gap: _itemGap,
            child: HabitListItem(
              habit: removed,
              onToggle: () => widget.controller.toggleHabitCompletion(
                habit.id,
              ),
              onEdit: () => widget.onEditHabit(habit),
              onDelete: () => widget.onDeleteHabit(habit),
            ),
          ),
          duration: const Duration(milliseconds: 280),
        );
      }
    }

    for (var i = 0; i < nextHabits.length; i++) {
      final nextHabit = nextHabits[i];

      if (i < _displayedHabits.length &&
          _displayedHabits[i].id == nextHabit.id) {
        _displayedHabits[i] = nextHabit;
        continue;
      }

      final existingIndex = _displayedHabits.indexWhere(
        (habit) => habit.id == nextHabit.id,
      );

      if (existingIndex == -1) {
        _displayedHabits.insert(i, nextHabit);
        _animatedListKey.currentState?.insertItem(
          i,
          duration: const Duration(milliseconds: 320),
        );
      } else {
        _displayedHabits[existingIndex] = nextHabit;
      }
    }
  }
}

class _AnimatedHabitListEntry extends StatelessWidget {
  final Animation<double> animation;
  final double gap;
  final Widget child;

  const _AnimatedHabitListEntry({
    required this.animation,
    required this.gap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));

    return FadeTransition(
      opacity: animation,
      child: SizeTransition(
        sizeFactor: animation,
        axisAlignment: -1,
        child: SlideTransition(
          position: slide,
          child: Padding(
            padding: EdgeInsets.only(bottom: gap),
            child: child,
          ),
        ),
      ),
    );
  }
}

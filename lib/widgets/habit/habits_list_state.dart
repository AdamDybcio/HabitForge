import 'package:flutter/material.dart';
import 'package:habit_forge/models/habit.dart';
import 'package:habit_forge/widgets/habit/components/list/animated_habit_list_entry.dart';
import 'package:habit_forge/widgets/habit/habit_list_item.dart';
import 'package:habit_forge/widgets/habit/habits_list.dart';
import 'package:habit_forge/widgets/home/home_empty_state.dart';

/// State object for [HabitsList].
class HabitsListState extends State<HabitsList> {
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
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;

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

                      return AnimatedHabitListEntry(
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
                              backgroundColor.withValues(alpha: 0),
                              backgroundColor,
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
          (_, animation) => AnimatedHabitListEntry(
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

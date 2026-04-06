// ignore_for_file: public_member_api_docs

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:habit_forge/core/theme/colors.dart';
import 'package:intl/intl.dart';

/// Weekly completion chart based on aggregated daily completions.
class ProfileWeeklyChart extends StatelessWidget {
  static const _legendDotSize = 12.0;
  static const _chartHeight = 180.0;

  final List<int> completions;

  /// Creates [ProfileWeeklyChart].
  const ProfileWeeklyChart({required this.completions, super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final now = DateTime.now();
    final maxY = (completions.isEmpty ? 0 : completions.reduce(_max))
        .toDouble();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        boxShadow: AppEffects.ambientShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Last 7 days', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          SizedBox(
            height: _chartHeight,
            child: BarChart(
              BarChartData(
                minY: 0,
                maxY: maxY < 1 ? 1 : maxY + 1,
                barTouchData: BarTouchData(
                  enabled: true,
                  handleBuiltInTouches: true,
                  touchTooltipData: BarTouchTooltipData(
                    fitInsideHorizontally: true,
                    fitInsideVertically: true,
                    tooltipPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    getTooltipColor: (_) => colorScheme.onSurface,
                    getTooltipItem: (group, _, rod, __) {
                      final day = now.subtract(
                        Duration(days: completions.length - 1 - group.x),
                      );
                      final tooltipTextStyle =
                          Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            height: 1.25,
                          ) ??
                          const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            height: 1.25,
                          );

                      return BarTooltipItem(
                        '${DateFormat('EEE').format(day)}\n'
                        '${rod.toY.toInt()} completed',
                        tooltipTextStyle,
                      );
                    },
                  ),
                ),
                gridData: FlGridData(
                  drawVerticalLine: false,
                  horizontalInterval: 1,
                  getDrawingHorizontalLine: (_) => FlLine(
                    color: colorScheme.outlineVariant.withValues(alpha: 0.22),
                    strokeWidth: 1,
                  ),
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(),
                  rightTitles: const AxisTitles(),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      interval: 1,
                      getTitlesWidget: (value, _) {
                        if (value % 1 != 0) {
                          return const SizedBox.shrink();
                        }

                        return Text(
                          value.toInt().toString(),
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      getTitlesWidget: (value, _) {
                        final index = value.toInt();

                        if (index < 0 || index >= completions.length) {
                          return const SizedBox.shrink();
                        }

                        final day = now.subtract(
                          Duration(days: completions.length - 1 - index),
                        );

                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            DateFormat('E').format(day),
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                barGroups: completions.asMap().entries.map((entry) {
                  return BarChartGroupData(
                    x: entry.key,
                    barRods: [
                      BarChartRodData(
                        toY: entry.value.toDouble(),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(6),
                        ),
                        width: 16,
                        gradient: AppEffects.ctaGradient,
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              _LegendItem(
                label: 'Completed habits per day',
                useGradient: true,
              ),
              _LegendItem(
                label: 'Mon-Sun timeline (last 7 days)',
              ),
            ],
          ),
        ],
      ),
    );
  }

  int _max(int a, int b) => a > b ? a : b;
}

class _LegendItem extends StatelessWidget {
  final String label;
  final bool useGradient;

  const _LegendItem({
    required this.label,
    this.useGradient = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: ProfileWeeklyChart._legendDotSize,
          height: ProfileWeeklyChart._legendDotSize,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            color: useGradient ? null : colorScheme.outlineVariant,
            gradient: useGradient ? AppEffects.ctaGradient : null,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

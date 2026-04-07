// ignore_for_file: public_member_api_docs

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:habit_forge/core/helpers/app_localizations_helper.dart';
import 'package:habit_forge/core/theme/colors.dart';
import 'package:habit_forge/widgets/profile/components/profile_legend_item.dart';
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
    final l10n = appL10n(context);
    final localeTag = Localizations.localeOf(context).toLanguageTag();
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
          Text(
            l10n.lastSevenDays,
            style: Theme.of(context).textTheme.titleMedium,
          ),
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
                    getTooltipColor: (_) => colorScheme.inverseSurface,
                    getTooltipItem: (group, _, rod, __) {
                      final day = now.subtract(
                        Duration(days: completions.length - 1 - group.x),
                      );
                      final tooltipTextStyle =
                          Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: colorScheme.onInverseSurface,
                            fontWeight: FontWeight.w700,
                            height: 1.25,
                          ) ??
                          TextStyle(
                            color: colorScheme.onInverseSurface,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            height: 1.25,
                          );

                      return BarTooltipItem(
                        l10n.weeklyTooltip(
                          DateFormat('EEE', localeTag).format(day),
                          rod.toY.toInt(),
                        ),
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
                            DateFormat('E', localeTag).format(day),
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
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              ProfileLegendItem(
                label: l10n.legendCompletedHabitsPerDay,
                dotSize: _legendDotSize,
                useGradient: true,
              ),
              ProfileLegendItem(
                label: l10n.legendTimelineLastSevenDays,
                dotSize: _legendDotSize,
              ),
            ],
          ),
        ],
      ),
    );
  }

  int _max(int a, int b) => a > b ? a : b;
}

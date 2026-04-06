import 'package:flutter/material.dart';
import 'package:habit_forge/core/theme/colors.dart';

/// Placeholder profile screen for future statistics and settings.
class ProfileScreen extends StatelessWidget {
  /// Creates [ProfileScreen].
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Profile'),
            SizedBox(height: 8),
            Text(
              'Stats and profile tools will appear here soon.',
              style: TextStyle(color: AppColors.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

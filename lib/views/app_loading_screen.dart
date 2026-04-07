import 'package:flutter/material.dart';

/// Temporary loading screen displayed while app launch state initializes.
class AppLoadingScreen extends StatelessWidget {
  /// Creates [AppLoadingScreen].
  const AppLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

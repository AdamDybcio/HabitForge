import 'package:flutter/material.dart';

const _desktopBreakpoint = 900.0;
const _wideDesktopBreakpoint = 1200.0;
const _desktopMaxWidth = 560.0;
const _wideDesktopMaxWidth = 760.0;

/// Wraps app content in a centered frame on wide screens.
class ResponsiveAppFrame extends StatelessWidget {
  /// Content to render inside responsive frame constraints.
  final Widget child;

  /// Creates [ResponsiveAppFrame].
  const ResponsiveAppFrame({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width < _desktopBreakpoint) {
      return child;
    }

    final maxWidth = width >= _wideDesktopBreakpoint
        ? _wideDesktopMaxWidth
        : _desktopMaxWidth;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}

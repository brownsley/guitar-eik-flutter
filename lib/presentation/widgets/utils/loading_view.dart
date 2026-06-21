import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  final String message;

  const LoadingView({super.key, this.message = "Loading..."});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator.adaptive(strokeWidth: 4.5),
          ),
          const SizedBox(height: 10),
          Text(
            message,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

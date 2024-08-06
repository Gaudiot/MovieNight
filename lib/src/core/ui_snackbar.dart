import "package:flutter/material.dart";
import "package:movie_night/src/core/design/app_colors.dart";

enum SnackBarState {
  success,
  info,
  warning,
  error,
}

class UISnackbar {
  static Color _getBackgroundColor(SnackBarState state) {
    switch (state) {
      case SnackBarState.success:
        return AppColors.green;
      case SnackBarState.info:
        return AppColors.gray;
      case SnackBarState.warning:
        return AppColors.lightYellow;
      case SnackBarState.error:
        return AppColors.red;
    }
  }

  static Icon _getIcon(SnackBarState state) {
    switch (state) {
      case SnackBarState.success:
        return const Icon(Icons.check_circle_outline);
      case SnackBarState.info:
        return const Icon(Icons.info_outline);
      case SnackBarState.warning:
        return const Icon(Icons.warning_amber_outlined);
      case SnackBarState.error:
        return const Icon(Icons.error_outline);
    }
  }

  static void show(
    BuildContext context, {
    required SnackBarState state,
    required String message,
  }) {
    hide(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: "Dismiss",
          textColor: AppColors.black,
          onPressed: () => hide(context),
        ),
        content: Row(
          children: [
            _getIcon(state),
            const SizedBox(width: 8),
            Text(message),
          ],
        ),
        backgroundColor: _getBackgroundColor(state),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static void hide(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}

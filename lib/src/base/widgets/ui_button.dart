import "package:flutter/material.dart";
import "package:movie_night/src/core/design/design.dart";

class UIButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Widget? suffixIcon;

  const UIButton({
    required this.label,
    required this.onPressed,
    this.suffixIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        side: const BorderSide(color: AppColors.yellow, width: 1.5),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(color: AppColors.yellow),
          ),
          if (suffixIcon != null) ...[
            const SizedBox(width: 4),
            suffixIcon!,
          ],
        ],
      ),
    );
  }
}

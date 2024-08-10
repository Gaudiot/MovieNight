import "package:flutter/material.dart";
import "package:movie_night/src/core/design/app_colors.dart";

class UIDropdownEntry<T> {
  final T value;
  final String label;

  const UIDropdownEntry({
    required this.value,
    required this.label,
  });
}

class UIDropdown<T> extends StatelessWidget {
  final List<UIDropdownEntry<T>> entries;
  final ValueChanged<T?> onSelected;

  final Color listBackgroundColor;

  const UIDropdown({
    required this.entries,
    required this.onSelected,
    this.listBackgroundColor = AppColors.darkBlue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      decoration: const ShapeDecoration(
        color: AppColors.darkestBlue,
        shape: StadiumBorder(
          side: BorderSide(
            width: 3,
            color: AppColors.white,
          ),
        ),
      ),
      child: DropdownMenu<T>(
        onSelected: (value) {
          onSelected(value);
        },
        menuStyle: MenuStyle(
          backgroundColor:
              MaterialStateColor.resolveWith((states) => listBackgroundColor),
        ),
        trailingIcon: const Icon(
          Icons.arrow_drop_down,
          color: AppColors.white,
        ),
        selectedTrailingIcon: const Icon(
          Icons.arrow_drop_up,
          color: AppColors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
        ),
        textStyle: const TextStyle(
          color: AppColors.white,
        ),
        initialSelection: entries.first.value,
        dropdownMenuEntries: List.generate(
          entries.length,
          (index) => DropdownMenuEntry<T>(
            value: entries[index].value,
            label: entries[index].label,
            labelWidget: Text(
              entries[index].label,
              style: const TextStyle(color: AppColors.white),
            ),
          ),
        ),
      ),
    );
  }
}

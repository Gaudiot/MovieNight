import "dart:async";

import "package:flutter/material.dart";
import "package:movie_night/src/core/design/design.dart";

class DelayedSearchBar extends StatefulWidget {
  final int delayInMilliseconds;
  final ValueChanged<String> onSearch;

  const DelayedSearchBar({
    required this.onSearch,
    this.delayInMilliseconds = 2000,
    super.key,
  });

  @override
  State<DelayedSearchBar> createState() => _DelayedSearchBarState();
}

class _DelayedSearchBarState extends State<DelayedSearchBar> {
  final TextEditingController _controller = TextEditingController();
  Timer? timer;
  late Widget suffixIcon;

  @override
  void initState() {
    _controller.clear();
    setSuffixIcon(_controller.text);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void setSuffixIcon([String value = ""]) {
    setState(() {
      suffixIcon = value.isNotEmpty
          ? IconButton(
              icon: const Icon(
                Icons.clear,
                color: AppColors.white,
              ),
              onPressed: () {
                delayedCallback();
                _controller.clear();
                setSuffixIcon();
              },
            )
          : const Icon(
              Icons.search,
              color: AppColors.white,
            );
    });
  }

  void delayedCallback([String value = ""]) {
    if (timer != null) {
      timer!.cancel();
    }

    timer = Timer(
      Duration(milliseconds: widget.delayInMilliseconds),
      () {
        FocusManager.instance.primaryFocus?.unfocus();
        widget.onSearch(value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      cursorColor: AppColors.white,
      style: const TextStyle(
        color: AppColors.white,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.darkBlue,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 00,
        ),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: (value) {
        delayedCallback(value);
        setSuffixIcon(value);
      },
    );
  }
}

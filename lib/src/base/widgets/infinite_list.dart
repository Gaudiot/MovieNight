import "package:flutter/material.dart";
import "package:movie_night/src/core/exceptions/exceptions.dart";
import "package:movie_night/src/core/types/result_type.dart";

class InfiniteList<T> extends StatefulWidget {
  final int firstPageValue;
  final int pageSize;
  final Widget Function(T item) builder;
  final Future<Result<List<T>, NetworkException>> Function(
    int page,
    int pageSize,
  ) fetchItems;

  final Widget errorWidget;
  final Widget loadingWidget;

  const InfiniteList({
    required this.builder,
    required this.fetchItems,
    this.errorWidget = const Placeholder(),
    this.loadingWidget = const CircularProgressIndicator(),
    this.firstPageValue = 1,
    this.pageSize = 10,
    super.key,
  });

  @override
  State<InfiniteList<T>> createState() => _InfiniteListState<T>();
}

class _InfiniteListState<T> extends State<InfiniteList<T>> {
  late int page;
  late List<T> items;
  late final int pageSize;
  late bool isLastPage;

  late bool hasError;
  late bool isLoading;
  final int pageTrigger = 3;

  @override
  void initState() {
    page = widget.firstPageValue;
    pageSize = widget.pageSize;
    items = [];
    isLastPage = false;
    hasError = false;
    isLoading = true;
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    final result = await widget.fetchItems(page, pageSize);

    if (result.hasError || result.value == null) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
      return;
    }

    final items = result.value!;

    setState(() {
      this.items.addAll(items);
      isLoading = false;
      isLastPage = items.length < pageSize;
      page++;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (hasError) {
      return widget.errorWidget;
    }

    if (isLoading && items.isEmpty) {
      return widget.loadingWidget;
    }

    return ListView.builder(
      itemCount: items.length + 1,
      itemBuilder: (context, index) {
        if (index == items.length - pageTrigger) {
          fetchData();
        }
        if (index == items.length) {
          if (hasError) {
            return widget.errorWidget;
          }
          if (isLoading) {
            return widget.loadingWidget;
          }
          return const Text("Fim da lista");
        }
        final item = items[index];

        return widget.builder(item);
      },
    );
  }
}

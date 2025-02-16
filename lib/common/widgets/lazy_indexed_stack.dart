import 'package:flutter/material.dart';

class LazyIndexedStack extends StatefulWidget {
  const LazyIndexedStack({
    Key? key,
    this.index = 0,
    this.children = const [],
  }) : super(key: key);

  final int index;
  final List<Widget> children;

  @override
  State<LazyIndexedStack> createState() => _LazyIndexedStackState();
}

class _LazyIndexedStackState extends State<LazyIndexedStack> {
  late List<bool> _activated = _initializeActivatedList();

  List<bool> _initializeActivatedList() =>
      List<bool>.generate(widget.children.length, (i) => i == widget.index);

  @override
  void didUpdateWidget(covariant LazyIndexedStack oldWidget) {
    if (oldWidget.children.length != widget.children.length) {
      _activated = _initializeActivatedList();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    _activated[widget.index] = true;
    final children = List.generate(_activated.length, (i) {
      return _activated[i] ? widget.children[i] : const SizedBox.shrink();
    });
    return IndexedStack(
      index: widget.index,
      children: children,
    );
  }
}

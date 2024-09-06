import 'package:flutter/material.dart';
import 'base_appBar.dart';
import 'base_scaffold.dart';

class BaseLayout extends StatelessWidget {
  final String titleAppBar;
  final Widget child;

  const BaseLayout(this.titleAppBar, this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: CustomAppBar(title: titleAppBar, hasBack: true),
      body: child,
    );
  }
}

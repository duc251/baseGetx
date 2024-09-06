import 'package:flutter/material.dart';

abstract class ShowNotiWhenCallApi {
  void showBeforeEvent(BuildContext context);

  void showAffterEvent(BuildContext context, bool status);
}

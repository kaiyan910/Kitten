import 'package:flutter/material.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';

abstract class StatusBarHandler {

  changeStatusBarStyle(Color color, StatusBarStyle style) async {
    await FlutterStatusbarManager.setColor(color, animated: true);
    await FlutterStatusbarManager.setStyle(style);
  }
}
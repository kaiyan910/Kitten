import 'dart:io' show Platform;

import 'package:flutter/material.dart';

class PlatformIndicator extends StatelessWidget {
  final Widget android;
  final Widget ios;

  PlatformIndicator({
    this.android = const Material(),
    this.ios = const Material(),
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return android;
    } else {
      return ios;
    }
  }
}

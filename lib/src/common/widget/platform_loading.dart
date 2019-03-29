import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitten/src/common/widget/platform_indicator.dart';

class PlatformLoading extends StatelessWidget {
  final bool showLoading;

  PlatformLoading({this.showLoading = true});

  @override
  Widget build(BuildContext context) {
    return (showLoading)
        ? PlatformIndicator(
            android: Center(
              child: CircularProgressIndicator(),
            ),
            ios: Center(
              child: CupertinoActivityIndicator(animating: true),
            ),
          )
        : Material();
  }
}

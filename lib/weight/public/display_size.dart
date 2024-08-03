import 'package:flutter/material.dart';

class DisplaySize {
  BuildContext context;
  late double statusBarSize;
  late double maxWidth;
  DisplaySize(this.context) {
    statusBarSize = MediaQuery.of(context).padding.top;
    maxWidth = MediaQuery.of(context).size.width;
  }
}

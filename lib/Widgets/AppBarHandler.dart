import 'package:flutter/material.dart';

import "CustomAppBar.dart";

class AppBarHandler extends AppBar {
  final ScrollController scrollController;

  late CustomAppBar customAppBar;
  late double height;
  late int offsetTop = 0;
  late double fontSize = 0;
  late int expansionRatio = 0;

  AppBarHandler({Key? key, required this.scrollController, this.height = 0})
      : super(key: key) {
    customAppBar = CustomAppBar(
      scrollController: scrollController,
    );
  }

  getCustomAppBar() {
    if (scrollController == null) {
      offsetTop = 0;
      height = kToolbarHeight;
      fontSize = 20.0;
      expansionRatio = 0;

      customAppBar.height = height;
    } else {
      offsetTop = kToolbarHeight.toInt();
      height = MAX_CUSTOM_APPBAR_HEIGHT;
      fontSize = MAX_CUSTOM_APPBAR_FONTSIZE;
      expansionRatio = 1;

      print(height);

      customAppBar.height = height;
      customAppBar.fontSize = fontSize;

      scrollController.addListener(() {
        // TODO: scroll offset + height + background shadow
      });
    }

    print("Height: " + customAppBar.height.toString());

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: height,
      flexibleSpace: customAppBar,
      automaticallyImplyLeading: false,
    );
  }
}

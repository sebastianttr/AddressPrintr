import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Utils/Utils.dart';

const double MAX_CUSTOM_APPBAR_FONTSIZE = 40.0;
const double MAX_CUSTOM_APPBAR_HEIGHT =
    kToolbarHeight + MAX_CUSTOM_APPBAR_FONTSIZE;

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  double height;
  double fontSize;
  String title;
  List<IconButton> actions;
  final ScrollController? scrollController;
  Function(double height)? onScroll;

  CustomAppBar(
      {Key? key,
      this.height = kToolbarHeight,
      this.scrollController,
      this.title = "",
      this.actions = const [],
      this.fontSize = 20,
      this.onScroll})
      : super(key: key) {
    if (scrollController != null) {
      height = MAX_CUSTOM_APPBAR_HEIGHT;
    }
  }

  @override
  State<StatefulWidget> createState() => _CustomAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize {
    return Size.fromHeight(height);
  }
}

class _CustomAppBarState extends State<CustomAppBar> {
  double height = 0;
  double fontSize = 0;
  double expansionRatio = 0;
  List<IconButton> listOfActions = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.scrollController == null) {
      setState(() {
        height = kToolbarHeight;
        fontSize = 20.0;
      });
    } else {
      if (height == 0.0 || fontSize == 0.0) {
        setState(() {
          height = MAX_CUSTOM_APPBAR_HEIGHT;
          fontSize = 40.0;
          expansionRatio = 1;
        });
      }

      widget.scrollController?.addListener(() {
        setState(() {
          // set the height
          height = MAX_CUSTOM_APPBAR_HEIGHT.toDouble() -
              widget.scrollController!.position.pixels.toDouble();

          if (height <= kToolbarHeight) {
            height = kToolbarHeight;
          }

          // expansion ration calc with mapping function
          expansionRatio =
              map(height, kToolbarHeight, MAX_CUSTOM_APPBAR_HEIGHT, 0, 1);

          if (expansionRatio > 1) {
            expansionRatio = 1;
          }

          // font size
          fontSize =
              map(expansionRatio, 0.0, 1.0, 23.0, MAX_CUSTOM_APPBAR_FONTSIZE);
        });

        //print(fontSize);

        widget.onScroll!(height);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final paddingTop = MediaQuery.of(context).viewPadding.top;

    return Container(
        height: paddingTop + height,
        padding: EdgeInsets.only(top: paddingTop + 5),
        decoration: BoxDecoration(
            color:
                Colors.white, //.withOpacity(map(expansionRatio, 0, 1, 0.5, 1)),
            boxShadow: [
              BoxShadow(
                  blurRadius: 4 * (1 - expansionRatio),
                  spreadRadius: 2 * (1 - expansionRatio),
                  color: Colors.grey)
            ]),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (Navigator.canPop(context))
            Stack(alignment: Alignment.topLeft, children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_sharp))
            ]),
          Expanded(
              child: Padding(
                  padding: EdgeInsets.only(
                      top: 17, left: Navigator.canPop(context) ? 0 : 10),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topLeft,
                    children: [
                      Positioned(
                          top: 0.2 +
                              (kToolbarHeight * expansionRatio) * 0.6 -
                              fontSize / 4,
                          left: (Navigator.canPop(context) ? -35 : 0) *
                              expansionRatio,
                          child: Text(widget.title,
                              style: TextStyle(
                                  fontSize: fontSize, color: Colors.black)))
                    ],
                  ))),
          Padding(
              padding: EdgeInsets.only(
                  top: 0.3 + (expansionRatio * kToolbarHeight) * 0.7,
                  right: expansionRatio * 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: widget.actions.reversed.toList(),
              ))
        ]));
  }
}

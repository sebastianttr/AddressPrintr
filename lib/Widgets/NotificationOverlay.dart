import 'dart:async';

import 'package:flutter/material.dart';

class NotificationOverlay extends StatefulWidget {
  final String text;
  final BuildContext renderContext;
  final Duration duration;
  final Function onDone;

  const NotificationOverlay(
      {Key? key,
      required this.text,
      required this.renderContext,
      required this.onDone,
      required this.duration})
      : super(key: key);

  @override
  _NotificationOverlayState createState() => _NotificationOverlayState();
}

class _NotificationOverlayState extends State<NotificationOverlay> {
  double height = 0;
  bool endFlag = false;
  late RenderBox box;
  late Offset pos;
  late double heigthStatusBar;
  late ThemeData theme;

  @override
  void initState() {
    super.initState();

    setState(() {
      box = widget.renderContext.findRenderObject() as RenderBox;
      pos = box.localToGlobal(Offset.zero);
      heigthStatusBar = MediaQuery.of(widget.renderContext).viewPadding.top;
      theme = Theme.of(widget.renderContext);
    });

    // Start the timer which creates the animation
    Timer(const Duration(milliseconds: 40), () {
      print("Starting animation");
      setState(() {
        height = 30;
      });
    });

    //Start the timer which does something after the set duration is over
    Timer(widget.duration, () {
      setState(() {
        height = 0;
        endFlag = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: heigthStatusBar + kToolbarHeight + 5.0,
        width: box.size.width,
        child: Material(
          type: MaterialType.transparency,
          child: AnimatedContainer(
              onEnd: () {
                if (endFlag) {
                  widget.onDone();
                }
              },
              height: height,
              curve: Curves.fastOutSlowIn,
              duration: const Duration(milliseconds: 600),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: theme.colorScheme.primary,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 3,
                        spreadRadius: 3,
                        color: Colors.grey.shade300)
                  ]),
              child: Text(
                widget.text,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              )),
        ));
  }
}

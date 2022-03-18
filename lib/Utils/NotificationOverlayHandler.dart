import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import "../Widgets/NotificationOverlay.dart";

showNotifier(BuildContext context, String text,
    {Color? color, String? position, String? shape}) async {
  OverlayEntry? entry;

  Widget notificationOverlay = NotificationOverlay(
    text: text,
    renderContext: context,
    color: color ?? Theme.of(context).primaryColorDark,
    positon: position ?? "bottom",
    shape: shape ?? "pill",
    onDone: () {
      entry?.remove();
    },
    duration: const Duration(seconds: 3),
  );

  entry = OverlayEntry(builder: (BuildContext buildContext) {
    return notificationOverlay;
  });

  Overlay.of(context)?.insert(entry);
}

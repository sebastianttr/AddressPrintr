import 'dart:async';

import 'package:flutter/cupertino.dart';

import "../Widgets/NotificationOverlay.dart";

showNotifier(BuildContext context, String text) async {
  OverlayEntry? entry;

  Widget notificationOverlay = NotificationOverlay(
    text: text,
    renderContext: context,
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

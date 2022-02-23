import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final Function onClick;
  final String titleText;
  final String descriptionText;

  const SettingsItem(
      {Key? key,
      required this.onClick,
      required this.titleText,
      required this.descriptionText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick();
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            titleText,
            style: const TextStyle(fontSize: 20),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(descriptionText)),
          const Divider()
        ]),
      ),
    );
  }
}

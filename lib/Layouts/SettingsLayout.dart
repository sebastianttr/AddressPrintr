import 'package:address_printr/Modals/SetAddressModalView.dart';
import 'package:flutter/material.dart';
import '../Widgets/SettingsItem.dart';

class SettingsLayout extends StatefulWidget {
  const SettingsLayout({Key? key}) : super(key: key);

  @override
  State<SettingsLayout> createState() => _SettingsLayout();
}

class _SettingsLayout extends State<SettingsLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: const Text(
              "Settings",
              style: TextStyle(fontSize: 35),
            ),
          ),
          SettingsItem(
              onClick: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (buildContext) {
                      return SetAddressModalView(context: context);
                    });
              },
              titleText: "Set own address",
              descriptionText:
                  "Set your own information in order to use it to generate a new address sheet"),
        ]),
      ),
    );
  }
}

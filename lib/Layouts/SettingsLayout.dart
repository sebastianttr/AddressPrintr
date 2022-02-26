import 'package:address_printr/Modals/SetAddressModalView.dart';
import 'package:flutter/material.dart';
import '../Widgets/SettingsItem.dart';
import "../Widgets/CustomAppBar.dart";

class SettingsLayout extends StatefulWidget {
  const SettingsLayout({Key? key}) : super(key: key);

  @override
  State<SettingsLayout> createState() => _SettingsLayout();
}

class _SettingsLayout extends State<SettingsLayout> {
  List<Widget> settingsItem = [];
  final ScrollController _scrollController = ScrollController();
  double appBarHeight = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    settingsItem.add(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          scrollController: _scrollController,
          title: "Settings",
          height: appBarHeight,
          onScroll: (aBHeight) {
            setState(() {
              appBarHeight = aBHeight;
            });
          },
        ),
        body: Container(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const ClampingScrollPhysics(),
              child: Column(children: settingsItem),
            )));
  }
}

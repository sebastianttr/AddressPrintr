import 'package:address_printr/Modals/SetAddressModalView.dart';
import 'package:address_printr/Widgets/AppBarHandler.dart';
import 'package:flutter/material.dart';
import '../Widgets/SettingsItem.dart';
import "../Widgets/CustomAppBar.dart";

class SettingsLayout extends StatefulWidget {
  const SettingsLayout({Key? key}) : super(key: key);

  @override
  State<SettingsLayout> createState() => _SettingsLayout();
}

class _SettingsLayout extends State<SettingsLayout> {
  List<Widget> testWidgets = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (int i = 0; i < 30; i++) {
      testWidgets.add(
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

    _scrollController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarHandler(
          scrollController: _scrollController,
        ).getCustomAppBar(),
        body: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: ListView.builder(
              itemBuilder: (buildContext, index) {
                return SettingsItem(
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
                        "Set your own information in order to use it to generate a new address sheet");
              },
              itemCount: testWidgets.length,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              controller: _scrollController,
            )));
  }
}

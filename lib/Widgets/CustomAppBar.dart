import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double MAX_CUSTOM_APPBAR_FONTSIZE = 40.0;
const double MAX_CUSTOM_APPBAR_HEIGHT =
    kToolbarHeight + MAX_CUSTOM_APPBAR_FONTSIZE + 10;

class CustomAppBar extends StatefulWidget {
  double height;
  double fontSize;
  final Listenable? scrollController;

  CustomAppBar(
      {Key? key,
      this.height = kToolbarHeight,
      this.scrollController,
      this.fontSize = 20})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  int offsetTop = 0;
  double height = 0;
  double fontSize = 0;
  int expansionRatio = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final paddingTop = MediaQuery.of(context).viewPadding.top;

    return Container(
        height: paddingTop + widget.height,
        padding: EdgeInsets.only(top: paddingTop),
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
              child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topLeft,
            children: [
              Positioned(
                  top: kToolbarHeight - widget.fontSize + 35,
                  left: -35,
                  child: Text("Settings",
                      style: TextStyle(fontSize: widget.fontSize.toDouble())))
            ],
          )),
          Row(
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
            ],
          )
        ]));
  }
}

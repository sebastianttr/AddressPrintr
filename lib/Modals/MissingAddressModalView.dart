import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SetAddressModalView.dart';

class MissingAddressModalView extends StatefulWidget {
  final BuildContext context;
  const MissingAddressModalView({Key? key, required this.context})
      : super(key: key);

  @override
  _MissingAddressModalViewState createState() =>
      _MissingAddressModalViewState();
}

class _MissingAddressModalViewState extends State<MissingAddressModalView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Wrap(children: [
      Container(
          margin: const EdgeInsets.all(10.0),
          clipBehavior: Clip.antiAlias,
          padding: MediaQuery.of(context).viewInsets,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    child: const Text(
                      "No address found",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    child: const Text(
                      "You have not set your own postal information. Please set your postal info before you can generate a postal address sheet.",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            color: theme.primaryColor,
                            child: const Text(
                              "Set Address now",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              Navigator.pop(context);
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (buildContext) {
                                    return SetAddressModalView(
                                        context: widget.context);
                                  });
                            }),
                      ))
                    ],
                  )
                ],
              )))
    ]);
  }
}

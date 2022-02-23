import 'dart:convert';

import 'package:address_printr/Models/PostalInformation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../Utils/NotificationOverlayHandler.dart';
import '../Widgets/InputText.dart';

class SetAddressModalView extends StatefulWidget {
  final BuildContext context;

  const SetAddressModalView({Key? key, required this.context})
      : super(key: key);

  @override
  _SetAddressModalView createState() => _SetAddressModalView();
}

class _SetAddressModalView extends State<SetAddressModalView> {
  SharedPreferences? storage;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController streetInformationController = TextEditingController();
  TextEditingController cityInformationController = TextEditingController();

  saveData() async {
    final pI = PostalInformation(
        fullName: fullNameController.text,
        cityInformation: cityInformationController.text,
        streetInformation: streetInformationController.text);

    //print(const JsonEncoder().convert(pI));

    storage?.setString("postalInformation", const JsonEncoder().convert(pI));
  }

  initStorage() async {
    storage = await SharedPreferences.getInstance();
    if (fullNameController.text.isEmpty) {
      setOwnPostalInformation();
    }
  }

  setOwnPostalInformation() {
    //print("Getting info");
    String data = storage?.getString("postalInformation") ?? "";

    if (data.isNotEmpty) {
      //print("Is not empty: " + data);
      final PostalInformation pi =
          PostalInformation.fromJson(const JsonDecoder().convert(data));

      fullNameController.text = pi.fullName;
      cityInformationController.text = pi.cityInformation;
      streetInformationController.text = pi.streetInformation;
    }
  }

  @override
  void initState() {
    super.initState();
    initStorage();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
        margin: const EdgeInsets.all(10.0),
        padding: MediaQuery.of(context).viewInsets,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      height: 30,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.shade300),
                      child: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.black,
                        size: 24.0,
                        semanticLabel:
                            'Text to announce in accessibility modes',
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: const Text(
                    "Set your own address",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                Column(
                  children: [
                    InputText(
                      controller: fullNameController,
                      height: 40,
                      helperText: "Full name",
                      hintText: "Enter full name here",
                      padding: const EdgeInsets.only(top: 10, left: 5),
                    ),
                    InputText(
                      controller: streetInformationController,
                      height: 40,
                      helperText: "Street name and number",
                      hintText: "Enter full name here",
                      padding: const EdgeInsets.only(top: 10, left: 5),
                    ),
                    InputText(
                      controller: cityInformationController,
                      height: 40,
                      helperText: "City with postal code",
                      hintText: "Enter full name here",
                      padding: const EdgeInsets.only(top: 10, left: 5),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                side: BorderSide(
                                    width: 0.5, color: theme.primaryColor),
                              ),
                              child: const Text(
                                "Cancel",
                                style: TextStyle(color: Colors.black),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                        )),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              color: theme.primaryColor,
                              child: const Text(
                                "Save",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                saveData();
                                showNotifier(widget.context, "Address set.");
                                Navigator.pop(context);
                              }),
                        ))
                      ],
                    ),
                  ],
                )
              ],
            )));
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:address_printr/Models/PostalInformation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "../Widgets/InputText.dart";
import "../Models/PDFWidgets/Text.dart";
import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import "../Widgets/CustomAppBar.dart";

class GenerateAddressLayout extends StatefulWidget {
  const GenerateAddressLayout({Key? key}) : super(key: key);

  @override
  _GenerateAddressLayoutState createState() => _GenerateAddressLayoutState();
}

class _GenerateAddressLayoutState extends State<GenerateAddressLayout> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController streetInfoController = TextEditingController();
  TextEditingController cityInfoController = TextEditingController();

  ScrollController _scrollController = ScrollController();
  double appBarHeight = 0;

  generate() async {
    final storage = await SharedPreferences.getInstance();
    final pi = PostalInformation.fromJson(const JsonDecoder()
        .convert(storage.getString("postalInformation") ?? ""));

    // create the view
    final listOfViews = [
      DText(text: pi.fullName, x: 10, y: 10, fontSize: 20),
      DText(text: pi.streetInformation, x: 10, y: 40, fontSize: 20),
      DText(text: pi.cityInformation, x: 10, y: 70, fontSize: 20),
      DText(
          text: fullNameController.text,
          x: 10,
          y: 120,
          fontSize: 20,
          textAlign: "right"),
      DText(
          text: streetInfoController.text,
          x: 10,
          y: 150,
          fontSize: 20,
          textAlign: "right"),
      DText(
          text: cityInfoController.text,
          x: 10,
          y: 180,
          fontSize: 20,
          textAlign: "right"),
    ];

    String json = jsonEncode(listOfViews);

    // ignore: avoid_print
    print(json);

    final listOfPrinters = await Printing.listPrinters();
    // ignore: avoid_print, unnecessary_type_check

    final url = Uri.parse("http://192.168.0.159:8080/generate");

    http.Response res = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json);

    // HTTP.OK
    if (res.statusCode == 200) {
      // ignore: avoid_print
      print(res.body);
    } else {
      // ignore: avoid_print
      print("Error sending data over HTTP GET method");
    }

    // ignore: avoid_print
    print("Generated address");
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
        appBar: CustomAppBar(
          scrollController: _scrollController,
          title: "Generate",
          height: kToolbarHeight,
          onScroll: (aBHeight) {
            setState(() {
              appBarHeight = aBHeight;
            });
          },
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: SingleChildScrollView(
                controller: _scrollController,
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    InputText(
                      controller: fullNameController,
                      height: 40,
                      helperText: "Full name",
                      hintText: "Enter full name here",
                      padding: const EdgeInsets.only(top: 10, left: 5),
                    ),
                    InputText(
                      controller: streetInfoController,
                      height: 40,
                      helperText: "Street name and number",
                      hintText: "Enter full name here",
                      padding: const EdgeInsets.only(top: 10, left: 5),
                    ),
                    InputText(
                      controller: cityInfoController,
                      height: 40,
                      helperText: "City with postal code",
                      hintText: "Enter full name here",
                      padding: const EdgeInsets.only(top: 10, left: 5),
                    ),
                  ],
                ),
              )),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  margin: const EdgeInsets.only(bottom: 15),
                  child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      color: theme.primaryColor,
                      child: const Text(
                        "Generate",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        generate();
                      })),
            ],
          ),
        ));
  }
}

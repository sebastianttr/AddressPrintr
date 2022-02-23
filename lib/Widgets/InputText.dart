import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  final double height;
  // int width;
  final String helperText;
  final String hintText;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final TextEditingController? controller;

  final Function(String)? onChanged;

  const InputText(
      {Key? key,
      required this.height,
      required this.helperText,
      required this.hintText,
      this.onChanged,
      this.controller,
      this.margin = const EdgeInsets.all(0),
      this.padding = const EdgeInsets.all(0)})
      : super(key: key);

  @override
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  late String widgetHelperText;

  @override
  // ignore: must_call_super
  void initState() {
    widgetHelperText = widget.helperText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 2, top: 10, bottom: 2),
            child: Text(
              widget.helperText,
              textAlign: TextAlign.start,
            )),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 211, 211, 211),
              border: null,
              boxShadow: [
                BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 10,
                    color: Colors.grey.shade300)
              ]),
          margin: widget.margin,
          padding: widget.padding,
          height: widget.height,
          child: TextFormField(
            controller: widget.controller ?? TextEditingController(),
            decoration: const InputDecoration.collapsed(hintText: ""),
            style: const TextStyle(fontSize: 20),
            onChanged: (input) {
              if (widget.onChanged != null) {
                widget.onChanged!(input);
              }
            },
            onEditingComplete: () {
              print("Editing done");
            },
          ),
        )
      ],
    );
  }
}

import 'package:address_printr/Models/PDFWidgets/GenericWidget.dart';

class DText extends GenericWidget {
  final String text;
  String? fontStyle;
  double? fontSize;

  String? textAlign;

  DText(
      {required this.text,
      this.fontStyle = "Roboto",
      this.fontSize = 15,
      required double x,
      required double y,
      double height = 0,
      double width = 0,
      this.textAlign = "left"})
      : super(x: x, y: y, height: height, width: width);

  Map toJson() => {
        'type': 'Text',
        'text': text,
        'x': x,
        'y': y,
        'height': height,
        'width': width,
        'fontSize': fontSize,
        'fontStyle': fontStyle,
        'textAlign': textAlign
      };
}

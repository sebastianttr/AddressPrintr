import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectionItem extends StatefulWidget{
  final String title;
  final String description;
  final String imgPath;
  final String linksTo;

  const SelectionItem({Key? key, required this.title, required this.description, required this.imgPath, required this.linksTo}) : super(key: key);

  @override
  _SelectionItemState createState() => _SelectionItemState();

}

class _SelectionItemState extends State<SelectionItem>{


  void myFunction(String myNum){
    print(myNum);
  }

  double getWidth(){
    return MediaQuery.of(context).size.width.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          width: MediaQuery.of(context).size.width,
          clipBehavior: Clip.hardEdge,
          height: 100.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  spreadRadius: 1,
                  blurRadius:10,
                  color: Color.fromARGB(100,158, 158, 158)
              )
            ],
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(left:10,right: 10,top:4,bottom: 4),
          child:  Stack(
            children: [
              Positioned(
                  right: 0,
                  bottom: 0,
                  child: SizedBox(
                      height: 70,
                      child: Image(image: AssetImage(widget.imgPath))
                  )
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      widget.title,
                      style: const TextStyle(
                          fontSize: 30
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:5),
                    child: Text(
                      widget.description,
                      style: const TextStyle(
                          fontSize: 15
                      ),
                    ),
                  ),
                ],
              ),

            ],
          )
      ),
      onTap: () {
        print("Pressed");
        Navigator.pushNamed(context,widget.linksTo);
      },
    );
  }
}

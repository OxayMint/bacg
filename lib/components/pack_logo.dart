import 'package:flutter/material.dart';

class PackLogo extends StatelessWidget {
  PackLogo({Key key, this.number}) : super(key: key);
  final int number;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(children: [
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context)
                  .primaryColor, //Color.fromRGBO(38, 152, 34, 1),
              borderRadius: BorderRadius.circular(5)),
          width: 150,
          height: 120,
          // alignment: Alignment.centerRight,
          // padding: EdgeInsets.all(0),
          // margin: EdgeInsets.only(right: 0, top: 0),
        ),
        Container(
          alignment: Alignment.centerRight,
          width: 160,
          height: 130,
          // color: Colors.red,
          child: Text(
            "$number",
            textAlign: TextAlign.end,
            style: TextStyle(
                shadows: [
                  Shadow(
                      offset: Offset(0, 3),
                      blurRadius: 5,
                      color: Color.fromRGBO(0, 0, 0, 0.1)),
                ],
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontSize: 180,
                height: 0.85),
          ),
        ),
      ]),
    );
  }
}

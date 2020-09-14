import 'package:flutter/material.dart';

class PackLogo extends StatelessWidget {
  PackLogo({Key key, this.number, this.owned = false}) : super(key: key);
  final int number;
  final bool owned;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: _getGradient(),
            // color: Theme.of(context)
            //     .primaryColor, //Color.fromRGBO(38, 152, 34, 1),
            borderRadius: BorderRadius.circular(2),
          ),
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
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                ),
              ],
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontSize: 180,
              height: 0.85,
            ),
          ),
        ),
      ],
    );
  }

  RadialGradient _getGradient() {
    return RadialGradient(
        colors: owned
            ? [Color.fromRGBO(33, 152, 152, 1), Color.fromRGBO(17, 74, 76, 1)]
            : [Color.fromRGBO(37, 152, 33, 1), Color.fromRGBO(17, 74, 76, 1)],
        center: Alignment(1, 0),
        radius: 1.5);
  }
}

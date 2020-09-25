import 'package:flutter/material.dart';

class PackLogo extends StatelessWidget {
  PackLogo({Key key, this.number, this.owned = false}) : super(key: key);
  final int number;
  final bool owned;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 200,
          height: 200,
          child: Image.asset(
            'assets/broken_gradient.png',
            // color: Colors.transparent,
            colorBlendMode: BlendMode.modulate,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: _getGradient(),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Container(
          alignment: Alignment.bottomRight,
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
              fontWeight: FontWeight.w900,
              color: Colors.white,
              fontSize: 238,
              height: 0.8,
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

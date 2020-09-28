import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PackLogo extends StatelessWidget {
  PackLogo({Key key, this.number, this.owned = false}) : super(key: key);
  final int number;
  final bool owned;
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: AssetImage(owned
                  ? 'assets/logo_bckgrnd_blue.png'
                  : 'assets/logo_bckgrnd_green.png'),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: -15,
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
              fontSize: 229,
              height: 0.88,
              // letterSpacing: 0,
            ),
          ),
        ),
        // AspectRatio(
        //   aspectRatio: 1,
        //   child:
        // Image.asset(
        //   'assets/broken_gradient.png',
        //   color: Colors.white.withAlpha(150),
        //   colorBlendMode: BlendMode.colorBurn,
        //   fit: BoxFit.fitHeight,
        // ),
        // ),
        // SvgPicture.asset(
        //   'assets/broken_gradient_2.svg',
        //   // color: Colors.white60,
        //   fit: BoxFit.fitHeight,
        //   // colorBlendMode: BlendMode.lighten,
        // ),
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

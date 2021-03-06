import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(-1, -1),
                radius: 2.0,
                colors: [
                  Color.fromRGBO(37, 152, 33, 1),
                  Color.fromRGBO(17, 74, 76, 1)
                ],
              ),
            ),
          ),
          SizedBox.expand(
              child: SvgPicture.asset(
            'assets/broken_gradient.svg',
            fit: BoxFit.cover,
            colorBlendMode: BlendMode.darken,
          )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("assets/logo-white.png"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

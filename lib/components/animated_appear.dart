import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';

// import '';
class AnimatedAppear extends StatelessWidget {
  final Widget child;
  final String uniqueKey;
  AnimatedAppear({this.child, this.uniqueKey});
  @override
  Widget build(BuildContext context) {
    return AnimateIfVisible(
      // visibleFraction: 0.6,
      key: Key(uniqueKey),
      duration: Duration(milliseconds: 200),
      builder: (BuildContext context, Animation<double> animation) {
        // return Text("ff");
        return FadeTransition(
          opacity: Tween<double>(
            begin: 0,
            end: 1,
          ).animate(animation),
          child: SlideTransition(
              transformHitTests: true,
              position: Tween<Offset>(
                begin: Offset(0, -0.1),
                end: Offset.zero,
              ).animate(animation),
              child: child),
        );
      },
    );
  }
}

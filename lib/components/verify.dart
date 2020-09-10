
import 'package:flutter/material.dart';

class VerifyNumber extends StatefulWidget {
  VerifyNumber({Key key}) : super(key: key);

  @override
  _VerifyNumberState createState() => _VerifyNumberState();
}

class _VerifyNumberState extends State<VerifyNumber> {
  int _stage = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return  FadeTransition (child: child, opacity: animation,);
            },
            child:
            TextField(
              key: ValueKey<int>(_stage),
                // controller: loginTextField,
                decoration: InputDecoration(
                  filled: true,
                  // border: InputBorder.none,
                  labelText: "Phone number",
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: "+994 50 123 45 67 ",
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  fillColor: Colors.black45,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.phone,
              ),
            //  Text(
            //   '$_count',
            //   // This key causes the AnimatedSwitcher to interpret this as a "new"
            //   // child each time the count changes, so that it will begin its animation
            //   // when the count changes.
            //   key: ValueKey<int>(_count),
            //   style: Theme.of(context).textTheme.headline4,
            // ),
          ),
          // RaisedButton(
          //   child: const Text('c'),
          //   onPressed: () {
          //     setState(() {
          //       _count += 1;
          //     });
          //   },
          // ),
        ],
      ),
    );
  }
}
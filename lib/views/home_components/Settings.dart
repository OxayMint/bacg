import 'package:bacg/components/custom_button.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Name",
              ),
              style: TextStyle(color: Color.fromRGBO(72, 72, 72, 1)),
              keyboardType: TextInputType.name,
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "E-mail",
              ),
              style: TextStyle(color: Color.fromRGBO(72, 72, 72, 1)),
              keyboardType: TextInputType.name,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  // width: 230,
                  child: TextField(
                    // strutStyle: StrutStyle(height: 0.8),
                    decoration: InputDecoration(
                      filled: true,
                      labelText: "Phone",
                      hintText: "+994501234567",
                    ),
                    style: TextStyle(color: Color.fromRGBO(72, 72, 72, 1)),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                BacgButton(
                    text: 'Change', onPressed: () {}, type: ButtonType.Action),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BacgButton(
                    onPressed: () {},
                    type: ButtonType.Warning,
                    text: 'Discard'),
                SizedBox(
                  width: 20,
                ),
                BacgButton(
                    onPressed: () {}, type: ButtonType.Action, text: 'Save'),
              ],
            )
          ],
        ),
      ),
    );
  }
}

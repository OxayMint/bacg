import 'package:bacg/components/custom_button.dart';
import 'package:bacg/enums.dart';
import 'package:bacg/model/app_state.dart';
import 'package:bacg/model/otp_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  final _nameController = new TextEditingController();
  final _oldPhoneController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    _nameController.text = '${appState.user.name} ${appState.user.surname}';
    _oldPhoneController.text = appState.user.phone;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Text("Change phone number"),

            TextField(
              controller: _nameController,
              enabled: false,
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
              controller: _oldPhoneController,
              enabled: false,
              // strutStyle: StrutStyle(height: 0.8),
              decoration: InputDecoration(
                filled: true,
                labelText: "Phone",
              ),
              style: TextStyle(color: Color.fromRGBO(72, 72, 72, 1)),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              // strutStyle: StrutStyle(height: 0.8),
              decoration: InputDecoration(
                filled: true,
                labelText: "New phone",
                hintText: "994501234567",
              ),
              style: TextStyle(color: Color.fromRGBO(72, 72, 72, 1)),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(
              height: 20,
            ),
            ChangeNotifierProvider<OtpStateModel>(
                create: (context) => OtpStateModel(type: OtpType.Update),
                child:
                    Consumer<OtpStateModel>(builder: (context, state, widget) {
                  print(state.secondsRemaining);
                  return state.secondsRemaining <= 0
                      ? Container()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flexible(
                              // width: 230,
                              child: TextField(
                                // strutStyle: StrutStyle(height: 0.8),
                                decoration: InputDecoration(
                                  filled: true,
                                  labelText: "SMS code",
                                ),
                                style: TextStyle(
                                    color: Color.fromRGBO(72, 72, 72, 1)),
                                keyboardType: TextInputType.phone,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            BacgButton(
                                text: 'Change',
                                onPressed: () {},
                                type: ButtonType.Action),
                          ],
                        );
                })),
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

import 'package:bacg/components/custom_button.dart';
import 'package:bacg/model/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bacg/model/requests.dart' as req;

class SignUp extends StatelessWidget {
  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _surnameController = new TextEditingController();
  final TextEditingController _passController = new TextEditingController();
  final TextEditingController _passConfirmController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
// _passController.
    final appState = Provider.of<AppState>(context, listen: false);
    return SingleChildScrollView(
      child: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: "Name",
              labelStyle: TextStyle(color: Colors.white),
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
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: _surnameController,
            decoration: InputDecoration(
              labelText: "Surname",
              labelStyle: TextStyle(color: Colors.white),
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
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: "Phone",
              labelStyle: TextStyle(color: Colors.white),
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
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            obscureText: true,
            controller: _passController,
            style: TextStyle(color: Colors.white, fontSize: 16),
            decoration: InputDecoration(
              labelText: "Password",
              labelStyle: TextStyle(color: Colors.white),
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
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            obscureText: true,
            controller: _passConfirmController,
            style: TextStyle(color: Colors.white, fontSize: 16),
            decoration: InputDecoration(
              labelText: "Confirm password",
              labelStyle: TextStyle(color: Colors.white),
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
          ),
          SizedBox(
            height: 10,
          ),
          // Expanded(
          //   child: Container(),
          // ),
          BacgButton(
            text: "SIGN UP",
            type: ButtonType.Primary,
            onPressed: () {
              final request = req.Register(
                  name: _nameController.text,
                  surname: _surnameController.text,
                  phone: _phoneController.text,
                  password: _passController.text);
              print(request.toMap());
              appState.register(request);
            },
          ),
          FlatButton(
            minWidth: double.infinity,
            onPressed: () {
              appState.setLoginStage(LoginStage.SignIn);
            },
            child: new RichText(
              text: new TextSpan(
                style: new TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14.0,
                  color: Colors.white,
                ),
                children: <TextSpan>[
                  new TextSpan(
                    text: 'Already have an account? ',
                  ),
                  new TextSpan(
                    text: 'SIGN IN',
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

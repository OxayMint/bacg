import 'package:bacg/components/custom_button.dart';
import 'package:bacg/model/app_state.dart';
import 'package:bacg/services/localization.service.dart';
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  errorText: appState.registerExceptions['name'],
                  labelText: Localized("name").value,
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
                  errorText: appState.registerExceptions['surname'],
                  labelText: Localized("surname").value,
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
                  errorText: appState.registerExceptions['phone'],
                  labelText: Localized("phone").value,
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
                  errorText: appState.registerExceptions['password'],
                  labelText: Localized("password").value,
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
                  errorText: appState.registerExceptions['confirm_pass'],
                  labelText: Localized("confirm_pass").value,
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
              // ListView.builder(
              //   itemCount: appState.registerExceptions.length,
              //   itemBuilder: (BuildContext context, int index) {
              //     return ListTile();
              //   },
              // ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          // Expanded(
          //   child: Container(),
          // ),
          Column(
            children: [
              BacgButton(
                text: Localized("sign_up").value,
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
                // minWidth: double.infinity,
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
                        text: Localized('already_have_account').value,
                      ),
                      new TextSpan(
                        text: Localized('sign_in').value.toUpperCase(),
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
        ],
      ),
    );
  }
}

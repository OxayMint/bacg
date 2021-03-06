import 'package:bacg/components/custom_button.dart';
import 'package:bacg/model/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Language extends StatefulWidget {
  Language({key}) : super(key: key);
  @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  final Map<String, String> langs = {
    'GB': 'English',
    'RU': 'Русский',
    'AZ': 'Azərbaycan'
  };
  String selectedLang;
  // bool langSelected = false;
  @override
  Widget build(BuildContext context) {
    final _deviceHeight = MediaQuery.of(context).size.height;
    var state = Provider.of<AppState>(context, listen: false);
    final buttonText = _getButtonText(selectedLang);
    return SizedBox(
      height: _deviceHeight - 310,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                "Hello!",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20,
              ),
              // DropDown starts here
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: DropdownButton(
                    // isDense: true,
                    underline: Container(),
                    // style: Theme.of(context).textTheme.subtitle2,

                    value: selectedLang,
                    icon: Icon(
                      Icons.expand_more,
                      color: Colors.black,
                    ),
                    isExpanded: true,
                    hint: Text(
                      'Select language',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1, //TextStyle(color: Colors.white, fontSize: 16),
                    ),

                    onChanged: (val) {
                      setState(() {
                        selectedLang = val;
                      });
                      print(selectedLang);
                    },
                    dropdownColor: Colors.white,
                    // focusColor: Colors.red,
                    items: getDropdownItems(),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              selectedLang == null
                  ? Container()
                  : BacgButton(
                      text: buttonText, // _getButtonText(selectedLang),
                      type: ButtonType.Primary,
                      onPressed: () {
                        // login(context);
                        state.setLang(selectedLang);
                        state.setLoginStage(LoginStage.SignIn);
                        // state.setLoginStage(LoginStage.)
                      },
                    ),
              SizedBox(
                height: 25,
              ),
            ],
          )
        ],
      ),
    );
  }

  String _getButtonText(String lang) {
    switch (selectedLang) {
      case 'GB':
        return "SELECT";
      case 'RU':
        return "ВЫБОР";
      case 'AZ':
        return "SEÇ";
      default:
        return "SELECT";
    }
  }

  List<DropdownMenuItem> getDropdownItems() {
    List<DropdownMenuItem> list = [];
    langs.forEach((key, value) {
      list.add(
        DropdownMenuItem(
          value: key,
          child: Row(
            children: [
              Image.asset('assets/flags/${key.toLowerCase()}.png'),
              SizedBox(
                width: 20,
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ),
      );
    });
    return list;
  }
}

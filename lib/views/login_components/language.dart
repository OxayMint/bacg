import 'package:bacg/components/custom_button.dart';
import 'package:bacg/model/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Language extends StatefulWidget {
  @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  final Map<String, String> langs = {
    'eng': 'English',
    'rus': 'Русский',
    'az': 'Azərbaycan'
  };
  String selectedLang = null;
  // bool langSelected = false;
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AppState>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Hello!",
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 10,
        ),
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
                  print(selectedLang);
                });
              },
              dropdownColor: Colors.white,
              // focusColor: Colors.red,
              items: [
                DropdownMenuItem(
                  value: 'eng',
                  child: Row(
                    children: [
                      Image.asset('assets/eng.png'),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'English',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'aze',
                  child: Row(
                    children: [
                      Image.asset('assets/az.png'),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Azərbaycan',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'rus',
                  child: Row(
                    children: [
                      Image.asset('assets/rus.png'),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Русский',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(),
        ),
        selectedLang == null
            ? Container()
            : BacgButton(
                text: getButtonText(selectedLang),
                type: ButtonType.Primary,
                onPressed: () {
                  // login(context);
                  state.setLang(selectedLang);
                  state.setLoginStage(LoginStage.SignIn);
                },
              ),
        SizedBox(
          height: 25,
        )
      ],
    );
  }

  String getButtonText(String lang) {
    switch (lang) {
      case 'eng':
        return "SELECT";
      case 'rus':
        return "ВЫБОР";
      case 'aze':
        return "SEÇ";
      default:
        return "SELECT";
    }
  }
}

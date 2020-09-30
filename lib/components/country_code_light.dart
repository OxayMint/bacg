import 'package:flutter/material.dart';
import 'package:bacg/country_codes.dart' as countryCodes;

class CountryCodeLight extends StatelessWidget {
  CountryCodeLight(this.value, this.onChange);
  final String value;
  final Function(String, String) onChange;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 117,
      height: 39,
      child: Container(
        // color: Colors.white,
        decoration: BoxDecoration(
            color: Color.fromRGBO(247, 247, 247, 1),
            borderRadius: BorderRadius.circular(2)),
        child: DropdownButton(
          underline: Container(),
          value: value,

          icon: Icon(
            Icons.expand_more,
            color: Color.fromRGBO(143, 143, 143, 1),
          ),
          isExpanded: true,
          hint: Text(
            'Country code',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .subtitle1, //TextStyle(color: Colors.white, fontSize: 16),
          ),

          onChanged: (code) {
            onChange(
                code,
                countryCodes.countryCodes
                    .where((element) => element['code'] == code)
                    .first['dial_code']);
          },
          dropdownColor: Color.fromRGBO(247, 247, 247, 1),
          // focusColor: Colors.red,
          items: getDropdownItems(),
        ),
      ),
    );
  }

  List<DropdownMenuItem> getDropdownItems() {
    final countries = countryCodes.countryCodes;
    return countries
        .map<DropdownMenuItem>(
          (e) => DropdownMenuItem(
            value: e['code'],
            child: Container(
              color: Colors.transparent,
              height: 40,
              width: double.infinity,
              child: Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                      width: 40,
                      child: Image.asset(
                          'assets/flags/${e['code'].toLowerCase()}.png')),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    '${e['dial_code']}',
                    style: TextStyle(color: Color.fromRGBO(143, 143, 143, 1)),
                  ),
                ],
              ),
            ),
          ),
        )
        .toList();
  }
}

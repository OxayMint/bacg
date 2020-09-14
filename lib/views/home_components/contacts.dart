import 'package:bacg/components/custom_button.dart';
import 'package:bacg/components/map.dart';
import 'package:bacg/services/url.service.dart';
import 'package:flutter/material.dart';

class Contacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MapView(),
              SizedBox(
                height: 100,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  children: [
                    Text(
                      "SEND US AN EMAIL",
                      style: TextStyle(fontSize: 20, fontFamily: "Montserrat"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      // strutStyle: StrutStyle(height: 0.8),
                      decoration: InputDecoration(
                        filled: true,
                        labelText: "Name/Surname",
                      ),
                      // style: TextStyle(color: Color.fromRGBO(72, 72, 72, 1)),
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      // strutStyle: StrutStyle(height: 0.8),
                      decoration: InputDecoration(
                        filled: true,
                        labelText: "E-mail",
                      ),
                      // style: TextStyle(color: Color.fromRGBO(72, 72, 72, 1)),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      minLines: 3,
                      maxLines: 10,

                      // strutStyle: StrutStyle(height: 0.8),
                      decoration: InputDecoration(
                        filled: true,
                        labelText: "Message",
                        alignLabelWithHint: true,
                      ),
                      // style: TextStyle(color: Color.fromRGBO(72, 72, 72, 1)),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    BacgButton(
                        onPressed: () {},
                        type: ButtonType.Primary,
                        text: 'SEND'),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 200,
            child: Container(
              height: 140,
              width: 350,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 50,
                          ),
                          Icon(
                            Icons.location_on,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 190,
                            child: Text(
                                "68-72, Bulbul Avenue, 4th Floor, AZ1014, Baku, Azerbaijan",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 12)),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          UrlOpener.launchURL('tel:+994124978965');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 50,
                            ),
                            Icon(
                              Icons.phone,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              child: Text(
                                "+99412 497 89 65 / 66\n+99412 497 89 66",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          UrlOpener.launchURL('mailto:info@bacg.az');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 50,
                            ),
                            Icon(
                              Icons.mail,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              width: 100,
                              child: Text("info@bacg.az",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 12)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  /*Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 190,
                        child: Text(
                            "68-72, Bulbul Avenue, 4th Floor, AZ1014, Baku, Azerbaijan",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 12)),
                      ),
                      SizedBox(
                        child: Text(
                          "+99412 497 89 65 / 66\n+99412 497 89 66",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: Text("info@bacg.az",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  )*/
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

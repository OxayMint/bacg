import 'package:bacg/components/custom_button.dart';
import 'package:bacg/components/pack_logo.dart';
import 'package:bacg/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:auto_animated/auto_animated.dart';

class UserPack extends StatelessWidget {
  UserPack({Key key, this.pack});
  UserPackage pack;
  // int daysLeft;
  @override
  Widget build(BuildContext context) {
    return AnimateIfVisible(
      key: Key('m${pack.packageId}'),
      duration: Duration(milliseconds: 80),
      builder: (BuildContext context, Animation<double> animation) {
        return FadeTransition(
          opacity: Tween<double>(begin: 0, end: 1)
              .chain(CurveTween(curve: Curves.easeInOut))
              .animate(animation),
          child: SlideTransition(
            position: Tween<Offset>(begin: Offset(0, 0.1), end: Offset.zero)
                .chain(CurveTween(curve: Curves.easeInOut))
                .animate(animation),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Container(
                // alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 1),
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.,
                      children: [
                        SizedBox(
                          width: 178,
                          height: 160,
                          child: PackLogo(number: pack.callCount, owned: true),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Call count :",
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${pack.callCount} of ${pack.pack.callCount} left',
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Duration :",
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      pack.expired
                                          ? 'Expired'
                                          : '${pack.daysLeft} days left',
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: pack.expired
                                ? Container()
                                : BacgButton(
                                    type: ButtonType.Primary,
                                    onPressed: () {
                                      launch('tel:+994124978965');
                                    },
                                    text: "Call",
                                    iconName: 'phone',
                                    // preferredWidth: 300,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:bacg/components/animated_appear.dart';
import 'package:bacg/components/custom_button.dart';
import 'package:bacg/components/pack_logo.dart';
import 'package:bacg/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:auto_animated/auto_animated.dart';

class UserPack extends StatelessWidget {
  UserPack({Key key, this.pack});
  final UserPackage pack;
  // int daysLeft;
  @override
  Widget build(BuildContext context) {
    return AnimatedAppear(
      uniqueKey: ('m${pack.packageId}'),
      child: SizedBox(
        height: 230,
        child: Column(
          children: [
            Stack(
              // fit: ,
              fit: StackFit.passthrough,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                          width: 178,
                          height: 160,
                          child: PackLogo(number: pack.callCount, owned: true)),
                      Expanded(
                        child: Container(
                          // width: double.infinity,

                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/broken_gradient.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 23,
                                            ),
                                            Text(
                                              "Call count",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            ),
                                            // SizedBox(
                                            //   height: 5,
                                            // ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              '${pack.callCount} of ${pack.pack.callCount} left',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Duration",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          pack.expired
                                              ? 'Expired'
                                              : '${pack.daysLeft} days left',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 7,
            ),
            SizedBox(
              height: 40,
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
    );
  }
}

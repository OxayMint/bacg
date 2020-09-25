import 'package:auto_animated/auto_animated.dart';
import 'package:bacg/components/custom_button.dart';
import 'package:bacg/components/pack_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bacg/model/pack.dart' as model;

class Pack extends StatelessWidget {
  Pack({Key key, this.pack});
  final model.Pack pack;

  @override
  Widget build(BuildContext context) {
    return AnimateIfVisible(
      key: Key('${pack.id}'),
      // delay: Duration(milliseconds: 1000),
      duration: Duration(milliseconds: 20),
      builder: (BuildContext context, Animation<double> animation) {
        // return Text("ff");
        return FadeTransition(
          opacity: Tween<double>(begin: 0, end: 1)
              .chain(CurveTween(curve: Curves.easeInOut))
              .animate(animation),
          child: SlideTransition(
            position: Tween<Offset>(begin: Offset(0, 0.1), end: Offset.zero)
                .chain(CurveTween(curve: Curves.easeInOut))
                .animate(animation),
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
                              child: PackLogo(number: pack.id),
                            ),
                            Expanded(
                              child: Container(
                                // width: double.infinity,

                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/broken_gradient.png'),
                                      fit: BoxFit.cover),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Call count",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                pack.callCount.toString(),
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
                                                "${pack.duration} days",
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
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Price",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                pack.getPrice('az'),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2,
                                              ),
                                            ],
                                          ),
                                        ],
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
                    child: BacgButton(
                      type: ButtonType.Primary,
                      onPressed: () {},
                      text: "Buy",
                      iconName: 'cart',
                      // preferredWidth: 300,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

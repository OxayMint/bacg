import 'package:bacg/components/packs_list.dart';
import 'package:bacg/components/user_package.dart';
import 'package:bacg/model/user.dart';
import 'package:flutter/material.dart';
import 'package:bacg/components/pack.dart';
import 'package:bacg/model/pack.dart' as model;

class Packs extends StatefulWidget {
  @override
  _PacksState createState() => _PacksState();
}

class _PacksState extends State<Packs> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ListHeader(
            text: "MY PACKS",
          ),
          PacksList(
            packsList: <Widget>[
              UserPack(
                pack: UserPackage(
                  packageId: 2,
                  callCount: 2,
                  endAt: DateTime.now().add(new Duration(days: -3)),
                  pack: model.Pack(
                    id: 3,
                    callCount: 3,
                    // usedCallCount: 0,
                    duration: 30,
                    name: "3",
                    // isPurcshased: false,
                    priceAzn: '30',
                    priceUsd: '30',
                  ),
                ),
              ),
            ],
          ),
          ListHeader(
            text: "STORE",
          ),
          PacksList(
            packsList: <Widget>[
              Pack(
                pack: model.Pack(
                  id: 3,
                  callCount: 3,
                  // usedCallCount: 0,
                  duration: 30,
                  name: "3",
                  // isPurcshased: false,
                  priceAzn: '30',
                  priceUsd: '30',
                ),
              ),
              Pack(
                pack: model.Pack(
                  id: 5,
                  callCount: 5,
                  // usedCallCount: 0,
                  duration: 90,
                  name: "5",
                  // isPurchased: false,
                  priceAzn: '50',
                  priceUsd: '50',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> getPacksList() {}
}

class ListHeader extends StatelessWidget {
  const ListHeader({Key key, @required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        // border: Border.all(color: Theme.of(context).primaryColor)
      ),
      child: Text(text, style: Theme.of(context).textTheme.headline3),
    );
  }
}

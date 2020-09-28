import 'package:auto_animated/auto_animated.dart';
import 'package:bacg/components/animated_appear.dart';
import 'package:bacg/components/packs_list.dart';
import 'package:bacg/components/user_package.dart';
import 'package:bacg/model/app_state.dart';
import 'package:bacg/model/user.dart';
import 'package:flutter/material.dart';
import 'package:bacg/components/pack.dart';
import 'package:bacg/model/pack.dart' as model;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

// class Packs extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final storePcks =
//         Provider.of<AppState>(context, listen: false).storePackages;
//     return StorePacks(storePcks);
//   }
// }

class Packs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimateIfVisibleWrapper(
      showItemInterval: Duration(milliseconds: 100),
      child: SingleChildScrollView(
        child: Consumer<AppState>(builder: (context, state, widget) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              state.ownedPackages.length > 0
                  ? MyPacks(state.ownedPackages)
                  : Container(),
              StorePacks(state.storePackages),
            ],
          );
        }),
      ),
    );
  }
}

// class ListHeader extends StatelessWidget {
//   const ListHeader({Key key, @required this.text}) : super(key: key);
//   final String text;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 60,
//       width: double.infinity,
//       alignment: Alignment.center,
//       padding: EdgeInsets.all(5),
//       decoration: BoxDecoration(
//         color: Theme.of(context).primaryColor,
//       ),
//       child: Text(
//         text,
//         style: Theme.of(context).textTheme.headline3,
//       ),
//     );
//   }
// }

class ListHeader extends StatelessWidget {
  const ListHeader({Key key, @required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset(
              'assets/gradient_filled.png',
              fit: BoxFit.cover,
              colorBlendMode: BlendMode.color,
              color: Colors.white10,
            ),
          ),
          Center(
            child: Text(text, style: Theme.of(context).textTheme.headline3),
          ),
        ],
      ),
    );
  }
}

// class StorePacks extends StatelessWidget {
//   StorePacks(this.packs);
//   final List<model.Pack> packs;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ListHeader(
//           text: 'STORE',
//         ),
//         SizedBox(
//           height:
//               MediaQuery.of(context).size.height - 50, //230.0 * packs.length,
//           child: LiveList(

//             itemCount: packs.length,
//             showItemInterval: Duration(milliseconds: 250),
//             itemBuilder: (context, index, animation) {
//               return FadeTransition(
//                 opacity: animation,
//                 child: SlideTransition(
//                   position: Tween<Offset>(
//                     begin: Offset(0, 0.3),
//                     end: Offset.zero,
//                   ).animate(animation),
//                   child:
//                       // ListTile(
//                       //   title: Text('item $index'),
//                       // ),
//                       Pack(
//                     pack: packs[index],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

class StorePacks extends StatelessWidget {
  StorePacks(this.packs);
  final List<model.Pack> packs;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedAppear(
          uniqueKey: ('Stored Header key'),
          child: SizedBox(child: ListHeader(text: "STORE")),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: packs.map((p) => Pack(pack: p)).toList(),
          ),
        ),
      ],
    );
  }
}

class MyPacks extends StatelessWidget {
  MyPacks(this.packs);
  final List<UserPackage> packs;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedAppear(
          uniqueKey: ('My Packs key'),
          child: ListHeader(text: "MY PACKS"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: packs.map((p) => UserPack(pack: p)).toList(),
          ),
        ),
      ],
    );
  }
}

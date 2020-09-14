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
    return Column(
      children: [
        Row(
          children: [PackLogo(number: pack.id)],
        ),
        BacgButton(
          type: ButtonType.Primary,
          onPressed: () {},
          text: "Buy",
          icon: Icons.shopping_cart,
          // preferredWidth: 300,
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

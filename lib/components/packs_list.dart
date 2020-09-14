import 'package:flutter/material.dart';
import 'package:bacg/model/pack.dart' as model;

import 'pack.dart';

class PacksList extends StatefulWidget {
  PacksList({this.packsList});
  final List<Widget> packsList;
  @override
  _PacksListState createState() => _PacksListState(list: packsList);
}

class _PacksListState extends State<PacksList> {
  _PacksListState({this.list});
  final List<Widget> list;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: list,
      ),
    );
  }
}

import 'package:etno_app/store/section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'TabBarGeneral.dart';

class TabBarTecnology extends StatefulWidget {
  const TabBarTecnology({super.key});

  @override
  State<StatefulWidget> createState() {
    return PageState();
  }
}
class PageState extends State<TabBarTecnology> {
  final Section section = Section();
  @override
  void initState() {
    section.getNewsListByLocalityAndCategory('Bolea', 'Tecnología');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) => ListView(
        children: section.getListNewCategory.map((e) => cardNew(e, context)).toList()
    ));
  }
}

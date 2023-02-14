
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/appbar_navigation.dart';
import 'news/TabBarGeneral.dart';
import 'news/TabBarSalud.dart';
import 'news/TabBarTecnology.dart';

class PageNews extends StatefulWidget {
  const PageNews({super.key});

  @override
  State<StatefulWidget> createState() {
    return PageState();
  }
}
class PageState extends State<PageNews> {
  int tabIndex = 0;
  final List<String> tabs = [
    'General',
    'Tecnología',
    'Salud',
    // 'Entretenimiento',
    // 'Negocios'
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Noticias',
      home: DefaultTabController(
        initialIndex: tabIndex,
        length: tabs.length,
        child: Scaffold(
          appBar: appBarNews('Noticias', Icons.language, () => null, tabs),
          body: const TabBarView(
            children: [
                TabBarGeneral(),
                TabBarTecnology(),
                TabBarSalud()
            ],
          )
        ),
      ),
    );
  }
}
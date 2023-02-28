import 'package:etno_app/store/section.dart';
import 'package:etno_app/utils/WarningWidgetValueNotifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    return Column(
      children: [
        const WarningWidgetValueNotifier(),
        Observer(builder: (context){
          if(section.getListNewCategory.isNotEmpty){
            return ListView(
              shrinkWrap: true,
              children: section.getListNewCategory.map((e) => cardNew(e, context)).toList()
            );
          }else{
            return Container(
              padding: const EdgeInsets.only(top: 250.0),
              child: Column(
                children: [
                  Text(AppLocalizations.of(context)!.no_news_tech),
                  Icon(Icons.block, size: 120.0)
                ]
              )
            );
          }
        }
        )
      ]
    );
  }
}
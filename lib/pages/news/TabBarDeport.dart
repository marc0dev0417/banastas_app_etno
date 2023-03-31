import 'package:etno_app/store/section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../utils/WarningWidgetValueNotifier.dart';
import 'package:flutter/material.dart';
import 'TabBarGeneral.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TabBarDeport extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageState();
}
class PageState extends State<TabBarDeport> {
  final Section section = Section();

  @override
  void initState() {
    section.getNewsListByLocalityAndCategory('Bolea', 'Deporte');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          const WarningWidgetValueNotifier(),
          Observer(builder: (context){
            if(section.getListNewCategory.isNotEmpty){
              return Expanded(
                  child: ListView(
                      shrinkWrap: true,
                      children: section.getListNewCategory.map((e) => cardNew(e, context)).toList()
                  )
              );
            }else{
              return Container(
                  padding: const EdgeInsets.only(top: 250.0),
                  child: Column(
                      children: [
                        Text(AppLocalizations.of(context)!.no_news_heal, style: TextStyle(fontWeight: FontWeight.bold)),
                        Icon(Icons.newspaper, size: 50.0)
                      ]
                  )
              );
            }
          })
        ]
    );
  }
}
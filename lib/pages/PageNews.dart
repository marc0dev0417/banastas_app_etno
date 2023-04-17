import 'package:etno_app/pages/news/TabBarDeport.dart';
import 'package:etno_app/provider/locale_provider.dart';
import 'package:etno_app/widgets/bottom_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../l10n/l10n.dart';
import '../widgets/appbar_navigation.dart';
import 'news/TabBarGeneral.dart';
import 'news/TabBarSalud.dart';
import 'news/TabBarTecnology.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PageNews extends StatefulWidget {
  const PageNews({super.key, required this.pageContext});

final BuildContext pageContext;

  @override
  State<StatefulWidget> createState() {
    return PageState();
  }
}
class PageState extends State<PageNews> {
  int tabIndex = 0;
  PageNews get prop => widget;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      builder: (context, child){
        final List<String> tabs = [
          AppLocalizations.of(context)!.news_general,
          AppLocalizations.of(context)!.news_tecnology,
          AppLocalizations.of(context)!.news_heal,
          AppLocalizations.of(context)!.sport
        ];
        return DefaultTabController(
            initialIndex: tabIndex,
            length: tabs.length,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: appBarNews(context, AppLocalizations.of(context)!.bottom_news, Icons.language, () => null, tabs),
              body: TabBarView(
                    children: [
                      TabBarGeneral(),
                      TabBarTecnology(),
                      TabBarSalud(),
                      TabBarDeport()
                    ],
                  ),
              bottomNavigationBar: bottomNavigation(context, 2)
              ),
        );
      }
  );
}
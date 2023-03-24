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
  const PageNews({super.key});

  @override
  State<StatefulWidget> createState() {
    return PageState();
  }
}
class PageState extends State<PageNews> {
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      builder: (context, child){
        final provider = Provider.of<LocaleProvider>(context);
        final List<String> tabs = [
          AppLocalizations.of(context)!.news_general,
          AppLocalizations.of(context)!.news_tecnology,
          AppLocalizations.of(context)!.news_heal,
          'Deporte'
        ];
        return MaterialApp(
          theme: ThemeData(useMaterial3: true, tabBarTheme: const TabBarTheme(labelColor: Colors.white)),
          locale: provider.locale,
          supportedLocales: L10n.all,
          title: 'Noticias',
          home: DefaultTabController(
            initialIndex: tabIndex,
            length: tabs.length,
            child: Scaffold(
                backgroundColor: Colors.white,
                appBar: appBarNews(AppLocalizations.of(context)!.bottom_news, Icons.language, () => null, tabs),
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
          ),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
        );
      }
  );
}
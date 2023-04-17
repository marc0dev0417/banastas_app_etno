import 'package:etno_app/bloc/color/color_bloc.dart';
import 'package:etno_app/pages/PageServicesList.dart';
import 'package:etno_app/utils/WarningWidgetValueNotifier.dart';
import 'package:etno_app/widgets/appbar_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PageServices extends StatefulWidget {
  const PageServices({super.key});
  @override
  State<StatefulWidget> createState() {
    return PageState();
  }
}
class PageState extends State<PageServices> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(useMaterial3: true),
      title: 'Page services',
      home: Scaffold(
          appBar: appBarCustom(context, true, AppLocalizations.of(context)!.section_service, Icons.language, false, () => null),
          body: SafeArea(
              child: Column(
                  children: [
                    const WarningWidgetValueNotifier(),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: ListView(
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                          scrollDirection: Axis.vertical,
                          children: [
                            cardServiceTest(AppLocalizations.of(context)!.restaurants, AppLocalizations.of(context)!.see_more, () { Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => PageServicesList(locality: 'Bolea', category: AppLocalizations.of(context)!.restaurants), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)); }, context.watch<ColorBloc>().state.colorPrimary),
                            SizedBox(height: 16.0),
                            cardServiceTest(AppLocalizations.of(context)!.hotels, AppLocalizations.of(context)!.see_more, () { Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => PageServicesList(locality: 'Bolea', category: AppLocalizations.of(context)!.hotels), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)); }, context.watch<ColorBloc>().state.colorPrimary),
                            SizedBox(height: 16.0),
                            cardServiceTest(AppLocalizations.of(context)!.heal, AppLocalizations.of(context)!.see_more, (){ Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => PageServicesList(locality: 'Bolea', category: AppLocalizations.of(context)!.heal), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)); }, context.watch<ColorBloc>().state.colorPrimary),
                            SizedBox(height: 16.0),
                            cardServiceTest(AppLocalizations.of(context)!.leisure, AppLocalizations.of(context)!.see_more, (){ Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => PageServicesList(locality: 'Bolea', category: AppLocalizations.of(context)!.leisure), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)); }, context.watch<ColorBloc>().state.colorPrimary),
                            SizedBox(height: 16.0),
                            cardServiceTest(AppLocalizations.of(context)!.others, AppLocalizations.of(context)!.see_more, () { Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => PageServicesList(locality: 'Bolea', category: AppLocalizations.of(context)!.others), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)); }, context.watch<ColorBloc>().state.colorPrimary),
                          ],
                        ),
                      ),
                    ),
                  ]
              )
          )
      ),
    );
  }
}

Widget cardServiceTest(
    String title,
    String description,
    Function() function,
    Color color
    ) {
  return Container(
    child: GestureDetector(
      onTap: function,
      child: Card(
          elevation: 5.0,
          color: color,
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.face, size: 40.0, color: Colors.white),
                SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.0)),
                    Text(description, style: TextStyle(color: Colors.yellow))
                  ],
                )
              ],
            ),
          )
      ),
    ),
  );
}
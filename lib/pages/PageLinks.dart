import 'package:etno_app/bloc/color/color_bloc.dart';
import 'package:etno_app/store/section.dart';
import 'package:etno_app/utils/WarningWidgetValueNotifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../models/Link.dart';
import '../utils/Globals.dart';
import '../widgets/appbar_navigation.dart';

class PageLinks extends StatefulWidget {
  const PageLinks({super.key});

  @override
  State<StatefulWidget> createState() {
    return PageState();
  }
}

class PageState extends State<PageLinks> {
  final Section section = Section();

  @override
  void initState() {
    section.getAllLinksByLocality('${Globals.locality}');
    super.initState();
  }

  @override
  Widget build(BuildContext pageContext) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: false, cardTheme: CardTheme(color: context.watch<ColorBloc>().state.colorSecondary)),
      title: 'Page Enlaces',
      home: Scaffold(
          appBar: appBarCustom(context, true, AppLocalizations.of(context)!.section_link, Icons.language, false, () => null, null),
          body: SafeArea(
            child: Column(
              children: [
                const WarningWidgetValueNotifier(),
                Observer(builder: (context){
                  if(section.getLinks.isNotEmpty){
                    return Expanded(
                        child: ListView(
                            shrinkWrap: true,
                            children: section.getLinks.map((e) => cardLink(context, e)).toList()
                        )
                    );
                  }else{
                    return Container(
                      height: 600.0,
                      alignment: Alignment.center,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(AppLocalizations.of(pageContext)!.no_link, style: TextStyle(fontWeight: FontWeight.bold)),
                            Icon(Icons.link, size: 50.0)
                          ]
                      ),
                    );
                  }
                })
              ],
            ),
          )
      ),
    );
  }
}

Widget cardLink(BuildContext context, Link link){
  Future<void> launchInBrowser(Uri url) async{
    if(!await launchUrl(
        url,
        mode: LaunchMode.externalApplication
    )){
      throw Exception('Could not launch $url');
    }
  }
  return SizedBox(
    child: InkWell(
      child: Card(
            child: Container(
              padding: const EdgeInsets.all(15.0),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Icon(Icons.link, size: 30.0, color: context.watch<ColorBloc>().state.colorPrimary),
                    Flexible(child: Text(link.title!, style: const TextStyle(fontWeight: FontWeight.bold))),
                    ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(context.watch<ColorBloc>().state.colorPrimary)), onPressed: () => launchInBrowser(Uri.parse(link.url!)), child: Text('Visitar', style: TextStyle(color: context.watch<ColorBloc>().state.colorSecondary)))
                  ]
              )
            )
      ),
    ),
  );
}
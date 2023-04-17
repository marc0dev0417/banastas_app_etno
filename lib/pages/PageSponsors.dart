import 'package:etno_app/store/section.dart';
import 'package:etno_app/utils/WarningWidgetValueNotifier.dart';
import 'package:etno_app/widgets/appbar_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../models/Sponsor.dart';
class PageSponsors extends StatefulWidget {
  const PageSponsors({super.key});
  @override
  State<StatefulWidget> createState() {
    return PageState();
  }
}
class PageState extends State<PageSponsors> {
  final Section section = Section();
  @override
  void initState() {
    section.getSponsorsByLocality('Bolea');
    super.initState();
  }
  @override
  Widget build(BuildContext pageContext) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: false, cardTheme: const CardTheme(color: Colors.white)),
      title: 'Page Sponsors',
      home: Scaffold(
          appBar: appBarCustom(context, true, AppLocalizations.of(context)!.section_sponsor, Icons.language, false, () => null),
          body: SafeArea(
              child: Container(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                    children: [
                      const WarningWidgetValueNotifier(),
                      Observer(builder: (context){
                        if(section.getSponsors.isNotEmpty){
                          return Expanded(
                              child: ListView(
                                  shrinkWrap: true,
                                  children: section.getSponsors.map((e) => cardSponsor(e)).toList()
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
                                  Text(AppLocalizations.of(pageContext)!.no_sponsor, style: TextStyle(fontWeight: FontWeight.bold)),
                                  Icon(Icons.handshake, size: 50.0)
                                ]
                            ),
                          );
                        }
                      })
                    ]
                ),
              )
          )
      ),
    );
  }
}
Widget cardSponsor(Sponsor sponsor){
  return InkWell(
    child: Card(
        child: Container(
          padding: const EdgeInsets.all(14.0),
          child:  Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Icon(Icons.apartment_sharp),
                  const SizedBox(width: 4.0),
                  Text(sponsor.title!)
                ],
              ),
              const SizedBox(height: 4.0),
              Text(sponsor.description!),
              if(sponsor.urlImage != null) Image.network(sponsor.urlImage!) else Image.asset('assets/sponsors.png')
            ],
          ),
        )
    ),
  );
}
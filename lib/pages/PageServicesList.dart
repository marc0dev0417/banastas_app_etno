import 'dart:async';

import 'package:etno_app/main.dart';
import 'package:etno_app/utils/WarningWidgetValueNotifier.dart';
import 'package:etno_app/widgets/appbar_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/Service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../store/section.dart';

class PageServicesList extends StatefulWidget{
  const PageServicesList({super.key, required this.locality, required this.category});

  final String locality;
  final String category;

  @override
  State<StatefulWidget> createState() {
    return ServicesListState();
  }
}

class ServicesListState extends State<PageServicesList> {
  final Section section = Section();
  PageServicesList get props => super.widget;

  @override
  void initState() {
    section.getAllServiceByLocalityAndCategory(props.locality, props.category);
    super.initState();
  }

  Widget renderWidgets(BuildContext contextState){
      return Observer(builder: (context) {
        if(section.getListServices.isNotEmpty){
          return servicesList(section, contextState);
        }else{
          return Container(
            padding: const EdgeInsets.only(top: 300.0),
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(AppLocalizations.of(contextState)!.no_service, style: TextStyle(fontWeight: FontWeight.bold)),
                Icon(Icons.medical_information, size: 50.0)
              ]
            )
          );
        }
      });
    }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(cardTheme: const CardTheme(color: Colors.white)),
      title: 'Page services',
      home: Scaffold(
          appBar: appBarCustom(context, true , props.category, Icons.language, false, () => null),
          body: SafeArea(
              child: Column(
                  children: [
                    const WarningWidgetValueNotifier(),
                    Container(
                        padding: const EdgeInsets.all(15.0),
                        child:
                        renderWidgets(context)
                    )
                  ]
              )
          )
      ),
    );
  }
}

Widget servicesList(Section section, BuildContext context){
  Future<void> launchCaller(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
  return ListView(
    shrinkWrap: true,
    children:
      section.getListServices.map((e) =>
          InkWell(
            child: Container(
              alignment: Alignment.topLeft,
              child: Card(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          renderImageServiceList(e),
                          SizedBox(width: 5.0),
                          Text(e.owner!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0)),
                          const SizedBox(width: 100.0),
                          const Icon(Icons.phone, size: 15.0),
                          const SizedBox(width: 5.0),
                          Text(e.number!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0)),
                        ],
                      ),
                      const Divider(),
                      Container(
                        padding: const EdgeInsets.only(left: 15.0, bottom: 5.0),
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppLocalizations.of(context)!.type_service, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0)),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(AppLocalizations.of(context)!.service, style: const TextStyle(color: Colors.grey, fontSize: 10.0)),
                                     const SizedBox(
                                        width: 180.0,
                                      ),
                                      ElevatedButton(
                                          onPressed: (){ launchCaller(e.number!); },
                                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                          child: Text(AppLocalizations.of(context)!.call),
                                      )
                            ]),
                          ],
                        ),
                      )
                    ],
                  )
              ),
            ),
          )
      ).toList()
  );
}

Widget renderImageServiceList(Service service){
  if (service.imageUrl == null){
    return Image.asset('assets/services.png', height: 200, width: 200);
  }else{
    return  ClipRRect(borderRadius: BorderRadius.circular(500.0),
      child: Image.network(
          service.imageUrl!,
          width: 50,
          height: 50,
        fit: BoxFit.cover,
      )); //Image.network(service.imageUrl!, fit: BoxFit.fill, height: 40, width: 40);
  }
}
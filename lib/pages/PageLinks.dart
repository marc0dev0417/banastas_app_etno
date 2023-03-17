import 'package:etno_app/store/section.dart';
import 'package:etno_app/utils/WarningWidgetValueNotifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/Link.dart';
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
    section.getAllLinksByLocality('Bolea');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, cardTheme: const CardTheme(color: Colors.white)),
      title: 'Page Enlaces',
      home: Scaffold(
          appBar: appBarCustom('Enlaces', Icons.language, () => null, null),
          body: SafeArea(
            child: Column(
              children: [
                const WarningWidgetValueNotifier(),
                Observer(builder: (context){
                  if(section.getLinks.isNotEmpty){
                    return Expanded(
                        child: ListView(
                            shrinkWrap: true,
                            children: section.getLinks.map((e) => cardLink(e)).toList()
                        )
                    );
                  }else{
                    return Container(
                      height: 550.0,
                      alignment: Alignment.center,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.block, size: 120.0),
                            Text('No hay enlaces para mostrar')
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

Widget cardLink(Link link){
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
                    const Icon(Icons.link, size: 30.0, color: Colors.red),
                    Flexible(child: Text(link.title!, style: const TextStyle(fontWeight: FontWeight.bold))),
                    ElevatedButton(style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red)), onPressed: () => launchInBrowser(Uri.parse(link.url!)), child: const Text('Visitar', style: TextStyle(color: Colors.white)))
                  ]
              )
            )
      ),
    ),
  );
}
import 'package:etno_app/store/section.dart';
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
    return Scaffold(
      appBar: appBarCustom('Enlaces', Icons.language, () => null),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Observer(builder: (context) => ListView(
            children: section.getLinks.map((e) => cardLink(e)).toList()
          ))
        ),
      )
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
                    const Icon(Icons.link, size: 30.0),
                     Text(link.title!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    ElevatedButton(style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red)), onPressed: () => launchInBrowser(Uri.parse(link.url!)), child: const Text('Visitar'))
                  ]
              )
            )
      ),
    ),
  );
}
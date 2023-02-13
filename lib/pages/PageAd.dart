import 'package:etno_app/store/section.dart';
import 'package:etno_app/widgets/appbar_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/menu/Ad.dart';

class PageAd extends StatefulWidget {
  const PageAd({super.key});

  @override
  State<StatefulWidget> createState() {
    return PageState();
  }
}

class PageState extends State<PageAd> {
  final Section section = Section();

  @override
  void initState() {
    section.getAllAdsByLocality('Bolea');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom('Anuncios', Icons.language, () => null),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Observer(builder: (context) => ListView(
            children: section.getAds.map((e) => cardAd(e)).toList()
          ))
        ) ,
      ),
    );
  }
}
Widget cardAd(Ad ad){
  Future<void> launchInBrowser(Uri url) async{
    if(!await launchUrl(
        url,
        mode: LaunchMode.externalApplication
    )){
      throw Exception('Could not launch $url');
    }
  }
  return InkWell(
    onTap: () => launchInBrowser(Uri.parse(ad.webUrl!)),
    child: Card(
      child: Container(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
                children: [
                  const Icon(Icons.apartment),
                  const SizedBox(width: 4.0),
                  Text(ad.title!, style: const TextStyle(color: Colors.red))
                ]
            ),
            const SizedBox(height: 4.0),
            Text(ad.description!),
            if(ad.imageUrl != null) Image.network(ad.imageUrl!)
          ],
        ),
      )
    ),
  );
}
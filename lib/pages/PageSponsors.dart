import 'package:etno_app/store/section.dart';
import 'package:etno_app/widgets/appbar_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom('Patrocinadores', Icons.language, () => null),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Observer(builder: (context) => ListView(
            children: section.getSponsors.map((e) => cardSponsor(e)).toList()
          ))
        )
      )
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
           if(sponsor.urlImage != null) Image.network(sponsor.urlImage!)
          ],
        ),
      )
    ),
  );
}
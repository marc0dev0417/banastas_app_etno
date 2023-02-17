import 'package:etno_app/store/section.dart';
import 'package:etno_app/utils/WarningWidgetValueNotifier.dart';
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
        child: Column(
          children: [
            const WarningWidgetValueNotifier(),
            Container(
                padding: const EdgeInsets.all(15.0),
                child: Observer(builder: (context){
                  if(section.getSponsors.isNotEmpty){
                    return ListView(
                        shrinkWrap: true,
                        children: section.getSponsors.map((e) => cardSponsor(e)).toList()
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
                            Text('No hay patrocinadores para mostrar')
                          ]
                      ),
                    );
                  }
                })
            )
          ]
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
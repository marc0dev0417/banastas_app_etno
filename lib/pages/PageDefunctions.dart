import 'package:etno_app/models/Defunction.dart';
import 'package:etno_app/store/section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../widgets/appbar_navigation.dart';

class PageDefunctions extends StatefulWidget {
  const PageDefunctions({super.key});
  @override
  State<StatefulWidget> createState() {
    return PageState();
  }
}

class PageState extends State<PageDefunctions> {
  final Section section = Section();

  @override
  void initState() {
    section.getAllDefunctionsByLocality('Bolea');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(
        'Defunciones',
        Icons.language,
          () => null
      ),
      body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(15.0),
            child: Observer(
                builder: (context) => ListView(
                  children: section.getDefunctions.map((e) => cardDefunction(context, e)).toList()
                )
            )
          )
      )
    );
  }
}

Widget cardDefunction(BuildContext context, Defunction defunction){
  return SizedBox(
    height: 100,
    child: InkWell(
      child: Card(
        child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
               Image.asset('assets/pass.png', height: 35.0, width: 35.0),
              const SizedBox(
                width: 16.0
              ),
              Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(defunction.name!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 2.0),
                    Text('Fallecido el ${defunction.deathDate}', style: const TextStyle(color: Colors.grey)),
                    const SizedBox(height: 2.0),
                    Text(defunction.description!),
                  ]
              ),
              const SizedBox(
                width: 70.0
              ),
              const Icon(Icons.chevron_right)
            ]
        )
      )
    )
  );
}
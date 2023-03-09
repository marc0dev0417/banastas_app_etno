import 'package:etno_app/pages/PageReserve.dart';
import 'package:etno_app/pages/PageSeeMyReserves.dart';
import 'package:etno_app/store/section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:readmore/readmore.dart';

import '../models/Reserve.dart';
import '../widgets/appbar_navigation.dart';

class PageListReserves extends StatefulWidget {
  const PageListReserves({super.key});

  @override
  State<StatefulWidget> createState() {
    return PageState();
  }
}

class PageState extends State<PageListReserves> {
  final Section section = Section();
  @override
  void initState() {
    section.getReservesByLocality('Bolea');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(useMaterial3: true, floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: Colors.red)),
        home: Scaffold(
          appBar: appBarCustom('Reservas', Icons.language, () => null),
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Observer(builder: (context){
                return ListView(
                  children: section.getReserves.map((e) => cardReserve(context, e)).toList()
                );
              }
              )
            ),
          ),
          floatingActionButton: Container(
            width: 200.0,
            child: FloatingActionButton(
              onPressed: () => Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => const PageSeeMyReserves(), reverseTransitionDuration: Duration.zero, transitionDuration: Duration.zero)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(Icons.sell, color: Colors.white),
                  Text('Ver mis reservas', style: TextStyle(color: Colors.white))
                ],
              ),
            ),
          )
        ),
    );
  }
}

Widget cardReserve(BuildContext context, Reserve reserve){
  return SizedBox(
    height: 200.0,
    child: InkWell(
      child: Card(
        color: Colors.white,
        elevation: 5.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: 200.0,
                child: Image.network('https://allforpadel.com/img/cms/pistas/fx2-1.jpg', width: 160.0, height: 200.0, fit: BoxFit.fill)
            ),
            const SizedBox(width: 45.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(reserve.place!.name!, style: const TextStyle(fontWeight: FontWeight.bold)),
                ElevatedButton(onPressed: () => Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => PageReserve(reserve: reserve))), style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red)), child: const Text('Ver reserva', style: TextStyle(color: Colors.white)))
              ]
            )
          ],
        ),
      ),
    ),
  );
}
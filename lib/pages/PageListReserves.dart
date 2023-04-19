import 'package:etno_app/pages/PageReserve.dart';
import 'package:etno_app/pages/PageSeeMyReserves.dart';
import 'package:etno_app/store/section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
  Widget build(BuildContext pageContext) {
    return MaterialApp(
      theme: ThemeData(
          useMaterial3: true,
          floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: Colors.red)),
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: appBarCustom(
              context,
              true,
              AppLocalizations.of(context)!.section_booking,
              Icons.language,
              false,
                  () => null),
          body: SafeArea(child: Observer(builder: (context) {
            if (section.getReserves.isNotEmpty) {
              return Container(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                      children: section.getReserves
                          .map((e) => cardReserve(pageContext, e))
                          .toList()));
            } else {
              return Container(
                alignment: Alignment.center,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(AppLocalizations.of(pageContext)!.no_book,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Icon(Icons.beenhere, size: 50.0)
                    ]),
              );
            }
          })),
          floatingActionButton: Container(
            width: 200.0,
            child: FloatingActionButton(
              onPressed: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                      const PageSeeMyReserves(),
                      reverseTransitionDuration: Duration.zero,
                      transitionDuration: Duration.zero)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.sell, color: Colors.white),
                  Text(AppLocalizations.of(context)!.see_book,
                      style: TextStyle(color: Colors.white))
                ],
              ),
            ),
          )),
    );
  }
}

Widget cardReserve(BuildContext context, Reserve reserve) {
  return Container(
    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
    height: 200.0,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
    child: InkWell(
        child: Card(
          color: Colors.white,
          elevation: 5.0,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: renderImage(reserve),
                    fit: BoxFit.fill,
                    opacity: 0.4,
                ),
                borderRadius: BorderRadius.circular(10.0)
            ),
            child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Text(reserve.place!.name!,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                    onPressed: () => Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                PageReserve(reserve: reserve))),
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.red)),
                    child: Text(AppLocalizations.of(context)!.see,
                        style: TextStyle(color: Colors.white)))
              ])
            ],
          ),
        ),
      ),
    )
  );
}

ImageProvider<Object> renderImage(Reserve reserve) {
  if (reserve.place!.imageUrl == null)
    return AssetImage('assets/travel.jpg');
  else
    return NetworkImage(reserve.place!.imageUrl!);
}
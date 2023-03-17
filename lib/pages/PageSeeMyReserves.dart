import 'package:etno_app/pages/PageMyReserveDetails.dart';
import 'package:etno_app/pages/PageReserve.dart';
import 'package:etno_app/widgets/appbar_navigation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/Reserve.dart';
import '../models/ReserveUser.dart';
import '../store/section.dart';

class PageSeeMyReserves extends StatefulWidget {
  const PageSeeMyReserves({super.key});

  @override
  State<StatefulWidget> createState() {
    return PageState();
  }
}
class PageState extends State<PageSeeMyReserves> {
  final Section section = Section();
  @override
  void initState() {
    FirebaseMessaging.instance.getToken().then((fcmToken) => section.getReserveUserByFcmToken(fcmToken!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'See My reserves Page',
      home: Scaffold(
        appBar: appBarCustom("Mis Reservas", Icons.language, () => null),
        body: SafeArea(
          child: Observer(builder: (context){
            if (section.getReserveUser.isNotEmpty){
              return Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Observer(builder: (context){
                    return ListView(
                        children: section.getReserveUser.map((e) => cardMyReserve(context, e)).toList()
                    );
                  })
              );
            } else {
              return Container(
                alignment: Alignment.center,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.block, size: 120.0),
                      Text('Aun no dispones de reservas')
                    ]
                ),
              );
            }
          })
        )
      )
    );
  }
}

Widget cardMyReserve(BuildContext context, ReserveUser reserveUser) {
  return SizedBox(
    height: 130.0,
    width: double.maxFinite,
    child: GestureDetector(
      onTap: () => Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => PageMyReserveDetails(reserve: Reserve.prop(reserveUser.place, reserveUser.isReserved, reserveUser.description, reserveUser.reservePhone, reserveUser.date, reserveUser.reserveSchedules)))) ,
      child: Card(
        child: Row(
          children: [
            const VerticalDivider(
              color: Colors.blue,
              thickness: 5,
            ),
            const SizedBox(width: 22.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
               Flexible(child: Text(reserveUser.place!.name! , style: const TextStyle(fontWeight: FontWeight.bold)),),
                 Text(reserveUser.date!, style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 10.0)),
                Text(reserveUser.place!.username!, style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 10.0)),
              ],
            ),
            const SizedBox(width: 40.0),
            Container(
                alignment: Alignment.center,
                height: 30.0,
                width: 100.0,
                color: !reserveUser.isReserved! ? Colors.red : Colors.green,
                child: !reserveUser.isReserved! ?  const Text('En espera...', style: TextStyle(fontSize: 12.0, color: Colors.white)) : const Text('Confirmado', style: TextStyle(fontSize: 12.0, color: Colors.white))
            )
          ],
        ),
      ),
    ),
  );
}
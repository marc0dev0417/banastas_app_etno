
import 'dart:async';

import 'package:etno_app/widgets/appbar_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/Service.dart';

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
  late StreamSubscription internetSubscription;
  bool connection = true;
  final Section section = Section();
  PageServicesList get props => super.widget;

  @override
  void initState() {
    internetSubscription = InternetConnectionChecker().onStatusChange.listen((status) {
      setState(() {
        connection = status == InternetConnectionStatus.connected;
        section.getAllServiceByLocalityAndCategory(props.locality, props.category);
      });
    });
    section.getAllServiceByLocalityAndCategory(props.locality, props.category);
    super.initState();
  }
  @override
  void dispose() {
    internetSubscription.cancel();
    super.dispose();
  }

  Widget renderWidgets(){
    if(connection){
      return Observer(builder: (context) {
        if(section.getListServices.isNotEmpty){
          return servicesList(section);
        }else{
          return Container(
            alignment: Alignment.center,
            child: Text('No hay servicios en este momento'),
          );
        }
      });
    }else{
      return Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.wifi_off, size: 160.0),
            Text('No hay Conexión a Internet'),
          ]
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: appBarCustom(props.category, Icons.language, () => null),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child:
             renderWidgets()
        )
      )
    );
  }
}

Widget servicesList(Section section){
  Future<void> launchCaller(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
  return ListView(
    children:
      section.getListServices.map((e) =>
          InkWell(
            child: Container(
              alignment: Alignment.topLeft,
              child: Card(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          renderImageServiceList(e),
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
                            const Text('Tipo de servicio', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0)),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(e.category!, style: const TextStyle(color: Colors.grey, fontSize: 10.0)),
                                     const SizedBox(
                                        width: 180.0,
                                      ),
                                      ElevatedButton(
                                          onPressed: (){ launchCaller(e.number!); },
                                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                          child: const Text('Llamar'),
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
    return Image.asset('assets/Loading_icon.gif', height: 20, width: 20);
  }else{
    return  ClipRRect(borderRadius: BorderRadius.circular(500.0),
      child: Image.network(
          service.imageUrl!,
          width: 50,
          height: 50
      )); //Image.network(service.imageUrl!, fit: BoxFit.fill, height: 40, width: 40);
  }
}
import 'package:etno_app/pages/incident/IncidentForm.dart';
import 'package:etno_app/utils/WarningWidgetValueNotifier.dart';
import 'package:etno_app/widgets/appbar_navigation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../models/Incident.dart';
import '../../store/section.dart';

class PageIncidents extends StatefulWidget {
  const PageIncidents({super.key});

  @override
  State<StatefulWidget> createState() {
    return PageState();
  }
}

class PageState extends State<PageIncidents> {
  final Section section = Section();
  List<Incident> incidents = [];
  
  @override
  void initState() {
    FirebaseMessaging.instance.getToken().then((value) => section.getAllIncidentByLocalityAndFcmToken('Bolea', value!).then((value) =>
        setState(() {
            incidents = value;
        })
    ));
    super.initState();
  }

  Widget renderIncidents(){
    if(incidents.isNotEmpty){
      return ListView(
          shrinkWrap: true,
          children: incidents.map((e) => cardIncident(e)).toList()
      );
    }else{
      return Container(
        padding: EdgeInsets.only(top: 280.0),
        alignment: Alignment.center,
        child: Column(
          children: const [
            Icon(Icons.block, size: 120.0),
            Text('No tienes incidencias en este momento')
          ],
        ),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom('Mis Incidencias', Icons.language, () => null),
      body: Column(
        children: [
          const WarningWidgetValueNotifier(),
          Container(
              padding: const EdgeInsets.all(4.0),
              child: renderIncidents()
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) =>  const IncidentForm(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)),
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
      ),
    );
  }
}



Widget cardIncident(Incident incident){
  return InkWell(
    child: Card(
      child: Container(
        padding: const EdgeInsets.all(4.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.warning, color: Colors.yellow),
              Text('INCIDENTE - ${incident.title!}', style: const TextStyle(fontWeight: FontWeight.bold)),
              const Icon(Icons.verified, color: Colors.red)
            ]
        ),
      )
    )
  );
}
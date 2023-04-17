import 'package:etno_app/main.dart';
import 'package:etno_app/pages/incident/IncidentForm.dart';
import 'package:etno_app/utils/WarningWidgetValueNotifier.dart';
import 'package:etno_app/widgets/appbar_navigation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
          children: incidents.map((e) => cardIncidents(context, e)).toList()
      );
    }else{
      return Container(
        padding: EdgeInsets.only(top: 280.0),
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(AppLocalizations.of(context)!.no_incident, style: TextStyle(fontWeight: FontWeight.bold)),
            Icon(Icons.dangerous, size: 50.0)
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mis incidencias',
      home: Scaffold(
        appBar: appBarCustom(context, true , AppLocalizations.of(context)!.section_incident, Icons.language, false, () => null, null),
        body: ListView(
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
Widget cardIncidents(BuildContext context, Incident incident) {
  return SizedBox(
    height: 130.0,
    width: double.maxFinite,
    child: GestureDetector(
      onTap: () {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            backgroundColor: Colors.white,
            title: Text('Resolución'),
            content: incident.solution != null ? Text(incident.solution!, style: TextStyle(color: Colors.green)) : Text('No hay solución disponible aún', style: TextStyle(color: Colors.red)),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Salir'),
                child: const Text('Salir'),
              ),
            ],
          ),
        );
      },
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
              children: [
                Text(incident.title! , style: const TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
            const SizedBox(width: 40.0),
            Container(
                alignment: Alignment.center,
                height: 30.0,
                width: 150.0,
                color: !incident.isSolved! ? Colors.red : Colors.green,
                child: !incident.isSolved! ?  Text(AppLocalizations.of(context)!.awaiting_resolution, style: TextStyle(fontSize: 12.0, color: Colors.white)) : const Text('Resuelta', style: TextStyle(fontSize: 12.0, color: Colors.white))
            )
          ],
        ),
      ),
    ),
  );
}
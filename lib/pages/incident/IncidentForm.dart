import 'package:etno_app/models/Incident.dart';
import 'package:etno_app/models/MailDetails.dart';
import 'package:etno_app/pages/incident/PageIncidents.dart';
import 'package:etno_app/widgets/appbar_navigation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../store/section.dart';
class IncidentForm extends StatefulWidget {
  const IncidentForm({super.key});
  @override
  State<StatefulWidget> createState() {
    return PageState();
  }
}

class PageState extends State<IncidentForm> {
  final Section section = Section();
  String subject = '';
  String name = '';
  String description = '';
  String phone = '';

  addIncidentAPI() {
    if (subject != '' || name != '' || description != '' || phone != '') {
      FirebaseMessaging.instance.getToken().then((value) => section.addIncident(
          Incident(null, 'Bolea', value, subject, description, false, null)));
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.toast_send_mail,
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 12,
          textColor: Colors.white,
          backgroundColor: Colors.orange);
      section
          .sendMailMessage(MailDetails(
          'ecomputerapps@gmail.com',
          'Mi nombre es $name y mi teléfono es el $phone, y tengo la siguiente incidencia: $description',
          subject,
          null))
          .then((value) => Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.toast_send_mail_correct,
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 12,
          textColor: Colors.white,
          backgroundColor: Colors.green));
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.toast_error,
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 12,
          textColor: Colors.white,
          backgroundColor: Colors.red);
    }
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: appBarCustom(
          context,
          true,
          AppLocalizations.of(context)!.section_incident,
          Icons.language,
          false,
              () => null,
          null),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Image.asset('assets/app.png', height: 120.0, width: 120.0),
          const SizedBox(height: 20.0),
          TextFormField(
            onChanged: (value) => setState(() {
              subject = value;
            }),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.warning),
                labelText: AppLocalizations.of(context)!.reason,
                border: OutlineInputBorder()),
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            onChanged: (value) => setState(() {
              description = value;
            }),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.description),
                labelText: AppLocalizations.of(context)!.description,
                border: OutlineInputBorder()),
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            onChanged: (value) => setState(() {
              name = value;
            }),
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: AppLocalizations.of(context)!.form_name,
                border: OutlineInputBorder()),
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            onChanged: (value) => setState(() {
              phone = value;
            }),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone),
                labelText: AppLocalizations.of(context)!.form_phone,
                border: OutlineInputBorder()),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
              onPressed: () => addIncidentAPI(),
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.red)),
              child: Text(AppLocalizations.of(context)!.send,
                  style: TextStyle(color: Colors.white))),
        ]),
      ),
    );
  }
}
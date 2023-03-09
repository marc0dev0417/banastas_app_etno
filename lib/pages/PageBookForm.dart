import 'dart:ffi';

import 'package:etno_app/main.dart';
import 'package:etno_app/models/Event.dart';
import 'package:etno_app/models/UserSubscription.dart';
import 'package:etno_app/provider/locale_provider.dart';
import 'package:etno_app/store/section.dart';
import 'package:etno_app/widgets/CardFormScreen.dart';
import 'package:etno_app/widgets/appbar_navigation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../l10n/l10n.dart';

class PageBookForm extends StatefulWidget {
  const PageBookForm({super.key, required this.event});
  final Event event;
  @override
  State<StatefulWidget> createState() {
    return PageState();
  }
}
class PageState extends State<PageBookForm>{
  final Section section = Section();
  String name = '';
  String mail = '';
  String phone = '';
  double reservePrice = 0.0;

  @override
  void initState() {
    super.initState();
  }

  PageBookForm get props => super.widget;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(AppLocalizations.of(context)!.subscribe, Icons.language, () => null),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                        'assets/app.png',
                        height: 120.0,
                        width: 120.0
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
                          border: OutlineInputBorder()
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      onChanged: (value) => setState(() {
                        mail = value;
                      }),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.mail),
                          labelText: AppLocalizations.of(context)!.form_mail,
                          border: OutlineInputBorder()
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      onChanged: (value) => setState(() {
                        phone = value;
                      }),
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          labelText: AppLocalizations.of(context)!.form_phone,
                          border: OutlineInputBorder()
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      initialValue: props.event.reservePrice.toString(),
                      enabled: false,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.monetization_on),
                          labelText: AppLocalizations.of(context)!.form_wallet,
                          border: OutlineInputBorder()
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(onPressed: (){
                      if(name == '' || mail == '' || phone == ''){
                        Fluttertoast.showToast(
                            msg: AppLocalizations.of(context)!.no_fields_empty,
                            toastLength: Toast.LENGTH_SHORT,
                            fontSize: 12,
                            textColor: Colors.white,
                            backgroundColor: Colors.red
                        );
                      }else{
                        Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => MaterialAppCardForm(event: props.event, name: name, mail: mail, phone: phone, reservePrice: reservePrice), reverseTransitionDuration: Duration.zero, transitionDuration: Duration.zero));
                      }
                    }, style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red)), child: Text(AppLocalizations.of(context)!.subscribe, style: const TextStyle(color: Colors.white))),
                    ElevatedButton(onPressed: () => Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => const Home())), style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red)), child: Text(AppLocalizations.of(context)!.cancel, style: const TextStyle(color: Colors.white)))
                  ],
                )
            )
        )
    );
  }
}
class MaterialAppBookForm extends StatelessWidget {
  const MaterialAppBookForm({super.key, required this.event});
  final Event event;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => LocaleProvider(),
    builder: (context, child){
      final provider = Provider.of<LocaleProvider>(context);
      return MaterialApp(
        theme: ThemeData(useMaterial3: true),
        locale: provider.locale,
        supportedLocales: L10n.all,
        title: 'Book Form',
          home: PageBookForm(event: event),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ]
      );
    },
  );
}
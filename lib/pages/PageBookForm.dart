import 'dart:ffi';

import 'package:etno_app/models/Event.dart';
import 'package:etno_app/widgets/CardFormScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageBookForm extends StatefulWidget {
  const PageBookForm({super.key, required this.event});
  final Event event;
  @override
  State<StatefulWidget> createState() {
    return PageState();
  }
}
class PageState extends State<PageBookForm>{

  double reservePrice = 0.0;

  @override
  void initState() {
    super.initState();
  }

  PageBookForm get props => super.widget;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Nombre',
                    border: OutlineInputBorder()
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.mail),
                    labelText: 'Correo',
                    border: OutlineInputBorder()
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    labelText: 'Teléfono',
                      border: OutlineInputBorder()
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  onChanged: (value) => setState(() {
                    reservePrice = double.parse(value);
                  }),
                   keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.monetization_on),
                    labelText: 'Precio de Reserva',
                    border: OutlineInputBorder()
                  ),
                ),
                const SizedBox(height: 20.0),
                    ElevatedButton(onPressed: () => Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => CardFormScreen(reservePrice: reservePrice), reverseTransitionDuration: Duration.zero, transitionDuration: Duration.zero)), style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red)), child: const Text('Subscribirse')),
                    ElevatedButton(onPressed: () => Navigator.pop(context, -1), style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red)), child: const Text('Cancelar'))
              ],
            )
          )
      )
    );
  }
}
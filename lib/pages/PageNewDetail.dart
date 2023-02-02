import 'package:flutter/material.dart';

class PageNewDetail extends StatefulWidget {
  const PageNewDetail({super.key});

  @override
  State<StatefulWidget> createState() {
    return NewDetails();
  }
}

class NewDetails extends State<PageNewDetail> {
  @override
  Widget build(BuildContext context) {
      return  Scaffold(
        body: SafeArea(
          child: ListView(
            children: [
              Container(
                height: 250,
                decoration: const BoxDecoration(
                  image: DecorationImage(image: NetworkImage('http://192.168.137.1:8080/images/sponsors/ecomputer.jpg'), fit: BoxFit.fill)
                ),
                child: Container(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  alignment: Alignment.bottomLeft,
                  child: const Text('Negocios', style: TextStyle(color: Colors.white, backgroundColor: Colors.red)),
                )
              ),
              Text('asdfasdf')
            ],
          )
          /*
              child: ListView(
                children: [
                  Container(
                    height: 300,
                    decoration: const BoxDecoration(
                      image: DecorationImage(image: NetworkImage('http://192.168.137.1:8080/images/sponsors/ecomputer.jpg'), fit: BoxFit.fill)
                    ),
                    ),
                  Container(

                    color: Colors.yellow,

                  )

                ],
              ),
          */
            ),
        );
  }
}
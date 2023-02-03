import 'package:flutter/material.dart';

import '../models/New.dart';

class PageNewDetail extends StatelessWidget {
  const PageNewDetail({super.key, required this.new_});

  final New new_;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
            children: [
              Container(
                  height: 250,
                  decoration: const BoxDecoration(
                      image: DecorationImage(image: NetworkImage('http://192.168.137.1:8080/images/sponsors/ecomputer.jpg'), fit: BoxFit.fill)
                  ),
                  child: Container(
                      padding: const EdgeInsets.only(),
                      alignment: Alignment.bottomLeft,
                      child:  Text(new_.category!, style: const TextStyle(color: Colors.white, backgroundColor: Colors.amber, height: 1.5))
                  )
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(20.0),
                  child:  Text(new_.publicationDate!, style: const TextStyle(color: Colors.grey))
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),
                  child:  Text(new_.title!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0))
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 25.0),
                child: Text(new_.description!,
                    style: const TextStyle(color: Colors.grey, fontSize: 15.0))
              )
            ],
          )
      ),
    );
  }
}
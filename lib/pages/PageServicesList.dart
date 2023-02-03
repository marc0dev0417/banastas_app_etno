import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
  final Section section = Section();

  PageServicesList get props => super.widget;

  @override
  void initState() {
    super.initState();
    section.getAllServiceByLocalityAndCategory(props.locality, props.category);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Observer(builder: (BuildContext context) {
            return servicesList(section);
          })
        )
      )
    );
  }
}

Widget servicesList(Section section){
  return ListView(
    children:
      section.getListServices.map((e) =>
          InkWell(
            child: Container(
              child: Card(
                  child: Row(
                    children: [
                      renderImageServiceList(e),
                      Text(e.owner!),
                      Text(e.number!)
                    ],
                  ),
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
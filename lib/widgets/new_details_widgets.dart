import 'package:flutter/material.dart';


Widget imageNewDetails(){
  return Image.network('http://192.168.137.1:8080/images/sponsors/ecomputer.jpg');
}

/*
Widget renderImage(Section section, int index){
  if (section.getListEvent[index].imageUrl == null){
    return Image.asset('assets/Loading_icon.gif', height: 200);
  }else{
    return Image.network(section.getListEvent[index].imageUrl!, fit: BoxFit.fill, height: 200, width: 300);
  }
}
 */
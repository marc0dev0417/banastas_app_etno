import 'package:flutter/material.dart';

PreferredSizeWidget appBarCustom(
    String title,
    IconData iconData,
    Function() action
    ){
  return AppBar(
    backgroundColor: Colors.red,
    automaticallyImplyLeading: false,
    title: Text(title, style: const TextStyle(color: Colors.white)),
    actions: [
      Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: action,
            child: Icon(
              iconData,
              size: 26.0
            )
          )
      )
    ]
  );
}
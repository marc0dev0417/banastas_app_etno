import 'package:flutter/cupertino.dart';

class WidgetButton {
  String? sectionName;

  WidgetButton({ this.sectionName });

  WidgetButton.fromJson(Map<String, dynamic> json) {
    sectionName = json['sectionName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sectionName'] = this.sectionName;
    return data;
  }
}
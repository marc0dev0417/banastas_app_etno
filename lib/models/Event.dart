import 'dart:ffi';

import 'package:etno_app/models/Image.dart';

class Event {
  String? idEvent;
  String? username;
  String? title;
  String? address;
  String? description;
  String? organization;
  double? reservePrice;
  int? seats;
  int? capacity;
  String? link;
  String? imageUrl;
  String? startDate;
  String? endDate;
  String? publicationDate;
  String? time;
  String? lat;
  String? long;
  List<ImageMedia>? images;

  Event(this.idEvent,
      this.username,
      this.title,
      this.address,
      this.description,
      this.organization,
      this.reservePrice,
      this.seats,
      this.capacity,
      this.link,
      this.imageUrl,
      this.startDate,
      this.endDate,
      this.publicationDate,
      this.time,
      this.lat,
      this.long,
      this.images,);

  Event.empty();

  Event.fromJson(Map<String, dynamic> json) {
    idEvent = json['idEvent'];
    username = json['username'];
    title = json['title'];
    address = json['address'];
    description = json['description'];
    organization = json['organization'];
    reservePrice = json['reservePrice'];
    seats = json['seats'];
    capacity = json['capacity'];
    link = json['link'];
    imageUrl = json['imageUrl'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    publicationDate = json['publicationDate'];
    time = json['time'];
    lat = json['lat'];
    long = json['long'];
    if (json['images'] != null) {
      images = <ImageMedia>[];
      json['images'].forEach((v) {
        images!.add(ImageMedia.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idEvent'] = idEvent;
    data['username'] = username;
    data['title'] = title;
    data['address'] = address;
    data['description'] = description;
    data['organization'] = organization;
    data['reservePrice'] = reservePrice;
    data['seats'] = seats;
    data['capacity'] = capacity;
    data['link'] = link;
    data['imageUrl'] = imageUrl;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['publicationDate'] = publicationDate;
    data['time'] = time;
    data['lat'] = lat;
    data['long'] = long;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
import 'Hall.dart';

class Place {
  String? idPlace;
  String? username;
  String? name;
  double? latitude;
  double? longitude;
  List<Hall>? halls;

  Place(
      this.idPlace,
        this.username,
        this.name,
        this.latitude,
        this.longitude,
        this.halls
      );
  Place.fromJson(Map<String, dynamic> json) {
    idPlace = json['idPlace'];
    username = json['username'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    if (json['halls'] != null) {
      halls = <Hall>[];
      json['halls'].forEach((v) {
        halls?.add(Hall.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idPlace'] = idPlace;
    data['username'] = username;
    data['name'] = name;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    if (halls != null) {
      data['halls'] = halls?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
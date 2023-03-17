import 'Place.dart';
import 'ReserveSchedule.dart';

class ReserveUser {
  String? idReserveUser;
  String? fcmToken;
  String? data;
  Place? place;
  bool? isReserved;
  String? description;
  String? reservePhone;
  double? latitude;
  double? longitude;
  String? date;
  List<ReserveSchedule>? reserveSchedules;

  ReserveUser(this.fcmToken, this.data, this.place, this.isReserved, this.description, this.reservePhone, this.latitude, this.longitude, this.date, this.reserveSchedules);

  ReserveUser.fromJson(Map<String, dynamic> json) {
    idReserveUser = json['idReserveUser'];
    fcmToken = json['fcmToken'];
    data = json['data'];
    place = json['place'] != null ? Place.fromJson(json['place']) : null;
    isReserved = json['isReserved'];
    description = json['description'];
    reservePhone = json['reservePhone'];
    latitude = json['latitude'];
    longitude = json["longitude"];
    date = json['date'];
    if (json['reserveSchedules'] != null) {
      reserveSchedules = <ReserveSchedule> [];
      json['reserveSchedules'].forEach((v){
        reserveSchedules?.add(ReserveSchedule.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{ };
        data['idReserveUser'] = idReserveUser;
        data['fcmToken'] = fcmToken;
        data['data'] = this.data;
        if (place != null) {
          data['place'] = place?.toJson();
        }
        data['isReserved'] = isReserved;
        data['description'] = description;
        data['reservePhone'] = reservePhone;
        data['latitude'] = latitude;
        data['longitude'] = longitude;
        data['date'] = date;
        if (reserveSchedules != null) {
          data['reserveSchedules'] = reserveSchedules?.map((e) => e.toJson()).toList();
        }
    return data;
  }
}
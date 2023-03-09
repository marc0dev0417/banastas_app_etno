import 'Place.dart';
import 'ReserveSchedule.dart';
import 'ReserveUser.dart';

class Reserve {
  String? idReserve;
  String? username;
  String? name;
  String? description;
  String? hall;
  String? email;
  String? phone;
  bool? isPrivate;
  Place? place;
  String? date;
  List<ReserveSchedule>? reserveSchedules;
  List<ReserveUser>? reserveUsers;
  bool? isReserved;

  Reserve(this.idReserve, this.username, this.name, this.description, this.hall, this.email, this.phone, this.isPrivate, this.place, this.date);
  Reserve.prop(this.place, this.isReserved, this.description, this.phone, this.date, this.reserveSchedules);

  Reserve.fromJson(Map<String, dynamic> json) {
    idReserve = json['idReserve'];
    username = json['username'];
    name = json['name'];
    description = json['description'];
    email = json['email'];
    phone = json['phone'];
    isPrivate = json['isPrivate'];
    place = json['place'] != null ? Place.fromJson(json['place']) : null;
    hall = json['hall'];
    date = json['date'];
    if (json['reserveSchedules'] != null) {
      reserveSchedules = <ReserveSchedule> [];
      json['reserveSchedules'].forEach((v){
        reserveSchedules?.add(ReserveSchedule.fromJson(v));
      });
    }
    if (json['reserveUsers'] != null) {
      reserveUsers = <ReserveUser>[];
      json['reserveUsers'].forEach((v) {
        reserveUsers?.add(ReserveUser.fromJson(v));
      });
    }
    isReserved = json['isReserved'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idReserve'] = idReserve;
    data['username'] = username;
    data['name'] = name;
    data['description'] = description;
    data['email'] = email;
    data['phone'] = phone;
    data['isPrivate'] = isPrivate;
    if (place != null) {
      data['place'] = place?.toJson();
    }
    data['hall'] = hall;
    data['date'] = date;
    if (reserveSchedules != null) {
      data['reserveSchedules'] = reserveSchedules?.map((e) => e.toJson()).toList();
    }
    if (reserveUsers != null) {
      data['reserveUsers'] = reserveUsers?.map((v) => v.toJson()).toList();
    }
    data['isReserved'] = isReserved;
    return data;
  }
}
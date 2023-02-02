class Pharmacy {
  String? idPharmacy;
  String? username;
  String? type;
  String? name;
  String? link;
  String? imageUrl;
  String? phone;
  String? schedule;
  String? description;
  double? latitude;
  double? longitude;

  Pharmacy(this.idPharmacy,
      this.username,
      this.type,
      this.name,
      this.link,
      this.imageUrl,
      this.phone,
      this.schedule,
      this.description,
      this.latitude,
      this.longitude);

  Pharmacy.fromJson(Map<String, dynamic> json) {
    idPharmacy = json['idPharmacy'];
    username = json['username'];
    type = json['type'];
    name = json['name'];
    link = json['link'];
    imageUrl = json['imageUrl'];
    phone = json['phone'];
    schedule = json['schedule'];
    description = json['description'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idPharmacy'] = idPharmacy;
    data['username'] = username;
    data['type'] = type;
    data['name'] = name;
    data['link'] = link;
    data['imageUrl'] = imageUrl;
    data['phone'] = phone;
    data['schedule'] = schedule;
    data['description'] = description;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}

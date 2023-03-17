class Tourism {
  String? idTourism;
  String? type;
  String? username;
  String? title;
  String? description;
  String? imageUrl;
  double? longitude;
  double? latitude;

  Tourism(this.idTourism,
      this.type,
      this.username,
      this.title,
      this.description,
      this.imageUrl,
      this.longitude,
      this.latitude);

  Tourism.fromJson(Map<String, dynamic> json) {
    idTourism = json['idTourism'];
    type = json['type'];
    username = json['username'];
    title = json['title'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{ };
    data['idTourism'] = idTourism;
    data['type'] = type;
    data['username'] = username;
    data['title'] = title;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    return data;
  }
}
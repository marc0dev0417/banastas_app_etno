class Sponsor {
  String? idSponsor;
  String? username;
  String? title;
  String? description;
  String? phone;
  String? urlImage;

  Sponsor(this.idSponsor, this.username, this.title, this.description, this.phone, this.urlImage);

  Sponsor.fromJson(Map<String, dynamic> json) {
    idSponsor = json['idSponsor'];
    username = json['username'];
    title = json['title'];
    description = json['description'];
    phone = json['phone'];
    urlImage = json['urlImage'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idSponsor'] = idSponsor;
    data['username'] = username;
    data['title'] = title;
    data['description'] = description;
    data['phone'] = phone;
    data['urlImage'] = urlImage;
    return data;
  }
}
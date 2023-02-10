class FCMToken {
  String? idFMC;
  String? locality;
  String? token;

  FCMToken(this.locality, this.token);

  FCMToken.fromJson(Map<String, dynamic> json) {
    idFMC = json['idFMC'];
    locality = json['locality'];
    token = json['token'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idFMC'] = idFMC;
    data['locality'] = locality;
    data['token'] = token;
    return data;
  }
}
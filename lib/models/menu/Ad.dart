class Ad {
  String? idAd;
  String? username;
  String? title;
  String? description;
  String? imageUrl;
  String? webUrl;

  Ad(this.idAd, this.username, this.title, this.description, this.imageUrl, this.webUrl);

  Ad.fromJson(Map<String, dynamic> json) {
    idAd = json['idAd'];
    username = json['username'];
    title = json['title'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    webUrl = json['webUrl'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{ };
    data['idAd'] = idAd;
    data['username'] = username;
    data['title'] = title;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    data['webUrl'] = webUrl;
    return data;
  }
}
class Bandos {
  String? idBando;
  String? username;
  String? title;
  String? description;
  String? issuedDate;
  String? imageUrl;

  Bandos(this.idBando, this.username, this.title, this.description, this.issuedDate, this.imageUrl);

  Bandos.fromJson(Map<String, dynamic> json) {
    idBando = json['idBando'];
    username = json['username'];
    title = json['title'];
    description = json['description'];
    issuedDate = json['issuedDate'];
    imageUrl = json['imageUrl'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic> {  };
    data['idBando'] = idBando;
    data['username'] = username;
    data['title'] = title;
    data['description'] = description;
    data['issuedDate'] = issuedDate;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
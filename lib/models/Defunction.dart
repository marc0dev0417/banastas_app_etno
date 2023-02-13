class Defunction {
  String? idDeath;
  String? username;
  String? name;
  String? deathDate;
  String? description;
  String? imageUrl;

  Defunction(this.idDeath, this.username, this.name, this.deathDate, this.description, this.imageUrl);

  Defunction.fromJson(Map<String, dynamic> json) {
    idDeath = json['idDeath'];
    username = json['username'];
    name = json['name'];
    deathDate = json['deathDate'];
    description = json['description'];
    imageUrl = json['imageUrl'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idDeath'] = idDeath;
    data['username'] = username;
    data['name'] = name;
    data['deathDate'] = deathDate;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
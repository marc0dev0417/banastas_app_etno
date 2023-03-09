class Hall {
  String? idHall;
  String? username;
  String? name;

  Hall(this.idHall, this.username, this.name);

  Hall.fromJson(Map<String, dynamic> json) {
    idHall = json['idHall'];
    username = json['username'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idHall'] = idHall;
    data['username'] = username;
    data['name'] = name;
    return data;
  }
}
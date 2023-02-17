class Service {
  String? idService;
  String? username;
  String? category;
  String? owner;
  String? number;
  String? schedule;
  String? imageUrl;

  Service(
      this.idService,
      this.username,
      this.category,
      this.owner,
      this.number,
      this.schedule,
      this.imageUrl
      );
  Service.fromJson(Map<String, dynamic> json) {
    idService = json['idService'];
    username = json['username'];
    category = json['category'];
    owner = json['owner'];
    number = json['number'];
    schedule = json['schedule'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idService'] = idService;
    data['username'] = username;
    data['category'] = category;
    data['owner'] = owner;
    data['number'] = number;
    data['schedule'] = schedule;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
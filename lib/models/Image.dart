class Image {
  String? idImage;
  String? locality;
  String? section;
  String? name;
  String? category;
  String? link;

  Image(this.idImage, this.locality, this.section, this.name, this.category, this.link);

  Image.fromJson(Map<String, dynamic> json) {
    idImage = json['idImage'];
    locality = json['locality'];
    section = json['section'];
    name = json['name'];
    category = json['category'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idImage'] = idImage;
    data['locality'] = locality;
    data['section'] = section;
    data['name'] = name;
    data['category'] = category;
    data['link'] = link;
    return data;
  }
}
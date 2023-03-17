class CustomLink {
  String? idCustomLink;
  String? username;
  String? name;
  String? webUrl;
  String? iconName;

  CustomLink(this.idCustomLink, this.username, this.name, this.webUrl, this.iconName);

  CustomLink.fromJson(Map<String, dynamic> json){
    idCustomLink = json['idCustomLink'];
    username = json['username'];
    name = json['name'];
    webUrl = json['webUrl'];
    iconName = json['iconName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic> { };
    data['idCustomLink'] = idCustomLink;
    data['username'] = username;
    data['name'] = name;
    data['webUrl'] = webUrl;
    data['iconName'] = iconName;
    return data;
  }
}
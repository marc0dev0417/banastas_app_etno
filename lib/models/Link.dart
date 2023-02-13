class Link {
  String? idLink;
  String? username;
  String? title;
  String? url;

  Link(this.idLink, this.username, this.title, this.url);

  Link.fromJson(Map<String, dynamic> json) {
    idLink = json['idLink'];
    username = json['username'];
    title = json['title'];
    url = json['url'];
  }
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idLink'] = idLink;
    data['username'] = username;
    data['title'] = title;
    data['url'] = url;
    return data;
  }
}
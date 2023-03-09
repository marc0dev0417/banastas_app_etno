import 'dart:convert';

class New{
   String? idNew;
   String? username;
   String? category;
   String? title;
   String? publicationDate;
   String? description;
   String? imageUrl;

   New(this.idNew, this.username, this.category, this.title, this.publicationDate, this.description, this.imageUrl);

   New.empty();

  New.fromJson(Map<String, dynamic> json) {
    idNew = json['idNew'];
    username = json['username'];
    category = json['category'];
    title = json['title'];
    publicationDate = json['publicationDate'];
    description = json['description'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idNew'] = idNew;
    data['username'] = username;
    data['category'] = category;
    data['title'] = title;
    data['publicationDate'] = publicationDate;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
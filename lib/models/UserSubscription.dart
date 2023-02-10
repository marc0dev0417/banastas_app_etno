class UserSubscription {
  String? idSubscriptionUser;
  String? fcmToken;
  String? title;
  int? seats;
  String? name;
  String? mail;
  String? phone;
  double? wallet;
  bool? isSubscribe;

  UserSubscription(
      this.idSubscriptionUser,
      this.fcmToken,
      this.title,
      this.seats,
      this.name,
      this.mail,
      this.phone,
      this.wallet,
      this.isSubscribe
      );

  UserSubscription.fromJson(Map<String, dynamic> json) {
    idSubscriptionUser = json['idSubscriptionUser'];
    fcmToken = json['fcmToken'];
    title = json['title'];
    seats = json['seats'];
    name = json['name'];
    mail = json['mail'];
    phone = json['phone'];
    wallet = json['wallet'];
    isSubscribe = json['isSubscribe'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idSubscriptionUser'] = idSubscriptionUser;
    data['fcmToken'] = fcmToken;
    data['title'] = title;
    data['seats'] = seats;
    data['name'] = name;
    data['mail'] = mail;
    data['phone'] = phone;
    data['wallet'] = wallet;
    data['isSubscribe'] = isSubscribe;
    return data;
  }
}
class MailDetails {
  String? address;
  String? message;
  String? subject;
  String? attachment;

  MailDetails(this.address, this.message, this.subject, this.attachment);

  MailDetails.toJson(Map<String, dynamic> json) {
    address = json['address'];
    message = json['message'];
    subject = json['subject'];
    attachment = json['attachment'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{  };
    data['address'] = address;
    data['message'] = message;
    data['subject'] = subject;
    data['attachment'] = attachment;
    return data;
  }
}
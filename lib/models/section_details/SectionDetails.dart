class SectionDetails {
  int? eventQuantity;
  int? tourismQuantity;
  int? pharmacyQuantity;
  int? serviceQuantity;
  int? newsQuantity;
  int? bandoQuantity;
  int? adQuantity;
  int? galleryQuantity;
  int? deathQuantity;
  int? linkQuantity;
  int? sponsorQuantity;
  int? incidentQuantity;
  int? reserveQuantity;

  SectionDetails(this.eventQuantity, this.tourismQuantity, this.pharmacyQuantity, this.serviceQuantity, this.newsQuantity, this.bandoQuantity, this.adQuantity, this.galleryQuantity, this.deathQuantity, this.linkQuantity, this.sponsorQuantity, this.incidentQuantity, this.reserveQuantity);
  SectionDetails.empty();

  SectionDetails.fromJson(Map<String, dynamic> json) {
    eventQuantity = json['eventQuantity'];
    tourismQuantity = json['tourismQuantity'];
    pharmacyQuantity = json['pharmacyQuantity'];
    serviceQuantity = json['serviceQuantity'];
    newsQuantity = json['newsQuantity'];
    bandoQuantity = json['bandoQuantity'];
    adQuantity = json['adQuantity'];
    galleryQuantity = json['galleryQuantity'];
    deathQuantity = json['deathQuantity'];
    linkQuantity = json['linkQuantity'];
    sponsorQuantity = json['sponsorQuantity'];
    incidentQuantity = json['incidentQuantity'];
    reserveQuantity = json['reserveQuantity'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic> { };
    data['eventQuantity'] = eventQuantity;
    data['tourismQuantity'] = tourismQuantity;
    data['pharmacyQuantity'] = pharmacyQuantity;
    data['serviceQuantity'] = serviceQuantity;
    data['newsQuantity'] = newsQuantity;
    data['bandoQuantity'] = bandoQuantity;
    data['adQuantity'] = adQuantity;
    data['galleryQuantity'] = galleryQuantity;
    data['deathQuantity'] = deathQuantity;
    data['linkQuantity'] = linkQuantity;
    data['sponsorQuantity'] = sponsorQuantity;
    data['incidentQuantity'] = incidentQuantity;
    data['reserveQuantity'] = reserveQuantity;
    return data;
  }
}
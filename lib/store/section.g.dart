// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Section on SectionBase, Store {
  Computed<Weather>? _$getLocalityWeatherComputed;

  @override
  Weather get getLocalityWeather => (_$getLocalityWeatherComputed ??=
          Computed<Weather>(() => super.getLocalityWeather,
              name: 'SectionBase.getLocalityWeather'))
      .value;
  Computed<List<New>>? _$getListComputed;

  @override
  List<New> get getList => (_$getListComputed ??=
          Computed<List<New>>(() => super.getList, name: 'SectionBase.getList'))
      .value;
  Computed<List<New>>? _$getListNewCategoryComputed;

  @override
  List<New> get getListNewCategory => (_$getListNewCategoryComputed ??=
          Computed<List<New>>(() => super.getListNewCategory,
              name: 'SectionBase.getListNewCategory'))
      .value;
  Computed<List<Event>>? _$getListEventComputed;

  @override
  List<Event> get getListEvent => (_$getListEventComputed ??=
          Computed<List<Event>>(() => super.getListEvent,
              name: 'SectionBase.getListEvent'))
      .value;
  Computed<New>? _$getNewComputed;

  @override
  New get getNew => (_$getNewComputed ??=
          Computed<New>(() => super.getNew, name: 'SectionBase.getNew'))
      .value;
  Computed<List<Pharmacy>>? _$getListPharmacyComputed;

  @override
  List<Pharmacy> get getListPharmacy => (_$getListPharmacyComputed ??=
          Computed<List<Pharmacy>>(() => super.getListPharmacy,
              name: 'SectionBase.getListPharmacy'))
      .value;
  Computed<List<Tourism>>? _$getListTourismComputed;

  @override
  List<Tourism> get getListTourism => (_$getListTourismComputed ??=
          Computed<List<Tourism>>(() => super.getListTourism,
              name: 'SectionBase.getListTourism'))
      .value;
  Computed<List<Service>>? _$getListServicesComputed;

  @override
  List<Service> get getListServices => (_$getListServicesComputed ??=
          Computed<List<Service>>(() => super.getListServices,
              name: 'SectionBase.getListServices'))
      .value;
  Computed<List<Menu>>? _$getSectionsComputed;

  @override
  List<Menu> get getSections =>
      (_$getSectionsComputed ??= Computed<List<Menu>>(() => super.getSections,
              name: 'SectionBase.getSections'))
          .value;
  Computed<List<Defunction>>? _$getDefunctionsComputed;

  @override
  List<Defunction> get getDefunctions => (_$getDefunctionsComputed ??=
          Computed<List<Defunction>>(() => super.getDefunctions,
              name: 'SectionBase.getDefunctions'))
      .value;
  Computed<List<Link>>? _$getLinksComputed;

  @override
  List<Link> get getLinks =>
      (_$getLinksComputed ??= Computed<List<Link>>(() => super.getLinks,
              name: 'SectionBase.getLinks'))
          .value;
  Computed<List<Sponsor>>? _$getSponsorsComputed;

  @override
  List<Sponsor> get getSponsors => (_$getSponsorsComputed ??=
          Computed<List<Sponsor>>(() => super.getSponsors,
              name: 'SectionBase.getSponsors'))
      .value;
  Computed<List<Ad>>? _$getAdsComputed;

  @override
  List<Ad> get getAds => (_$getAdsComputed ??=
          Computed<List<Ad>>(() => super.getAds, name: 'SectionBase.getAds'))
      .value;
  Computed<List<Bandos>>? _$getBandosComputed;

  @override
  List<Bandos> get getBandos =>
      (_$getBandosComputed ??= Computed<List<Bandos>>(() => super.getBandos,
              name: 'SectionBase.getBandos'))
          .value;
  Computed<List<ImageMedia>>? _$getImagesComputed;

  @override
  List<ImageMedia> get getImages =>
      (_$getImagesComputed ??= Computed<List<ImageMedia>>(() => super.getImages,
              name: 'SectionBase.getImages'))
          .value;
  Computed<List<Incident>>? _$getIncidentsComputed;

  @override
  List<Incident> get getIncidents => (_$getIncidentsComputed ??=
          Computed<List<Incident>>(() => super.getIncidents,
              name: 'SectionBase.getIncidents'))
      .value;
  Computed<Message>? _$getMessageComputed;

  @override
  Message get getMessage =>
      (_$getMessageComputed ??= Computed<Message>(() => super.getMessage,
              name: 'SectionBase.getMessage'))
          .value;
  Computed<Event>? _$getEventComputed;

  @override
  Event get getEvent => (_$getEventComputed ??=
          Computed<Event>(() => super.getEvent, name: 'SectionBase.getEvent'))
      .value;
  Computed<List<Reserve>>? _$getReservesComputed;

  @override
  List<Reserve> get getReserves => (_$getReservesComputed ??=
          Computed<List<Reserve>>(() => super.getReserves,
              name: 'SectionBase.getReserves'))
      .value;
  Computed<List<ReserveUser>>? _$getReserveUserComputed;

  @override
  List<ReserveUser> get getReserveUser => (_$getReserveUserComputed ??=
          Computed<List<ReserveUser>>(() => super.getReserveUser,
              name: 'SectionBase.getReserveUser'))
      .value;
  Computed<bool>? _$getIsSubscribeComputed;

  @override
  bool get getIsSubscribe =>
      (_$getIsSubscribeComputed ??= Computed<bool>(() => super.getIsSubscribe,
              name: 'SectionBase.getIsSubscribe'))
          .value;

  late final _$weatherAtom =
      Atom(name: 'SectionBase.weather', context: context);

  @override
  Weather get weather {
    _$weatherAtom.reportRead();
    return super.weather;
  }

  @override
  set weather(Weather value) {
    _$weatherAtom.reportWrite(value, super.weather, () {
      super.weather = value;
    });
  }

  late final _$isSubscribeAtom =
      Atom(name: 'SectionBase.isSubscribe', context: context);

  @override
  bool get isSubscribe {
    _$isSubscribeAtom.reportRead();
    return super.isSubscribe;
  }

  @override
  set isSubscribe(bool value) {
    _$isSubscribeAtom.reportWrite(value, super.isSubscribe, () {
      super.isSubscribe = value;
    });
  }

  late final _$newListAtom =
      Atom(name: 'SectionBase.newList', context: context);

  @override
  List<New> get newList {
    _$newListAtom.reportRead();
    return super.newList;
  }

  @override
  set newList(List<New> value) {
    _$newListAtom.reportWrite(value, super.newList, () {
      super.newList = value;
    });
  }

  late final _$newListEventCategoryAtom =
      Atom(name: 'SectionBase.newListEventCategory', context: context);

  @override
  List<New> get newListEventCategory {
    _$newListEventCategoryAtom.reportRead();
    return super.newListEventCategory;
  }

  @override
  set newListEventCategory(List<New> value) {
    _$newListEventCategoryAtom.reportWrite(value, super.newListEventCategory,
        () {
      super.newListEventCategory = value;
    });
  }

  late final _$sponsorListAtom =
      Atom(name: 'SectionBase.sponsorList', context: context);

  @override
  List<Sponsor> get sponsorList {
    _$sponsorListAtom.reportRead();
    return super.sponsorList;
  }

  @override
  set sponsorList(List<Sponsor> value) {
    _$sponsorListAtom.reportWrite(value, super.sponsorList, () {
      super.sponsorList = value;
    });
  }

  late final _$defunctionListAtom =
      Atom(name: 'SectionBase.defunctionList', context: context);

  @override
  List<Defunction> get defunctionList {
    _$defunctionListAtom.reportRead();
    return super.defunctionList;
  }

  @override
  set defunctionList(List<Defunction> value) {
    _$defunctionListAtom.reportWrite(value, super.defunctionList, () {
      super.defunctionList = value;
    });
  }

  late final _$linkListAtom =
      Atom(name: 'SectionBase.linkList', context: context);

  @override
  List<Link> get linkList {
    _$linkListAtom.reportRead();
    return super.linkList;
  }

  @override
  set linkList(List<Link> value) {
    _$linkListAtom.reportWrite(value, super.linkList, () {
      super.linkList = value;
    });
  }

  late final _$bandoListAtom =
      Atom(name: 'SectionBase.bandoList', context: context);

  @override
  List<Bandos> get bandoList {
    _$bandoListAtom.reportRead();
    return super.bandoList;
  }

  @override
  set bandoList(List<Bandos> value) {
    _$bandoListAtom.reportWrite(value, super.bandoList, () {
      super.bandoList = value;
    });
  }

  late final _$new_Atom = Atom(name: 'SectionBase.new_', context: context);

  @override
  New get new_ {
    _$new_Atom.reportRead();
    return super.new_;
  }

  @override
  set new_(New value) {
    _$new_Atom.reportWrite(value, super.new_, () {
      super.new_ = value;
    });
  }

  late final _$eventListAtom =
      Atom(name: 'SectionBase.eventList', context: context);

  @override
  List<Event> get eventList {
    _$eventListAtom.reportRead();
    return super.eventList;
  }

  @override
  set eventList(List<Event> value) {
    _$eventListAtom.reportWrite(value, super.eventList, () {
      super.eventList = value;
    });
  }

  late final _$eventAtom = Atom(name: 'SectionBase.event', context: context);

  @override
  Event get event {
    _$eventAtom.reportRead();
    return super.event;
  }

  @override
  set event(Event value) {
    _$eventAtom.reportWrite(value, super.event, () {
      super.event = value;
    });
  }

  late final _$pharmaciesListAtom =
      Atom(name: 'SectionBase.pharmaciesList', context: context);

  @override
  List<Pharmacy> get pharmaciesList {
    _$pharmaciesListAtom.reportRead();
    return super.pharmaciesList;
  }

  @override
  set pharmaciesList(List<Pharmacy> value) {
    _$pharmaciesListAtom.reportWrite(value, super.pharmaciesList, () {
      super.pharmaciesList = value;
    });
  }

  late final _$tourismListAtom =
      Atom(name: 'SectionBase.tourismList', context: context);

  @override
  List<Tourism> get tourismList {
    _$tourismListAtom.reportRead();
    return super.tourismList;
  }

  @override
  set tourismList(List<Tourism> value) {
    _$tourismListAtom.reportWrite(value, super.tourismList, () {
      super.tourismList = value;
    });
  }

  late final _$servicesListAtom =
      Atom(name: 'SectionBase.servicesList', context: context);

  @override
  List<Service> get servicesList {
    _$servicesListAtom.reportRead();
    return super.servicesList;
  }

  @override
  set servicesList(List<Service> value) {
    _$servicesListAtom.reportWrite(value, super.servicesList, () {
      super.servicesList = value;
    });
  }

  late final _$adsListAtom =
      Atom(name: 'SectionBase.adsList', context: context);

  @override
  List<Ad> get adsList {
    _$adsListAtom.reportRead();
    return super.adsList;
  }

  @override
  set adsList(List<Ad> value) {
    _$adsListAtom.reportWrite(value, super.adsList, () {
      super.adsList = value;
    });
  }

  late final _$imageListAtom =
      Atom(name: 'SectionBase.imageList', context: context);

  @override
  List<ImageMedia> get imageList {
    _$imageListAtom.reportRead();
    return super.imageList;
  }

  @override
  set imageList(List<ImageMedia> value) {
    _$imageListAtom.reportWrite(value, super.imageList, () {
      super.imageList = value;
    });
  }

  late final _$incidentListAtom =
      Atom(name: 'SectionBase.incidentList', context: context);

  @override
  List<Incident> get incidentList {
    _$incidentListAtom.reportRead();
    return super.incidentList;
  }

  @override
  set incidentList(List<Incident> value) {
    _$incidentListAtom.reportWrite(value, super.incidentList, () {
      super.incidentList = value;
    });
  }

  late final _$reserveListAtom =
      Atom(name: 'SectionBase.reserveList', context: context);

  @override
  List<Reserve> get reserveList {
    _$reserveListAtom.reportRead();
    return super.reserveList;
  }

  @override
  set reserveList(List<Reserve> value) {
    _$reserveListAtom.reportWrite(value, super.reserveList, () {
      super.reserveList = value;
    });
  }

  late final _$reserveUserListAtom =
      Atom(name: 'SectionBase.reserveUserList', context: context);

  @override
  List<ReserveUser> get reserveUserList {
    _$reserveUserListAtom.reportRead();
    return super.reserveUserList;
  }

  @override
  set reserveUserList(List<ReserveUser> value) {
    _$reserveUserListAtom.reportWrite(value, super.reserveUserList, () {
      super.reserveUserList = value;
    });
  }

  late final _$messageAtom =
      Atom(name: 'SectionBase.message', context: context);

  @override
  Message get message {
    _$messageAtom.reportRead();
    return super.message;
  }

  @override
  set message(Message value) {
    _$messageAtom.reportWrite(value, super.message, () {
      super.message = value;
    });
  }

  late final _$sectionListAtom =
      Atom(name: 'SectionBase.sectionList', context: context);

  @override
  List<Menu> get sectionList {
    _$sectionListAtom.reportRead();
    return super.sectionList;
  }

  @override
  set sectionList(List<Menu> value) {
    _$sectionListAtom.reportWrite(value, super.sectionList, () {
      super.sectionList = value;
    });
  }

  late final _$getWeatherAsyncAction =
      AsyncAction('SectionBase.getWeather', context: context);

  @override
  Future<Weather> getWeather(String locality) {
    return _$getWeatherAsyncAction.run(() => super.getWeather(locality));
  }

  late final _$getAllNewByLocalityAsyncAction =
      AsyncAction('SectionBase.getAllNewByLocality', context: context);

  @override
  Future<List<New>> getAllNewByLocality(String locality) {
    return _$getAllNewByLocalityAsyncAction
        .run(() => super.getAllNewByLocality(locality));
  }

  late final _$getNewsListByLocalityAndCategoryAsyncAction = AsyncAction(
      'SectionBase.getNewsListByLocalityAndCategory',
      context: context);

  @override
  Future<List<New>> getNewsListByLocalityAndCategory(
      String locality, String category) {
    return _$getNewsListByLocalityAndCategoryAsyncAction
        .run(() => super.getNewsListByLocalityAndCategory(locality, category));
  }

  late final _$getAllEventsByLocalityAsyncAction =
      AsyncAction('SectionBase.getAllEventsByLocality', context: context);

  @override
  Future<List<Event>> getAllEventsByLocality(String locality) {
    return _$getAllEventsByLocalityAsyncAction
        .run(() => super.getAllEventsByLocality(locality));
  }

  late final _$getAllDefunctionsByLocalityAsyncAction =
      AsyncAction('SectionBase.getAllDefunctionsByLocality', context: context);

  @override
  Future<List<Defunction>> getAllDefunctionsByLocality(String locality) {
    return _$getAllDefunctionsByLocalityAsyncAction
        .run(() => super.getAllDefunctionsByLocality(locality));
  }

  late final _$getSponsorsByLocalityAsyncAction =
      AsyncAction('SectionBase.getSponsorsByLocality', context: context);

  @override
  Future<List<Sponsor>> getSponsorsByLocality(String locality) {
    return _$getSponsorsByLocalityAsyncAction
        .run(() => super.getSponsorsByLocality(locality));
  }

  late final _$getAllLinksByLocalityAsyncAction =
      AsyncAction('SectionBase.getAllLinksByLocality', context: context);

  @override
  Future<List<Link>> getAllLinksByLocality(String locality) {
    return _$getAllLinksByLocalityAsyncAction
        .run(() => super.getAllLinksByLocality(locality));
  }

  late final _$getEventByUsernameAndTitleAsyncAction =
      AsyncAction('SectionBase.getEventByUsernameAndTitle', context: context);

  @override
  Future<Event> getEventByUsernameAndTitle(String username, String title) {
    return _$getEventByUsernameAndTitleAsyncAction
        .run(() => super.getEventByUsernameAndTitle(username, title));
  }

  late final _$saveFcmTokenAsyncAction =
      AsyncAction('SectionBase.saveFcmToken', context: context);

  @override
  Future<FCMToken> saveFcmToken(FCMToken fcmToken) {
    return _$saveFcmTokenAsyncAction.run(() => super.saveFcmToken(fcmToken));
  }

  late final _$getSubscriptionAsyncAction =
      AsyncAction('SectionBase.getSubscription', context: context);

  @override
  Future<bool> getSubscription(String fcmToken, String title) {
    return _$getSubscriptionAsyncAction
        .run(() => super.getSubscription(fcmToken, title));
  }

  late final _$addSubscriptionAsyncAction =
      AsyncAction('SectionBase.addSubscription', context: context);

  @override
  Future<bool> addSubscription(
      String locality, String title, UserSubscription userSubscription) {
    return _$addSubscriptionAsyncAction
        .run(() => super.addSubscription(locality, title, userSubscription));
  }

  late final _$dropSubscriptionAsyncAction =
      AsyncAction('SectionBase.dropSubscription', context: context);

  @override
  Future<bool> dropSubscription(
      String locality, String title, String fcmToken) {
    return _$dropSubscriptionAsyncAction
        .run(() => super.dropSubscription(locality, title, fcmToken));
  }

  late final _$getAllPharmaciesByLocalityAsyncAction =
      AsyncAction('SectionBase.getAllPharmaciesByLocality', context: context);

  @override
  Future<List<Pharmacy>> getAllPharmaciesByLocality(String locality) {
    return _$getAllPharmaciesByLocalityAsyncAction
        .run(() => super.getAllPharmaciesByLocality(locality));
  }

  late final _$getAllTourismByLocalityAsyncAction =
      AsyncAction('SectionBase.getAllTourismByLocality', context: context);

  @override
  Future<List<Tourism>> getAllTourismByLocality(String locality) {
    return _$getAllTourismByLocalityAsyncAction
        .run(() => super.getAllTourismByLocality(locality));
  }

  late final _$getAllServiceByLocalityAndCategoryAsyncAction = AsyncAction(
      'SectionBase.getAllServiceByLocalityAndCategory',
      context: context);

  @override
  Future<List<Service>> getAllServiceByLocalityAndCategory(
      String locality, String category) {
    return _$getAllServiceByLocalityAndCategoryAsyncAction.run(
        () => super.getAllServiceByLocalityAndCategory(locality, category));
  }

  late final _$getAllAdsByLocalityAsyncAction =
      AsyncAction('SectionBase.getAllAdsByLocality', context: context);

  @override
  Future<List<Ad>> getAllAdsByLocality(String locality) {
    return _$getAllAdsByLocalityAsyncAction
        .run(() => super.getAllAdsByLocality(locality));
  }

  late final _$getAllBandosByLocalityAsyncAction =
      AsyncAction('SectionBase.getAllBandosByLocality', context: context);

  @override
  Future<List<Bandos>> getAllBandosByLocality(String locality) {
    return _$getAllBandosByLocalityAsyncAction
        .run(() => super.getAllBandosByLocality(locality));
  }

  late final _$getAllImageMediaByLocalityAsyncAction =
      AsyncAction('SectionBase.getAllImageMediaByLocality', context: context);

  @override
  Future<List<ImageMedia>> getAllImageMediaByLocality(String locality) {
    return _$getAllImageMediaByLocalityAsyncAction
        .run(() => super.getAllImageMediaByLocality(locality));
  }

  late final _$getAllIncidentByLocalityAndFcmTokenAsyncAction = AsyncAction(
      'SectionBase.getAllIncidentByLocalityAndFcmToken',
      context: context);

  @override
  Future<List<Incident>> getAllIncidentByLocalityAndFcmToken(
      String locality, String fcmToken) {
    return _$getAllIncidentByLocalityAndFcmTokenAsyncAction.run(
        () => super.getAllIncidentByLocalityAndFcmToken(locality, fcmToken));
  }

  late final _$sendMailMessageAsyncAction =
      AsyncAction('SectionBase.sendMailMessage', context: context);

  @override
  Future<Message> sendMailMessage(MailDetails mailDetails) {
    return _$sendMailMessageAsyncAction
        .run(() => super.sendMailMessage(mailDetails));
  }

  late final _$addIncidentAsyncAction =
      AsyncAction('SectionBase.addIncident', context: context);

  @override
  Future<dynamic> addIncident(Incident incident) {
    return _$addIncidentAsyncAction.run(() => super.addIncident(incident));
  }

  late final _$getReservesByLocalityAsyncAction =
      AsyncAction('SectionBase.getReservesByLocality', context: context);

  @override
  Future<List<Reserve>> getReservesByLocality(String username) {
    return _$getReservesByLocalityAsyncAction
        .run(() => super.getReservesByLocality(username));
  }

  late final _$getReserveUserByFcmTokenAsyncAction =
      AsyncAction('SectionBase.getReserveUserByFcmToken', context: context);

  @override
  Future<List<ReserveUser>> getReserveUserByFcmToken(String fcmToken) {
    return _$getReserveUserByFcmTokenAsyncAction
        .run(() => super.getReserveUserByFcmToken(fcmToken));
  }

  late final _$sendReserveAsyncAction =
      AsyncAction('SectionBase.sendReserve', context: context);

  @override
  Future<dynamic> sendReserve(
      String username, String reserveName, ReserveUser reserveUser) {
    return _$sendReserveAsyncAction
        .run(() => super.sendReserve(username, reserveName, reserveUser));
  }

  @override
  String toString() {
    return '''
weather: ${weather},
isSubscribe: ${isSubscribe},
newList: ${newList},
newListEventCategory: ${newListEventCategory},
sponsorList: ${sponsorList},
defunctionList: ${defunctionList},
linkList: ${linkList},
bandoList: ${bandoList},
new_: ${new_},
eventList: ${eventList},
event: ${event},
pharmaciesList: ${pharmaciesList},
tourismList: ${tourismList},
servicesList: ${servicesList},
adsList: ${adsList},
imageList: ${imageList},
incidentList: ${incidentList},
reserveList: ${reserveList},
reserveUserList: ${reserveUserList},
message: ${message},
sectionList: ${sectionList},
getLocalityWeather: ${getLocalityWeather},
getList: ${getList},
getListNewCategory: ${getListNewCategory},
getListEvent: ${getListEvent},
getNew: ${getNew},
getListPharmacy: ${getListPharmacy},
getListTourism: ${getListTourism},
getListServices: ${getListServices},
getSections: ${getSections},
getDefunctions: ${getDefunctions},
getLinks: ${getLinks},
getSponsors: ${getSponsors},
getAds: ${getAds},
getBandos: ${getBandos},
getImages: ${getImages},
getIncidents: ${getIncidents},
getMessage: ${getMessage},
getEvent: ${getEvent},
getReserves: ${getReserves},
getReserveUser: ${getReserveUser},
getIsSubscribe: ${getIsSubscribe}
    ''';
  }
}

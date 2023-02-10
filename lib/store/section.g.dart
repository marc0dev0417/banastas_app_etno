// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Section on SectionBase, Store {
  Computed<List<New>>? _$getListComputed;

  @override
  List<New> get getList => (_$getListComputed ??=
          Computed<List<New>>(() => super.getList, name: 'SectionBase.getList'))
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
  Computed<Event>? _$getEventComputed;

  @override
  Event get getEvent => (_$getEventComputed ??=
          Computed<Event>(() => super.getEvent, name: 'SectionBase.getEvent'))
      .value;

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

  late final _$getAllNewByLocalityAsyncAction =
      AsyncAction('SectionBase.getAllNewByLocality', context: context);

  @override
  Future<List<New>> getAllNewByLocality(String locality) {
    return _$getAllNewByLocalityAsyncAction
        .run(() => super.getAllNewByLocality(locality));
  }

  late final _$getAllEventsByLocalityAsyncAction =
      AsyncAction('SectionBase.getAllEventsByLocality', context: context);

  @override
  Future<List<Event>> getAllEventsByLocality(String locality) {
    return _$getAllEventsByLocalityAsyncAction
        .run(() => super.getAllEventsByLocality(locality));
  }

  late final _$getEventByUsernameAndTitleAsyncAction =
      AsyncAction('SectionBase.getEventByUsernameAndTitle', context: context);

  @override
  Future<Event> getEventByUsernameAndTitle(String username, String title) {
    return _$getEventByUsernameAndTitleAsyncAction
        .run(() => super.getEventByUsernameAndTitle(username, title));
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

  @override
  String toString() {
    return '''
newList: ${newList},
new_: ${new_},
eventList: ${eventList},
event: ${event},
pharmaciesList: ${pharmaciesList},
tourismList: ${tourismList},
servicesList: ${servicesList},
sectionList: ${sectionList},
getList: ${getList},
getListEvent: ${getListEvent},
getNew: ${getNew},
getListPharmacy: ${getListPharmacy},
getListTourism: ${getListTourism},
getListServices: ${getListServices},
getSections: ${getSections},
getEvent: ${getEvent}
    ''';
  }
}

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

  late final _$getAllPharmaciesByLocalityAsyncAction =
      AsyncAction('SectionBase.getAllPharmaciesByLocality', context: context);

  @override
  Future<List<Pharmacy>> getAllPharmaciesByLocality(String locality) {
    return _$getAllPharmaciesByLocalityAsyncAction
        .run(() => super.getAllPharmaciesByLocality(locality));
  }

  @override
  String toString() {
    return '''
newList: ${newList},
new_: ${new_},
eventList: ${eventList},
pharmaciesList: ${pharmaciesList},
getList: ${getList},
getListEvent: ${getListEvent},
getNew: ${getNew},
getListPharmacy: ${getListPharmacy}
    ''';
  }
}

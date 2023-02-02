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

  @override
  String toString() {
    return '''
newList: ${newList},
eventList: ${eventList},
getList: ${getList},
getListEvent: ${getListEvent}
    ''';
  }
}

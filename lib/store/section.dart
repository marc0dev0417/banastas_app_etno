import 'dart:convert';

import 'package:etno_app/models/UserSubscription.dart';
import 'package:etno_app/models/menu/Menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;

import '../models/Event.dart';
import '../models/FCMToken.dart';
import '../models/New.dart';
import '../models/Pharmacy.dart';
import '../models/Tourism.dart';
import '../models/Service.dart';

part 'section.g.dart';

class Section = SectionBase with _$Section;

abstract class SectionBase with Store {
  final String urlBase = 'http://192.168.137.1:8080/';

  @observable
  List<New> newList = [];
  @observable
  bool isSubscribe = false;
  @observable
  New new_ = New.empty();
  @observable
  List<Event> eventList = [];
  @observable
  Event event = Event.empty();
  @observable
  List<Pharmacy> pharmaciesList = [];
  @observable
  List<Tourism> tourismList = [];
  @observable
  List<Service> servicesList = [];
  @observable
  List<Menu> sectionList = [
    Menu(Icons.celebration, 'Eventos'),
    Menu(Icons.map, 'Turismo'),
    Menu(Icons.local_pharmacy, 'Farmacias'),
    Menu(Icons.home_repair_service, 'Servicios'),
    Menu(Icons.newspaper, 'Noticias'),
    Menu(Icons.campaign, 'Bandos'),
    Menu(Icons.picture_in_picture, 'Anuncios'),
    Menu(Icons.collections, 'Galería'),
    Menu(Icons.sentiment_very_dissatisfied, 'Defunciones'),
    Menu(Icons.link, 'Enlaces'),
    Menu(Icons.handshake, 'Patrocinadores'),
    Menu(Icons.report_problem, 'Incidentes'),
    Menu(Icons.book_online, 'Reservaciones')
  ];

  @action
  Future<List<New>> getAllNewByLocality(String locality) async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.137.1:8080/news?username=$locality'),
      );
      final decodeBody = utf8.decode(response.bodyBytes);
      final data =
          (jsonDecode(decodeBody) as List).map((e) => New.fromJson(e)).toList();
      newList = data;
      return data;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @action
  Future<List<Event>> getAllEventsByLocality(String locality) async {
    try {
      final response = await http.get(
          Uri.parse('http://192.168.137.1:8080/events?username=$locality'));
      final decodeBody = utf8.decode(response.bodyBytes);
      final data = (jsonDecode(decodeBody) as List)
          .map((e) => Event.fromJson(e))
          .toList();
      eventList = data;
      return data;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @action
  Future<Event> getEventByUsernameAndTitle(String username, String title) async{
    try{
      final response = await http.get(Uri.parse('http://192.168.137.1:8080/events?username=$username&title=$title'));
      final decodeBody = utf8.decode(response.bodyBytes);
      final data = Event.fromJson(jsonDecode(decodeBody));
      return data;
    }catch(e){
      debugPrint(e.toString());
      rethrow;
    }
  }

  @action
  Future<FCMToken> saveFcmToken(FCMToken fcmToken) async{
    try{
     final response = await http.post(Uri.parse('http://192.168.137.1:8080/FCMTokens'), body: jsonEncode(fcmToken.toJson()), headers: <String, String> {
       'Content-Type': 'application/json; charset=UTF-8'
     });
     final decodeBody = utf8.decode(response.bodyBytes);
     final data = FCMToken.fromJson(jsonDecode(decodeBody));
     return data;
    }catch(e){
      debugPrint(e.toString());
      rethrow;
    }
  }
  
  @action
  Future<bool> getSubscription(String fcmToken, String title) async{
    try{
      final response = await http.get(Uri.parse('http://192.168.137.1:8080/subscription_users?fcmToken=$fcmToken&title=$title'));
      final decodeBody = utf8.decode(response.bodyBytes);
      final data = UserSubscription.fromJson(jsonDecode(decodeBody));
      isSubscribe = data.isSubscribe!;
      return data.isSubscribe!;
    }catch(e){
      debugPrint(e.toString());
      rethrow;
    }
  }

  @action
  Future<List<Pharmacy>> getAllPharmaciesByLocality(String locality) async {
    try {
      final response = await http.get(
          Uri.parse('http://192.168.137.1:8080/pharmacies?username=$locality'));
      final decodeBody = utf8.decode(response.bodyBytes);
      final data = (jsonDecode(decodeBody) as List)
          .map((e) => Pharmacy.fromJson(e))
          .toList();
      pharmaciesList = data;
      return data;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @action
  Future<List<Tourism>> getAllTourismByLocality(String locality) async {
    try {
      final response = await http.get(
          Uri.parse('http://192.168.137.1:8080/tourism?username=$locality'));
      final decodeBody = utf8.decode(response.bodyBytes);
      final data = (jsonDecode(decodeBody) as List)
          .map((e) => Tourism.fromJson(e))
          .toList();
      tourismList = data;
      return data;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @action
  Future<List<Service>> getAllServiceByLocalityAndCategory(
      String locality, String category) async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.137.1:8080/phones?username=$locality&category=$category'));
      final decodeBody = utf8.decode(response.bodyBytes);
      final data = (jsonDecode(decodeBody) as List)
          .map((e) => Service.fromJson(e))
          .toList();
      servicesList = data;
      return data;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @computed
  List<New> get getList => newList;
  @computed
  List<Event> get getListEvent => eventList;
  @computed
  New get getNew => new_;
  @computed
  List<Pharmacy> get getListPharmacy => pharmaciesList;
  @computed
  List<Tourism> get getListTourism => tourismList;
  @computed
  List<Service> get getListServices => servicesList;
  @computed
  List<Menu> get getSections => sectionList;
  @computed
  Event get getEvent => event;
  @computed
  bool get getIsSubscribe => isSubscribe;
}
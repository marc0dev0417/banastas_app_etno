import 'dart:convert';

import 'package:etno_app/models/MailDetails.dart';
import 'package:etno_app/models/UserSubscription.dart';
import 'package:etno_app/models/menu/Menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;

import '../models/Bandos.dart';
import '../models/Defunction.dart';
import '../models/Event.dart';
import '../models/FCMToken.dart';
import '../models/Image.dart';
import '../models/Incident.dart';
import '../models/Link.dart';
import '../models/Message.dart';
import '../models/New.dart';
import '../models/Pharmacy.dart';
import '../models/Sponsor.dart';
import '../models/Tourism.dart';
import '../models/Service.dart';
import '../models/menu/Ad.dart';

part 'section.g.dart';

class Section = SectionBase with _$Section;

abstract class SectionBase with Store {
  String urlBase = 'http://192.168.137.1:8080/';

  @observable
  List<New> newList = [];
  @observable
  List<New> newListEventCategory = [];
  @observable
  List<Sponsor> sponsorList = [];
  @observable
  List<Defunction> defunctionList = [];
  @observable
  List<Link> linkList = [];
  @observable
  List<Bandos> bandoList = [];
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
  List<Ad> adsList = [];
  @observable
  List<ImageMedia> imageList = [];
  @observable
  List<Incident> incidentList = [];
  @observable
  Message message = Message.empty();
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
  Future<List<New>> getNewsListByLocalityAndCategory(String locality, String category) async{
    try {
      final response = await http.get(
        Uri.parse('http://192.168.137.1:8080/news?username=$locality&category=$category')
      );
      final decodeBody = utf8.decode(response.bodyBytes);
      final data = (jsonDecode(decodeBody) as List).map((e) => New.fromJson(e)).toList();
      newListEventCategory = data;
      return data;
    }catch (e){
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
  Future<List<Defunction>> getAllDefunctionsByLocality(String locality) async {
    try {
      final response = await http.get(Uri.parse('http://192.168.137.1:8080/deaths?username=$locality'));
      final decodeBody = utf8.decode(response.bodyBytes);
      final data = (jsonDecode(decodeBody) as List).map((e) => Defunction.fromJson(e)).toList();
      print(data);
      defunctionList = data;
      return data;
    }catch(e){
      debugPrint(e.toString());
      rethrow;
    }
  }

  @action
  Future<List<Sponsor>> getSponsorsByLocality(String locality) async {
    try {
      final response = await http.get(Uri.parse('http://192.168.137.1:8080/sponsors'));
      final decodeBody = utf8.decode(response.bodyBytes);
      final data = (jsonDecode(decodeBody) as List).map((e) => Sponsor.fromJson(e)).toList();
      print(data);
      sponsorList = data;
      return data;
    }catch(e){
      debugPrint(e.toString());
      rethrow;
    }
  }

  @action
  Future<List<Link>> getAllLinksByLocality(String locality) async {
    try {
      final response = await http.get(Uri.parse('http://192.168.137.1:8080/links?username=$locality'));
      final decodeBody = utf8.decode(response.bodyBytes);
      final data = (jsonDecode(decodeBody) as List).map((e) => Link.fromJson(e)).toList();
      print(data);
      linkList = data;
      return data;
    }catch(e){
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
          'http://192.168.137.1:8080/services?username=$locality&category=$category'));
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

  @action
  Future<List<Ad>> getAllAdsByLocality(String locality) async {
    try{
      final response = await http.get(Uri.parse('http://192.168.137.1:8080/ads?username=$locality'));
      final decodeBody = utf8.decode(response.bodyBytes);
      final data = (jsonDecode(decodeBody) as List).map((e) => Ad.fromJson(e)).toList();
      adsList = data;
      return data;
    }catch(e){
      debugPrint(e.toString());
      rethrow;
    }
  }

  @action
  Future<List<Bandos>> getAllBandosByLocality(String locality) async {
    try{
      final response = await http.get(Uri.parse('http://192.168.137.1:8080/bandos/filtered?username=$locality'));
      final decodeBody = utf8.decode(response.bodyBytes);
      final data = (jsonDecode(decodeBody) as List).map((e) => Bandos.fromJson(e)).toList();
      bandoList = data;
      return data;
    }catch(e){
      debugPrint(e.toString());
      rethrow;
    }
  }
  @action
  Future<List<ImageMedia>> getAllImageMediaByLocality(String locality) async{
    try{
      final response = await http.get(Uri.parse('http://192.168.137.1:8080/images?locality=$locality'));
      final decodeBody = utf8.decode(response.bodyBytes);
      final data = (jsonDecode(decodeBody) as List).map((e) => ImageMedia.fromJson(e)).toList();
      imageList = data;
      return data;
    }catch(e){
      debugPrint(e.toString());
      rethrow;
    }
  }
  @action
  Future<List<Incident>> getAllIncidentByLocalityAndFcmToken(String locality, String fcmToken) async {
    try{
      final response = await http.get(Uri.parse('http://192.168.137.1:8080/incidents/villager?username=$locality&fcmToken=$fcmToken'));
      final decodeBody = utf8.decode(response.bodyBytes);
      final data = (jsonDecode(decodeBody) as List).map((e) => Incident.fromJson(e)).toList();
      incidentList = data;
      return data;
    }catch(e){
      debugPrint(e.toString());
      rethrow;
    }
  }
  @action
  Future<Message> sendMailMessage(MailDetails mailDetails) async{
    try{
      final response = await http.post(Uri.parse('http://192.168.137.1:8080/sendMail'), body: jsonEncode(mailDetails.toJson()), headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8'
      });
      final decodeBody = utf8.decode(response.bodyBytes);
      final data = Message.fromJson(jsonDecode(decodeBody));
      return data;
    }catch(e){
      debugPrint(e.toString());
      rethrow;
    }
  }

  @action
  Future addIncident(Incident incident) async{
    try{
      final response = await http.post(Uri.parse('http://192.168.137.1:8080/users/add/incident?username=${incident.username}'), body: jsonEncode(incident.toJson()), headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8'
      });
      final decodeBody = utf8.decode(response.bodyBytes);
      print(decodeBody);
    }catch(e){
      debugPrint(e.toString());
      rethrow;
    }
  }

  @computed
  List<New> get getList => newList;
  @computed
  List<New> get getListNewCategory => newListEventCategory;
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
  List<Defunction> get getDefunctions => defunctionList;
  @computed
  List<Link> get getLinks => linkList;
  @computed
  List<Sponsor> get getSponsors => sponsorList;
  @computed
  List<Ad> get getAds => adsList;
  @computed
  List<Bandos> get getBandos => bandoList;
  @computed
  List<ImageMedia> get getImages => imageList;
  @computed
  List<Incident> get getIncidents => incidentList;
  @computed
  Message get getMessage => message;
  @computed
  Event get getEvent => event;
  @computed
  bool get getIsSubscribe => isSubscribe;
}
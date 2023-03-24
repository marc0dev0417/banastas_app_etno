import 'package:card_swiper/card_swiper.dart';
import 'package:etno_app/models/Event.dart';
import 'package:etno_app/pages/PageBookForm.dart';
import 'package:etno_app/pages/PageNewDetail.dart';
import 'package:etno_app/store/section.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/New.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget swiperNews(Section section, BuildContext context) {
  return Observer(builder: (value) {
    if (section.getList.isEmpty) {
      return Text(AppLocalizations.of(context)!.news_empty);
    } else {
      return SizedBox(
          width: double.infinity,
          height: 250,
          child: Observer(
              builder: (value) => Swiper(
                autoplay: true,
                    autoplayDelay: 5000,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () => {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                   (context, animation1, animation2) => PageNewDetail(
                                      new_: New(
                                          section.getList[index].idNew,
                                          section.getList[index].username,
                                          section.getList[index].category,
                                          section.getList[index].title,
                                          section
                                              .getList[index].publicationDate,
                                          section.getList[index].description,
                                          section.getList[index].imageUrl)),
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero)
                          )
                        },
                        child: Card(
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            decoration: BoxDecoration(
                              image: DecorationImage(image: NetworkImage(section.getList[index].imageUrl!), fit: BoxFit.fill)
                            ),
                            child: const Icon(Icons.newspaper, color: Colors.white)
                          )
                        ),
                      );
                    },
                    itemCount: section.getList.length,
                    viewportFraction: 0.6,
                    scale: 0.9,
                  )));
    }
  });
}

Widget swiperEvent(Section section, BuildContext context) {
  return Observer(builder: (value) {
    if (section.getListEvent.isEmpty) {
      return Text(AppLocalizations.of(context)!.events_empty);
    } else {
      return SizedBox(
          width: double.infinity,
          height: 250,
          child: Swiper(
              autoplay: true,
              autoplayDelay: 5000,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                    onTap: () {
                      FirebaseMessaging.instance.getToken().then((value){
                        section.getSubscription(value!, section.getListEvent[index].title!).then((value){
                          section.getEventByUsernameAndTitle(section.getListEvent[index].username!, section.getListEvent[index].title!).then((event){
                            showDialogEvent(context, event, value);
                          });
                        });
                      });
                    },
                    child: Card(
                        elevation: 5.0,
                        color: Colors.white,
                        child: Container(
                            decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(section.getListEvent[index].imageUrl!), fit: BoxFit.fill)),
                            alignment: Alignment.bottomCenter,
                            child:
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    decoration: const BoxDecoration(color: Colors.white),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.celebration, size: 20.0),
                                          const SizedBox(
                                            width: 8.0,
                                          ),
                                          Text(
                                              section.getListEvent[index].title!,
                                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0)
                                          )
                                        ]
                                    ),
                                  )
                              ],
                            )
                        )
                    )
                );
              },
              itemCount: section.getListEvent.length,
              viewportFraction: 0.9,
              scale: 0.9
          )
      );
    }
  });
}

Widget renderImageNew(Section section, int index) {
  if (section.getList[index].imageUrl == null) {
    return Image.asset('assets/Loading_icon.gif', height: 200);
  } else {
    return Image.network(section.getList[index].imageUrl!,
        fit: BoxFit.fill, height: 200, width: 300);
  }
}

ImageProvider<Object> renderImageEvent(Section section, int index) {
  if (section.getListEvent[index].imageUrl == null) {
    return const AssetImage('assets/Loading_icon.gif');
  } else {
    return NetworkImage(section.getListEvent[index].imageUrl!);
  }
}

Future<void> launchInBrowser(Uri url) async{
  if(!await launchUrl(
      url,
      mode: LaunchMode.externalApplication
  )){
    throw Exception('Could not launch $url');
  }
}

showDialogEvent(BuildContext context, Event event, bool isSubscribe) => showBottomSheet(enableDrag: true ,context: context, builder: (context){
  final Section section = Section();
  return Wrap(
    children: [
      Column(
        children: [
          Container(
              padding: const EdgeInsets.only(top: 15.0),
              child: renderImageEventModal(event)
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(15.0),
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 15.0),
                        alignment: Alignment.topLeft,
                        child: Text(event.title!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0)),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 15.0),
                        alignment: Alignment.topLeft,
                        child: Text('${event.username}', style: const TextStyle(color: Colors.grey, fontSize: 10.0)),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 15.0, top: 4.0),
                        alignment: Alignment.topLeft,
                        child: const Text('Capacidad', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0)),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 15.0),
                        alignment: Alignment.topLeft,
                        child: Text('Plazas ${event.seats}/${event.capacity}', style: const TextStyle(color: Colors.grey, fontSize: 10.0)),
                      ),
                      const Divider(),
                      Container(
                        padding: const EdgeInsets.only(left: 15.0, top: 4.0, bottom: 4.0),
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text('${event.startDate}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0)),
                                ),
                                const SizedBox(
                                  width: 4.0,
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child:  const Text('- Fecha de Inicio', style: TextStyle(color: Colors.grey, fontSize: 10.0)),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.2,
                                ),
                                Visibility(
                                  maintainSize: true,
                                  maintainAnimation: true,
                                  maintainState: true,
                                  visible: event.hasSubscription!,
                                    child: Container(
                                        alignment: Alignment.bottomRight,
                                        child: ElevatedButton(style:  ButtonStyle(backgroundColor: !isSubscribe ? const MaterialStatePropertyAll(Colors.red) : const MaterialStatePropertyAll(Colors.grey)), onPressed: (){
                                          if(!isSubscribe){
                                            Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => MaterialAppBookForm(event: event), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero));
                                          }else{
                                            FirebaseMessaging.instance.getToken().then((value) => section.dropSubscription('Bolea', event.title!, value!));
                                            Fluttertoast.showToast(
                                                msg: 'Se ha desuscrito del evento',
                                                toastLength: Toast.LENGTH_SHORT,
                                                fontSize: 12,
                                                textColor: Colors.white,
                                                backgroundColor: Colors.green
                                            );
                                            FirebaseMessaging.instance.getToken().then((value){
                                              section.getSubscription(value!, event.title!).then((value){
                                                section.getEventByUsernameAndTitle(event.username!, event.title!).then((event){
                                                  showDialogEvent(context, event, false);
                                                });
                                              });
                                            });
                                          }
                                        }, child: !isSubscribe ? const Text('Subscribirse', style: TextStyle(color: Colors.white)) : const Text('Desuscribirse', style: TextStyle(color: Colors.white)))
                                    ),
                                )
                              ],
                            )
                          ],
                        )
                      ),
                      const Divider(),
                      Container(
                        padding: const EdgeInsets.only(left: 15.0),
                        alignment: Alignment.topLeft,
                        child: Text(
                            event.description!,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0)
                        )
                      ),
                      SizedBox(height: 16.0),
                      Container(
                          padding: const EdgeInsets.only(left: 15.0),
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                              onTap: () => launchInBrowser(Uri.parse('https://maps.google.com/?daddr=${event.lat},${event.long}')),
                              child: const Text('Mostrar Mapa', style: TextStyle(color: Colors.blue))
                          )
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      )
    ],
  );
  });

Widget renderImageEventModal(Event event){
  if(event.imageUrl == null){
    return const CircularProgressIndicator();
  }else{
    return Image.network(event.imageUrl!, fit: BoxFit.fill, height: 200, width: 300);
  }
}
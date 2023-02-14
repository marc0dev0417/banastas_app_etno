import 'package:card_swiper/card_swiper.dart';
import 'package:etno_app/models/Event.dart';
import 'package:etno_app/pages/PageBookForm.dart';
import 'package:etno_app/pages/PageNewDetail.dart';
import 'package:etno_app/store/section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../models/New.dart';

Widget swiperNews(Section section) {
  return Observer(builder: (value) {
    if (section.getList.isEmpty) {
      return const Text('No hay Noticias disponibles');
    } else {
      return SizedBox(
          width: double.infinity,
          height: 250,
          child: Observer(
              builder: (value) => Swiper(
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
                          child: Column(
                            children: [
                              renderImageNew(section, index),
                              const SizedBox(
                                height: 10.0,
                              ),
                            //  Text(section.getList[index].title!)
                            ],
                          ),
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

Widget swiperEvent(Section section) {
  return Observer(builder: (value) {
    if (section.getListEvent.isEmpty) {
      return const Text('No hay Eventos disponibles');
    } else {
      return SizedBox(
          width: double.infinity,
          height: 250,
          child: Swiper(
              loop: false,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                    onTap: () {
                      section.getEventByUsernameAndTitle(section.getListEvent[index].username!, section.getListEvent[index].title!).then((value) =>
                          showDialogEvent(context, value)
                      );
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
                              children:  [
                                  Container(
                                    decoration: const BoxDecoration(color: Colors.white),
                                    child: Row(
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

showDialogEvent(BuildContext context, Event event) => showBottomSheet(context: context, builder: (context){
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
                        child: Text('${event.username} · Huesca', style: const TextStyle(color: Colors.grey, fontSize: 10.0)),
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
                                Container(
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton(style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red)), onPressed: () => Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => PageBookForm(event: event), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)), child: const Text('Subscribirse')),
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
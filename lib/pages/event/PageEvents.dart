import 'package:etno_app/utils/WarningWidgetValueNotifier.dart';
import 'package:etno_app/widgets/bottom_navigation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:etno_app/models/Event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../store/section.dart';
import '../../widgets/appbar_navigation.dart';
import '../../widgets/home_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class PageEvents extends StatefulWidget {
  const PageEvents({super.key});

  @override
  State<StatefulWidget> createState() {
    return PageState();
  }
}

class PageState extends State<PageEvents> {
  final Section section = Section();
  List<Event> eventList = [];
  int tabIndex = 0;
  @override
  void initState() {
    section.getAllEventsByLocality('Bolea').then((value) => eventList = value);
    super.initState();
  }

  Widget nothingEvents() {
    return Observer(
        builder: (context) => section.getListEvent.isNotEmpty
            ? Expanded(
            child: Observer(
                builder: (context) => GridView.count(
                    padding: EdgeInsets.all(16.0),
                    crossAxisCount: 2,
                    children: section.getListEvent
                        .map((e) => Center(
                        child: SizedBox(
                          width: 200.0,
                          height: 200.0,
                          child: InkWell(
                            onTap: () => FirebaseMessaging.instance
                                .getToken()
                                .then((value) {
                              section
                                  .getSubscription(value!, e.title!)
                                  .then((value) {
                                section
                                    .getEventByUsernameAndTitle(
                                    e.username!, e.title!)
                                    .then((event) {
                                  showDialogEvent(
                                      context, event, value);
                                });
                              });
                            }),
                            child: Card(
                                child: Container(
                                    alignment: Alignment.bottomLeft,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(image: renderBackgroundImage(e),fit: BoxFit.fill)),
                                    child: Container(
                                      padding:
                                      const EdgeInsets.all(8.0),
                                      decoration: const BoxDecoration(
                                          color: Colors.red),
                                      child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                                Icons.celebration,
                                                color: Colors.white),
                                            const SizedBox(width: 4.0),
                                            Text(
                                                e.title!.length < 19
                                                    ? e.title!
                                                    : e.title!
                                                    .substring(
                                                    0, 19),
                                                style: const TextStyle(
                                                    color:
                                                    Colors.white))
                                          ]),
                                    ))),
                          ),
                        )))
                        .toList())))
            : Container(
            alignment: Alignment.center,
            child: Column(children: [
              Text(AppLocalizations.of(context)!.events_empty,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Icon(Icons.celebration, size: 50.0)
            ])));
    return Observer(builder: (context) =>
    section.getListEvent.isNotEmpty ? Expanded(
        child: Observer(builder: (context) =>
            ListView(
              children: section.getListEvent.map((e) => cardEvent(e, section, context)).toList(),
            )
        )
    ): Container(
        alignment: Alignment.center,
        child: Column(
            children: [
              Text(AppLocalizations.of(context)!.events_empty, style: TextStyle(fontWeight: FontWeight.bold)),
              Icon(Icons.celebration, size: 50.0)
            ]
        )
    )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarCustom(context, false, AppLocalizations.of(context)!.event,
          Icons.language, false, () => null, null),
      bottomNavigationBar: bottomNavigation(context, 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [const WarningWidgetValueNotifier(), nothingEvents()],
      ),
    );
  }
}

ImageProvider<Object> renderBackgroundImage(Event e) {
  if (e.imageUrl == null)
    return AssetImage('assets/events.jpg');
  else
    return NetworkImage(e.imageUrl!);
}
Widget cardEvent(Event event, Section section, BuildContext context){
  return
    InkWell(
        onTap: () => {
          FirebaseMessaging.instance.getToken().then((value){
            section.getSubscription(value!, event.title!).then((value){
              section.getEventByUsernameAndTitle(event.username!, event.title!).then((event){
                showDialogEvent(context, event, value);
              });
            });
          })
        },
        child: Card(
          child:
          Container(
              height: 200.0,
              alignment: Alignment.bottomLeft,
              decoration:  BoxDecoration(
                  image: DecorationImage(image: NetworkImage(event.imageUrl!), fit: BoxFit.fill)),
              child: Container(
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.all(4.0),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(event.hasSubscription! ? 'Subscripción' : 'Gratuito', style: const TextStyle(color: Colors.white,  fontWeight: FontWeight.bold, fontSize: 12.0, backgroundColor: Colors.blue)),
                          const SizedBox(width: 4.0),
                          Text(event.title!, style: const TextStyle(color: Colors.white, backgroundColor: Colors.red, fontWeight: FontWeight.bold, fontSize: 12.0))
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      Text(event.description!, style: const TextStyle(color: Colors.white), maxLines: 2)
                    ]
                ),
              )
          ),
        ));
}
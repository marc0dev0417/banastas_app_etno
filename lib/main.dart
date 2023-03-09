import 'dart:async';

import 'package:etno_app/models/FCMToken.dart';
import 'package:etno_app/pages/PageAd.dart';
import 'package:etno_app/pages/PageBandos.dart';
import 'package:etno_app/pages/PageDefunctions.dart';
import 'package:etno_app/pages/PageLinks.dart';
import 'package:etno_app/pages/PageListReserves.dart';
import 'package:etno_app/pages/PageNews.dart';
import 'package:etno_app/pages/PagePharmacies.dart';
import 'package:etno_app/pages/PageServices.dart';
import 'package:etno_app/pages/PageSponsors.dart';
import 'package:etno_app/pages/PageTourism.dart';
import 'package:etno_app/pages/event/PageEvents.dart';
import 'package:etno_app/pages/gallery/PageGallery.dart';
import 'package:etno_app/pages/incident/PageIncidents.dart';
import 'package:etno_app/provider/locale_provider.dart';
import 'package:etno_app/store/section.dart';
import 'package:etno_app/utils/ConnectionChecker.dart';
import 'package:etno_app/utils/WarningWidgetValueNotifier.dart';
import 'package:etno_app/widgets/appbar_navigation.dart';
import 'package:etno_app/widgets/bottom_navigation.dart';
import 'package:etno_app/widgets/home_widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart' as Card;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'l10n/l10n.dart';
import 'models/Weather/Weather.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print("Handling a background message ${message.messageId}");
}

final internetChecker = CheckInternetConnection();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  Stripe.publishableKey =
      'pk_live_51MdqjZIiwWrt0LxLwUWAcWlZlJRVqzkZE8pvcwx5qgtXMy8OSw9rdPm4X8zb5JDMzblCswJRc6eNcA1PSydYvOE000rpx0MTpS';
  await Stripe.instance.applySettings();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      builder: (context, child){
        final provider = Provider.of<LocaleProvider>(context);
        return  MaterialApp(
          theme: ThemeData(useMaterial3: true, cardTheme: const CardTheme(color: Colors.white)),
          locale: provider.locale,
          supportedLocales: L10n.all,
          title: 'Etno App',
          home: const Home(),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
        );
      }
  );
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  Weather weather = Weather.empty();
  late TextEditingController controller;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  int bottomIndex = 0;
  final Section section = Section();

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
  }

  @override
  void initState() {
    controller = TextEditingController();
    section.getAllNewByLocality('Bolea');
    section.getAllEventsByLocality('Bolea');
    messaging
        .getToken()
        .then((value) => section.saveFcmToken(FCMToken('Bolea', value)));
    setupInteractedMessage();
    super.initState();
    section.getWeather('Bolea').then((value) => setState(() => {
      weather = value
    }));
  }

  Widget notConnection() {
    return Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.wifi_off, size: 160.0),
            Text('No hay conexión a Internet')
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
              backgroundColor: Colors.white,
              appBar: appBarCustom(AppLocalizations.of(context)!.bottom_home, Icons.language, () => null, null),
              body: SafeArea(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const WarningWidgetValueNotifier(),
                            SizedBox(
                              height: 120.0,
                              width: double.maxFinite,
                              child: GestureDetector(
                                child: Card.Card(
                                  color: Colors.white,
                                  elevation: 2.0,
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset('assets/bolea_shield.png'),
                                        const SizedBox(width: 16.0),
                                        Column(
                                          children:  [
                                            weather.temp == null ? const SizedBox(width: 15.0, height: 15.0, child: CircularProgressIndicator(color: Colors.red)) :
                                            Text('${weather.temp}ºC', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0)),
                                            const Text('Bolea', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18.0)),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ),
                              ),
                            ),
                        Expanded(child: Observer(builder: (context) => GridView.count(
                          crossAxisCount: 2,
                          children: section.getSections.map((e) => GestureDetector(
                            onTap: () {
                              switch(e.title){
                                case 'Eventos': Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => const PageEvents(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)); break;
                                case 'Turismo': Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => const PageTourism(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)); break;
                                case 'Farmacias': Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => const PagePharmacies(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)); break;
                                case 'Anuncios': Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => const PageAd(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)); break;
                                case 'Noticias': Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => const PageNews(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)); break;
                                case 'Galería': Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => const PageGallery(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)); break;
                                case 'Enlaces': Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => const PageLinks(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)); break;
                                case 'Defunciones': Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => const PageDefunctions(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)); break;
                                case 'Servicios': Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => const PageServices(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)); break;
                                case 'Patrocinadores': Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => const PageSponsors(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)); break;
                                case 'Bandos': Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => const PageBandos(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)); break;
                                case 'Incidentes': Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => const PageIncidents(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)); break;
                                case 'Reservas': Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => const PageListReserves(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero));
                              }
                            },
                            child: Card.Card(
                              elevation: 2.0,
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                     Image.asset(e.assetImage!, width: 45.0, height: 45.0),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(e.title!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
                                        const Text('5 noticias', style: TextStyle(color: Colors.grey, fontSize: 12.0))
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ),
                          )).toList()
                        )))
                      ],
                    ),
                  )
              ),
              bottomNavigationBar: bottomNavigation(context, 0),
            );
    }
}

Widget cardPharmacies(String title, BuildContext context, double width) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  const PagePharmacies(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero));
    },
    child: Card.Card(
        color: Colors.red,
        elevation: 2.0,
        child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const Icon(Icons.local_pharmacy),
                const SizedBox(width: 20.0),
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                SizedBox(width: width),
                const Icon(Icons.chevron_right)
              ],
            ))),
  );
}

Widget cardTourism(String title, BuildContext context, double width) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  const PageTourism(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero));
    },
    child: Card.Card(
        color: Colors.red,
        elevation: 2.0,
        child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const Icon(Icons.map),
                const SizedBox(width: 20.0),
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                SizedBox(width: width),
                const Icon(Icons.chevron_right)
              ],
            ))),
  );
}

Widget cardServices(String title, BuildContext context, double width) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  const PageServices(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero));
    },
    child: Card.Card(
      color: Colors.red,
      elevation: 2.0,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            const Icon(Icons.home_repair_service),
            const SizedBox(width: 20.0),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
            SizedBox(width: width),
            const Icon(Icons.chevron_right)
          ],
        ),
      ),
    ),
  );
}

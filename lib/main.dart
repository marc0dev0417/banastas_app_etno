import 'dart:async';

import 'package:etno_app/models/FCMToken.dart';
import 'package:etno_app/pages/PagePharmacies.dart';
import 'package:etno_app/pages/PageServices.dart';
import 'package:etno_app/pages/PageTourism.dart';
import 'package:etno_app/store/section.dart';
import 'package:etno_app/widgets/appbar_navigation.dart';
import 'package:etno_app/widgets/bottom_navigation.dart';
import 'package:etno_app/widgets/home_widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print("Handling a background message ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      title: 'Etno App',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}
class HomeState extends State<Home> {
  late StreamSubscription internetSubscription;
  late TextEditingController controller;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  int bottomIndex = 0;
  bool connection = true;
  final Section section = Section();

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();
  }

  @override
  void initState() {
    internetSubscription = InternetConnectionChecker().onStatusChange.listen((status) {
      setState(() {
        final hasInternet = status == InternetConnectionStatus.connected;
        connection = hasInternet;
        controller = TextEditingController();
        section.getAllNewByLocality('Bolea');
        section.getAllEventsByLocality('Bolea');
        messaging.getToken().then((value) => section.saveFcmToken(FCMToken('Bolea', value)));
        setupInteractedMessage();
      });
    });
    controller = TextEditingController();
    section.getAllNewByLocality('Bolea');
    section.getAllEventsByLocality('Bolea');
    messaging.getToken().then((value) => section.saveFcmToken(FCMToken('Bolea', value)));
    setupInteractedMessage();
    super.initState();
  }
  @override
  void dispose() {
    internetSubscription.cancel();
    super.dispose();
  }

  Widget notConnection(){
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.wifi_off, size: 160.0),
          Text('No hay conexión a Internet')
        ],
      )
    );
  }

  Widget renderWidget(){
    if(connection){
     return Container(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Explorar',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                // const Text('Noticias', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.5)),
                const Text('Noticias sugeridas para ti', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 20.0),
                swiperNews(section),
                const SizedBox(height: 20.0),
                const Text('Farmacias', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                const Text('Encuentras las farmacias de tu localidad', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 20.0),
                cardPharmacies('Farmacias de guardia y normal', context, 70.0),
                const SizedBox(height: 20.0),
                const Text('Turismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                const Text('Turismo más relevante', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 20.0),
                cardTourism('Turismo', context, 210.0),
                const SizedBox(height: 20.0),
                const Text('Eventos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                const Text('Mira los eventos más destacados', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 20.0),
                swiperEvent(section),
                const SizedBox(height: 10.0),
                const Text('Servicios', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                const Text('Servicios más relevante', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 20.0),
                cardServices('Los mejores servicios de tu localidad', context, 30.0)
              ],
            ),
          )
      );
    }else{
      return notConnection();
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: appBarCustom('Inicio', Icons.language, () => print('Internalization')),
      body: SafeArea(
        child: renderWidget()
      ),
      bottomNavigationBar: bottomNavigation(context, 0),
    );
  }
}

Widget cardPharmacies(String title, BuildContext context, double width){
  return InkWell(
    onTap: () { Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => const PagePharmacies(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)); },
    child: Card(
      elevation: 2.0,
        child:
        Container(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const Icon(Icons.local_pharmacy),
                const SizedBox(width: 20.0),
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: width),
                const Icon(Icons.chevron_right)
              ],
            )
        )
    ),
  );
}

Widget cardTourism(String title, BuildContext context, double width){
  return InkWell(
    onTap: () { Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => const PageTourism(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)); },
    child: Card(
      elevation: 2.0,
        child:
        Container(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const Icon(Icons.map),
                const SizedBox(width: 20.0),
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: width),
                const Icon(Icons.chevron_right)
              ],
            )
        )
    ),
  );
}

Widget cardServices(String title, BuildContext context, double width){
  return InkWell(
    onTap: () { Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => const PageServices(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)); },
    child: Card(
      elevation: 2.0,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            const Icon(Icons.home_repair_service),
            const SizedBox(width: 20.0),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(width: width),
            const Icon(Icons.chevron_right)
          ],
        ),
      ),
    ),
  );
}
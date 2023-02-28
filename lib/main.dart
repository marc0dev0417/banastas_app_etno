import 'dart:async';

import 'package:etno_app/models/FCMToken.dart';
import 'package:etno_app/pages/PagePharmacies.dart';
import 'package:etno_app/pages/PageServices.dart';
import 'package:etno_app/pages/PageTourism.dart';
import 'package:etno_app/provider/locale_provider.dart';
import 'package:etno_app/store/section.dart';
import 'package:etno_app/utils/ConnectionChecker.dart';
import 'package:etno_app/utils/WarningWidgetValueNotifier.dart';
import 'package:etno_app/widgets/DropDownLanguage.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'bloc/payment/payment_bloc.dart';
import 'firebase_options.dart';
import 'l10n/l10n.dart';

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
        return MaterialApp(
            title: 'Main',
            home: Scaffold(
              appBar: appBarCustom(AppLocalizations.of(context)!.bottom_home, Icons.language, () => null, null),
              body: SafeArea(
                  child: Container(
                      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/Bolea.png'))),
                      padding: const EdgeInsets.all(15.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const WarningWidgetValueNotifier(),
                            Text(
                              AppLocalizations.of(context)!.discover,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                             Text(AppLocalizations.of(context)!.description_new,
                                style: const TextStyle(color: Colors.grey)),
                            const SizedBox(height: 20.0),
                            swiperNews(section, context),
                            const SizedBox(height: 20.0),
                             Text(AppLocalizations.of(context)!.pharmacy,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20.0)),
                             Text(AppLocalizations.of(context)!.description_pharmacy,
                                style: const TextStyle(color: Colors.grey)),
                            const SizedBox(height: 20.0),
                            cardPharmacies(
                                AppLocalizations.of(context)!.card_title_pharmacy, context, 70.0),
                            const SizedBox(height: 20.0),
                            Text(AppLocalizations.of(context)!.tourism,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20.0)),
                            Text(AppLocalizations.of(context)!.description_tourism,
                                style: const TextStyle(color: Colors.grey)),
                            const SizedBox(height: 20.0),
                            cardTourism(AppLocalizations.of(context)!.tourism, context, 210.0),
                            const SizedBox(height: 20.0),
                            Text(AppLocalizations.of(context)!.event,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20.0)),
                            Text(AppLocalizations.of(context)!.event_description,
                                style: const TextStyle(color: Colors.grey)),
                            const SizedBox(height: 20.0),
                            swiperEvent(section, context),
                            const SizedBox(height: 10.0),
                            Text(AppLocalizations.of(context)!.service,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20.0)),
                            Text(AppLocalizations.of(context)!.description_service,
                                style: const TextStyle(color: Colors.grey)),
                            const SizedBox(height: 20.0),
                            cardServices(AppLocalizations.of(context)!.card_title_service,
                                context, 30.0)
                          ],
                        ),
                      ))),
              bottomNavigationBar: bottomNavigation(context, 0),
            )
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
        elevation: 2.0,
        child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const Icon(Icons.local_pharmacy),
                const SizedBox(width: 20.0),
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
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
        elevation: 2.0,
        child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const Icon(Icons.map),
                const SizedBox(width: 20.0),
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
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

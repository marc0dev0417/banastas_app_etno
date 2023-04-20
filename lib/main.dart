import 'dart:async';
import 'package:etno_app/models/FCMToken.dart';
import 'package:etno_app/models/section_details/SectionDetails.dart';
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
import 'package:etno_app/pages/equipment/PageEnseresForm.dart';
import 'package:etno_app/pages/event/PageEvents.dart';
import 'package:etno_app/pages/gallery/PageGallery.dart';
import 'package:etno_app/pages/incident/PageIncidents.dart';
import 'package:etno_app/pages/quiz/PageQuiz.dart';
import 'package:etno_app/provider/locale_provider.dart';
import 'package:etno_app/store/section.dart';
import 'package:etno_app/utils/ConnectionChecker.dart';
import 'package:etno_app/utils/WarningWidgetValueNotifier.dart';
import 'package:etno_app/widgets/appbar_navigation.dart';
import 'package:etno_app/widgets/bottom_navigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart' as Card;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'bloc/color/color_bloc.dart';
import 'firebase_options.dart';
import 'l10n/l10n.dart';
import 'models/Weather/Weather.dart';
import 'package:etno_app/widgets/EventCard.dart';

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
      builder: (context, child) {
        final provider = Provider.of<LocaleProvider>(context);
        return BlocProvider<ColorBloc>(
          create: (context) => ColorBloc(),
          child: MaterialApp(
            theme: ThemeData(useMaterial3: true),
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
          ),
        );
      });
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
  SectionDetails sectionDetails = SectionDetails.empty();
  late TextEditingController controller;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  int bottomIndex = 0;
  final Section section = Section();

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
  }

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  late var timer;

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
    section
        .getSectionDetails('Bolea')
        .then((value) => setState(() => sectionDetails = value));
    section.getCustomLinks('Bolea');

    timer = Timer.periodic(
        const Duration(seconds: 1),
        (Timer t) => setState(() {
              section.getWeather(42.138642896056545, -0.40759873321216106).then(
                  (value) => weather =
                      value); //42.138642896056545, -0.40759873321216106
            }));
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
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

  //HomePage build.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBarCustom(
            context,
            false,
            AppLocalizations.of(context)!.bottom_home,
            Icons.language,
            true,
            () => null,
            null),
        body: SafeArea(
            child: Container(
          color: context.watch<ColorBloc>().state.colorPrimary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              WarningWidgetValueNotifier(),
              Container(
                padding: EdgeInsets.all(16.0),
                child: widgetWeather(context, weather)
              ),
              Container(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Calendario',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 25.0),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        const PageEvents(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero));
                      },
                      child: Text(
                        'Ver todos',
                        style: TextStyle(
                            fontSize: 15.5,
                            color: Colors.orange,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    )
                  ],
                ),
              ),
              slideEvents(context)
            ],
          ),
        )),
        bottomNavigationBar: bottomNavigation(context, 0));
  }
}

//Widget weather
Widget widgetWeather(BuildContext context, Weather weather) {
  return SizedBox(
    height: 120.0,
    width: double.maxFinite,
    child: GestureDetector(
      child: Card.Card(
          color: Color.fromRGBO(210, 210, 210, 1),
          elevation: 2.0,
          child: Container(
            padding: EdgeInsets.only(left: 40, right: 40),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset('assets/bolea_shield.png',
                    width: 100.0, height: 100.0),
                const SizedBox(width: 16.0),
                Column(
                  children: [
                    weather.currentWeather?.temperature! == null
                        ? Container(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: const SizedBox(
                                width: 15.0,
                                height: 15.0,
                                child: CircularProgressIndicator(
                                    color: Colors.white)),
                          )
                        : Container(
                            padding: EdgeInsets.only(top: 16.0),
                            child: Column(
                              children: [
                                Text(
                                    '${weather.currentWeather?.temperature!}ºC',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30.0,
                                        color: Colors.black)),
                                const Text('Bolea',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 25.0,
                                        color: Colors.black,)),
                              ],
                            ),
                          )
                  ],
                )
              ],
            ),
          )),
    ),
  );
}

//Slider of events
Widget slideEvents(BuildContext context) {
  return Container(
    padding: EdgeInsets.only(top: 16.0, left: 16.0, bottom: 16.0),
    height: 120,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
          width: 220,
          child: Card.Card(
            color: Colors.orange,
            child: Center(child: Text('Lunes')),
          )
        ),
        Container(
            width: 100,
            child: Card.Card(
              color: Colors.orange,
              child: Center(child: Text('Lunes')),
            )
        ),
        Container(
            width: 100,
            child: Card.Card(
              color: Colors.orange,
              child: Center(child: Text('Lunes')),
            )
        ),
        Container(
            width: 100,
            child: Card.Card(
              color: Colors.orange,
              child: Center(child: Text('Lunes')),
            )
        ),
        Container(
            width: 100,
            child: Card.Card(
              color: Colors.orange,
              elevation: 5.0,
              child: Center(child: Text('Lunes')),
            )
        ),
        Container(
            width: 100,
            child: Card.Card(
              color: Colors.orange,
              elevation: 5.0,
              child: Center(child: Text('Lunes')),
            )
        ),
        Container(
            width: 100,
            child: Card.Card(
              color: Colors.orange,
              elevation: 5.0,
              child: Center(child: Text('Lunes')),
            )
        ),
      ],
    ),
  );
}

String getSectionText(String sectionText, BuildContext context) {
  switch (sectionText) {
    case 'Eventos':
      return AppLocalizations.of(context)!.section_event;
    case 'Turismo':
      return AppLocalizations.of(context)!.section_tourism;
    case 'Farmacias':
      return AppLocalizations.of(context)!.section_pharmacy;
    case 'Servicios':
      return AppLocalizations.of(context)!.section_service;
    case 'Noticias':
      return AppLocalizations.of(context)!.section_news;
    case 'Bandos':
      return AppLocalizations.of(context)!.section_bando;
    case 'Anuncios':
      return AppLocalizations.of(context)!.section_ad;
    case 'Galería':
      return AppLocalizations.of(context)!.section_gallery;
    case 'Defunciones':
      return AppLocalizations.of(context)!.section_death;
    case 'Enlaces':
      return AppLocalizations.of(context)!.section_link;
    case 'Patrocinadores':
      return AppLocalizations.of(context)!.section_sponsor;
    case 'Incidentes':
      return AppLocalizations.of(context)!.section_incident;
    case 'Reservas':
      return AppLocalizations.of(context)!.section_booking;
    case 'Incidentes':
      return AppLocalizations.of(context)!.section_incident;
    case 'Retirada de Enseres':
      return AppLocalizations.of(context)!.section_trash;
    case 'Yo decido':
      return AppLocalizations.of(context)!.section_quiz;
    default:
      return sectionText;
  }
}

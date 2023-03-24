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
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart' as Card;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
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
      builder: (context, child) {
        final provider = Provider.of<LocaleProvider>(context);
        return MaterialApp(
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
  Future<void> launchInBrowser(Uri url) async{
    if(!await launchUrl(
        url,
        mode: LaunchMode.externalApplication
    )){
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
          section.getWeather(42.138642896056545, -0.40759873321216106).then((value) => weather = value);  //42.138642896056545, -0.40759873321216106
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarCustom(AppLocalizations.of(context)!.bottom_home,
          Icons.language, () => null, null),
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
                    color: Colors.redAccent,
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
                                  : Text('${weather.currentWeather?.temperature!}ºC',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30.0,
                                          color: Colors.white
                                      )),

                              const Text('Bolea',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18.0,
                                      color: Colors.white
                                  )),
                            ],
                          )
                        ],
                      ),
                    )),
              ),
            ),
            Expanded(
                child: Observer(
                    builder: (context) => GridView.count(
                        crossAxisCount: 2,
                        children: section.getSections
                            .map((e) => GestureDetector(
                                  onTap: () {
                                    switch (e.title) {
                                      case 'Eventos':
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation1,
                                                        animation2) =>
                                                    const PageEvents(),
                                                transitionDuration:
                                                    Duration.zero,
                                                reverseTransitionDuration:
                                                    Duration.zero));
                                        break;
                                      case 'Turismo':
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation1,
                                                        animation2) =>
                                                    const PageTourism(),
                                                transitionDuration:
                                                    Duration.zero,
                                                reverseTransitionDuration:
                                                    Duration.zero));
                                        break;
                                      case 'Farmacias':
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation1,
                                                        animation2) =>
                                                    const PagePharmacies(),
                                                transitionDuration:
                                                    Duration.zero,
                                                reverseTransitionDuration:
                                                    Duration.zero));
                                        break;
                                      case 'Retirada de Enseres':
                                        Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => const PageEnseres()));
                                        break;
                                      case 'Anuncios':
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation1,
                                                        animation2) =>
                                                    const PageAd(),
                                                transitionDuration:
                                                    Duration.zero,
                                                reverseTransitionDuration:
                                                    Duration.zero));
                                        break;
                                      case 'Noticias':
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation1,
                                                        animation2) =>
                                                    const PageNews(),
                                                transitionDuration:
                                                    Duration.zero,
                                                reverseTransitionDuration:
                                                    Duration.zero));
                                        break;
                                      case 'Galería':
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation1,
                                                        animation2) =>
                                                    const PageGallery(),
                                                transitionDuration:
                                                    Duration.zero,
                                                reverseTransitionDuration:
                                                    Duration.zero));
                                        break;
                                      case 'Enlaces':
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation1,
                                                        animation2) =>
                                                    const PageLinks(),
                                                transitionDuration:
                                                    Duration.zero,
                                                reverseTransitionDuration:
                                                    Duration.zero));
                                        break;
                                      case 'Defunciones':
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation1,
                                                        animation2) =>
                                                    const PageDefunctions(),
                                                transitionDuration:
                                                    Duration.zero,
                                                reverseTransitionDuration:
                                                    Duration.zero));
                                        break;
                                      case 'Servicios':
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation1,
                                                        animation2) =>
                                                    const PageServices(),
                                                transitionDuration:
                                                    Duration.zero,
                                                reverseTransitionDuration:
                                                    Duration.zero));
                                        break;
                                      case 'Patrocinadores':
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation1,
                                                        animation2) =>
                                                    const PageSponsors(),
                                                transitionDuration:
                                                    Duration.zero,
                                                reverseTransitionDuration:
                                                    Duration.zero));
                                        break;
                                      case 'Bandos':
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation1,
                                                        animation2) =>
                                                    const PageBandos(),
                                                transitionDuration:
                                                    Duration.zero,
                                                reverseTransitionDuration:
                                                    Duration.zero));
                                        break;
                                      case 'Incidentes':
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation1,
                                                        animation2) =>
                                                    const PageIncidents(),
                                                transitionDuration:
                                                    Duration.zero,
                                                reverseTransitionDuration:
                                                    Duration.zero));
                                        break;
                                      case 'Reservas':
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation1,
                                                        animation2) =>
                                                    const PageListReserves(),
                                                transitionDuration:
                                                    Duration.zero,
                                                reverseTransitionDuration:
                                                    Duration.zero));
                                        break;
                                      case 'Yo decido':
                                        Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => const PageQuiz()));
                                        break;
                                      default: launchInBrowser(Uri.parse(e.webUrl!));
                                    }
                                  },
                                  child: Card.Card(
                                    color: Colors.white,
                                      elevation: 2.0,
                                      child: Container(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Image.asset(e.assetImage!,
                                                width: 45.0, height: 45.0),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(e.title!,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15.0)),
                                                renderTextSection(
                                                    e.title!, sectionDetails)
                                              ],
                                            )
                                          ],
                                        ),
                                      )),
                                ))
                            .toList())))
          ],
        ),
      )),
      bottomNavigationBar: bottomNavigation(context, 0)
    );
  }
}

Widget renderTextSection(String sectionName, SectionDetails sectionDetails) {
  switch (sectionName) {
    case 'Eventos':
      return sectionDetails.eventQuantity == null
          ? const SizedBox(
              width: 10.0, height: 10.0, child: CircularProgressIndicator())
          : Text('${sectionDetails.eventQuantity} eventos',
              style: const TextStyle(color: Colors.blue, fontSize: 10.0));
    case 'Turismo':
      return sectionDetails.tourismQuantity == null
          ? const SizedBox(
              width: 10.0, height: 10.0, child: CircularProgressIndicator())
          : Text('${sectionDetails.tourismQuantity} lugares turisticos',
              style: const TextStyle(color: Colors.blue, fontSize: 10.0));
    case 'Farmacias':
      return sectionDetails.pharmacyQuantity == null
          ? const SizedBox(
              width: 10.0, height: 10.0, child: CircularProgressIndicator())
          : Text('${sectionDetails.pharmacyQuantity} farmacias',
              style: const TextStyle(color: Colors.blue, fontSize: 10.0));
    case 'Anuncios':
      return sectionDetails.adQuantity == null
          ? const SizedBox(
              width: 10.0, height: 10.0, child: CircularProgressIndicator())
          : Text('${sectionDetails.adQuantity} anuncios',
              style: const TextStyle(color: Colors.blue, fontSize: 10.0));
    case 'Noticias':
      return sectionDetails.newsQuantity == null
          ? const SizedBox(
              width: 10.0, height: 10.0, child: CircularProgressIndicator())
          : Text('${sectionDetails.newsQuantity} noticias',
              style: const TextStyle(color: Colors.blue, fontSize: 10.0));
    case 'Galería':
      return sectionDetails.galleryQuantity == null
          ? const SizedBox(
              width: 10.0, height: 10.0, child: CircularProgressIndicator())
          : Text('${sectionDetails.galleryQuantity} photos',
              style: const TextStyle(color: Colors.blue, fontSize: 10.0));
    case 'Enlaces':
      return sectionDetails.linkQuantity == null
          ? const SizedBox(
              width: 10.0, height: 10.0, child: CircularProgressIndicator())
          : Text('${sectionDetails.linkQuantity} enlaces',
              style: const TextStyle(color: Colors.blue, fontSize: 10.0));
    case 'Defunciones':
      return sectionDetails.deathQuantity == null
          ? const SizedBox(
              width: 10.0, height: 10.0, child: CircularProgressIndicator())
          : Text('${sectionDetails.deathQuantity} defunciones',
              style: const TextStyle(color: Colors.blue, fontSize: 10.0));
    case 'Servicios':
      return sectionDetails.serviceQuantity == null
          ? const SizedBox(
              width: 10.0, height: 10.0, child: CircularProgressIndicator())
          : Text('${sectionDetails.serviceQuantity} servicios',
              style: const TextStyle(color: Colors.blue, fontSize: 10.0));
    case 'Patrocinadores':
      return sectionDetails.sponsorQuantity == null
          ? const SizedBox(
              width: 10.0, height: 10.0, child: CircularProgressIndicator())
          : Text('${sectionDetails.sponsorQuantity} patrocinadores',
              style: const TextStyle(color: Colors.blue, fontSize: 10.0));
    case 'Bandos':
      return sectionDetails.bandoQuantity == null
          ? const SizedBox(
              width: 10.0, height: 10.0, child: CircularProgressIndicator())
          : Text('${sectionDetails.bandoQuantity} bandos',
              style: const TextStyle(color: Colors.blue, fontSize: 10.0));
    case 'Incidentes':
      return sectionDetails.incidentQuantity == null
          ? const SizedBox(
              width: 10.0, height: 10.0, child: CircularProgressIndicator())
          : Text('${sectionDetails.incidentQuantity} incidentes',
              style: const TextStyle(color: Colors.blue, fontSize: 10.0));
    case 'Reservas':
      return sectionDetails.reserveQuantity == null
          ? const SizedBox(
              width: 10.0, height: 10.0, child: CircularProgressIndicator())
          : Text('${sectionDetails.reserveQuantity} reservas',
              style: const TextStyle(color: Colors.blue, fontSize: 10.0));
    case 'Retirada de Enseres':
      return const Text('Enviar aviso de enser',
          style: TextStyle(color: Colors.blue, fontSize: 10.0));

    case 'Yo decido':
      return const Text('Encuesta', style: TextStyle(color: Colors.blue, fontSize: 10.0));
    default:
      return const Text('Link Personalizado', style: TextStyle(color: Colors.blue, fontSize: 10.0));
  }
}
import 'dart:async';
import 'package:etno_app/bloc/language/language_bloc.dart';
import 'package:etno_app/bloc/widget_bloc/widget_section_bloc.dart';
import 'package:etno_app/models/Bandos.dart';
import 'package:etno_app/models/Event.dart';
import 'package:etno_app/models/FCMToken.dart';
import 'package:etno_app/models/section_details/SectionDetails.dart';
import 'package:etno_app/models/widget_button/WidgetButton.dart';
import 'package:etno_app/pages/PageAd.dart';
import 'package:etno_app/pages/PageBandos.dart';
import 'package:etno_app/pages/PageDefunctions.dart';
import 'package:etno_app/pages/PageLinks.dart';
import 'package:etno_app/pages/PageListReserves.dart';
import 'package:etno_app/pages/PageNews.dart';
import 'package:etno_app/pages/PagePharmacies.dart';
import 'package:etno_app/pages/PageReserve.dart';
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
import 'package:etno_app/widgets/DropDownLanguage.dart';
import 'package:etno_app/widgets/appbar_navigation.dart';
import 'package:etno_app/widgets/bottom_navigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart' as Card;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'bloc/color/color_bloc.dart';
import 'firebase_options.dart';
import 'l10n/l10n.dart';
import 'models/Weather/Weather.dart';
import 'package:flutter/widgets.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
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
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext  context) =>
      ChangeNotifierProvider(
          create: (context) => LocaleProvider(),
          builder: (context, child) {
           // final provider = Provider.of<LocaleProvider>(context);
            return MultiBlocProvider(
              providers: [
                BlocProvider<ColorBloc>(
                  create: (context) => ColorBloc(),
                ),
                BlocProvider<WidgetSectionBloc>(
                  create: (context) => WidgetSectionBloc(),
                ),
                BlocProvider<LanguageBloc>(
                  create: (context) => LanguageBloc(),
                ),
              ],
              child: Builder(
                builder: (BuildContext context) {
                 return MaterialApp(
                    theme: ThemeData(
                        useMaterial3: true, dividerColor: Colors.transparent),
                    locale: getLocaleLanguage(context.watch<LanguageBloc>().state.languageCode),
                    supportedLocales: L10n.all,
                    title: 'Etno App',
                    home: Home(),
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate
                    ],
                  );
                },
              )
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
  WidgetButton sectionState = WidgetButton();
  List<WidgetButton> section_list = [];
  int indexSection = 0;

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();
    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    section.getAllBandosByLocality('Bolea');
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
    section.getAllBandosByLocality('Bolea');
    setupInteractedMessage();
    messaging
        .getToken()
        .then((value) => section.saveFcmToken(FCMToken('Bolea', value)));

    super.initState();
    section
        .getSectionDetails('Bolea')
        .then((value) => setState(() => sectionDetails = value));
    section.getCustomLinks('Bolea');

    timer = Timer.periodic(
        const Duration(seconds: 1),
            (Timer t) =>
            setState(() {
              section.getWeather(42.138642896056545, -0.40759873321216106).then(
                      (value) =>
                  weather =
                      value); //42.138642896056545, -0.40759873321216106
            }));
  }

  @override
  void didChangeDependencies() {
    setState(() {
      section_list.addAll([
          WidgetButton(sectionName: context.watch<WidgetSectionBloc>().state.sectionNameOne, index: 1),
          WidgetButton(sectionName: context.watch<WidgetSectionBloc>().state.sectionNameTwo, index: 2),
          WidgetButton(sectionName: context.watch<WidgetSectionBloc>().state.sectionNameThree, index: 3),
          WidgetButton(sectionName: context.watch<WidgetSectionBloc>().state.sectionNameFour, index: 4),

      ].toSet());
    });
    super.didChangeDependencies();
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
            Text('No hay conexión a Internet') //Esto hay que traducirlo
          ],
        ));
  }

  Widget returnElevatedButton(BuildContext context, WidgetButton section) {
    return ElevatedButton(
        onPressed: () {
          returnFunctionNavigate(section.sectionName!, context).call();
        },
        onLongPress: () {
          setState(() {
            sectionState.sectionName = section.sectionName;
            indexSection = section.index!;
          });
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(AppLocalizations.of(context)!.select_option),
                content: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.5
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.celebration),
                          title: Text(getSectionText('Eventos', context)),
                          onTap: () {
                            setState(() {
                              section.sectionName = 'Eventos';
                              context.read<WidgetSectionBloc>().add(FilterWidgetSection(buttonIndex: indexSection, sectionName: 'Eventos'));
                            });
                              Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.map),
                          title: Text(getSectionText('Turismo', context)),
                          onTap: () {
                            setState(() {
                              section.sectionName = 'Turismo';
                              context.read<WidgetSectionBloc>().add(FilterWidgetSection(buttonIndex: indexSection, sectionName: 'Turismo'));
                            });
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                            leading: Icon(Icons.medication),
                            title: Text(getSectionText('Farmacias', context)),
                            onTap: () {
                              setState(() {
                                section.sectionName = 'Farmacias';
                                context.read<WidgetSectionBloc>().add(FilterWidgetSection(buttonIndex: indexSection, sectionName: 'Farmacias'));
                              });
                              Navigator.pop(context);
                            }
                        ),
                        ListTile(
                            leading: Icon(Icons.medical_information),
                            title: Text(getSectionText('Servicios', context)),
                            onTap: () {
                              setState(() {
                                section.sectionName = 'Servicios';
                                context.read<WidgetSectionBloc>().add(FilterWidgetSection(buttonIndex: indexSection, sectionName: 'Servicios'));
                              });
                              Navigator.pop(context);
                            }
                        ),
                        ListTile(
                            leading: Icon(Icons.newspaper),
                            title:Text(getSectionText('Noticias', context)),
                            onTap: () {
                              setState(() {
                                section.sectionName = 'Noticias';
                                context.read<WidgetSectionBloc>().add(FilterWidgetSection(buttonIndex: indexSection, sectionName: 'Noticias'));
                              });
                              Navigator.pop(context);
                            }
                        ),
                        ListTile(
                            leading: Icon(Icons.campaign),
                            title: Text(getSectionText('Bandos', context)),
                            onTap: () {
                              setState(() {
                                section.sectionName = 'Bandos';
                                context.read<WidgetSectionBloc>().add(FilterWidgetSection(buttonIndex: indexSection, sectionName: 'Bandos'));
                              });
                              Navigator.pop(context);
                            }
                        ),
                        ListTile(
                            leading: Icon(Icons.tab),
                            title: Text(getSectionText('Anuncios', context)),
                            onTap: () {
                              setState(() {
                                section.sectionName = 'Anuncios';
                                context.read<WidgetSectionBloc>().add(FilterWidgetSection(buttonIndex: indexSection, sectionName: 'Anuncios'));
                              });
                              Navigator.pop(context);
                            }
                        ),
                        ListTile(
                            leading: Icon(Icons.perm_media),
                            title: Text(getSectionText('Gslería', context)),
                            onTap: () {
                              setState(() {
                                section.sectionName = 'Galería';
                                context.read<WidgetSectionBloc>().add(FilterWidgetSection(buttonIndex: indexSection, sectionName: 'Galería'));
                              });
                              Navigator.pop(context);
                            }
                        ),
                        ListTile(
                            leading: Icon(Icons.heart_broken_sharp),
                            title: Text(getSectionText('Defunciones', context)),
                            onTap: () {
                              setState(() {
                                section.sectionName = 'Defunciones';
                                context.read<WidgetSectionBloc>().add(FilterWidgetSection(buttonIndex: indexSection, sectionName: 'Defunciones'));
                              });
                              Navigator.pop(context);
                            }
                        ),
                        ListTile(
                            leading: Icon(Icons.link),
                            title: Text(getSectionText('Enlaces', context)),
                            onTap: () {
                              setState(() {
                                section.sectionName = 'Enlaces';
                                context.read<WidgetSectionBloc>().add(FilterWidgetSection(buttonIndex: indexSection, sectionName: 'Enlaces'));
                              });
                              Navigator.pop(context);
                            }
                        ),
                        ListTile(
                            leading: Icon(Icons.handshake),
                            title: Text(getSectionText('Patrocinadores', context)),
                            onTap: () {
                              setState(() {
                                section.sectionName = 'Patrocinadores';
                                context.read<WidgetSectionBloc>().add(FilterWidgetSection(buttonIndex: indexSection, sectionName: 'Patrocinadores'));
                              });
                              Navigator.pop(context);
                            }
                        ),
                        ListTile(
                            leading: Icon(Icons.dangerous),
                            title: Text(getSectionText('Incidentes', context)),
                            onTap: () {
                              setState(() {
                                section.sectionName = 'Incidentes';
                                context.read<WidgetSectionBloc>().add(FilterWidgetSection(buttonIndex: indexSection, sectionName: 'Incidentes'));
                              });
                              Navigator.pop(context);
                            }
                        ),
                        ListTile(
                            leading: Icon(Icons.beenhere),
                            title: Text(getSectionText('Reservas', context)),
                            onTap: () {
                              setState(() {
                                section.sectionName = 'Reservas';
                                context.read<WidgetSectionBloc>().add(FilterWidgetSection(buttonIndex: indexSection, sectionName: 'Reservas'));
                              });
                              Navigator.pop(context);
                            }
                        ),
                        ListTile(
                            leading: Icon(Icons.recycling),
                            title: Text(getSectionText('Enseres', context)),
                            onTap: () {
                              setState(() {
                                section.sectionName = 'Enseres';
                                context.read<WidgetSectionBloc>().add(FilterWidgetSection(buttonIndex: indexSection, sectionName: 'Enseres'));
                              });
                              Navigator.pop(context);
                            }
                        ),
                        ListTile(
                            leading: Icon(Icons.quiz),
                            title: Text(getSectionText('Yo decido', context)),
                            onTap: () {
                              setState(() {
                                section.sectionName = 'Yo decido';
                                context.read<WidgetSectionBloc>().add(FilterWidgetSection(buttonIndex: indexSection, sectionName: 'Yo decido'));
                              });
                              Navigator.pop(context);
                            }
                        )
                      ],
                    ),
                  ),
                )
              );
            },
          );
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromRGBO(240, 240, 240, 1),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0))),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(returnIconSection(section.sectionName!),
              size: 80.0,
              color: context.watch<ColorBloc>().state.colorDark),
              Text(
                  getSectionText(section.sectionName!, context),//section.sectionName!,
                  textAlign: TextAlign.center,
                 style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: context.watch<ColorBloc>().state.colorDark
                )
              ),
            ],
          ),
        )
    );
  }

  Widget specialButtons(BuildContext context) {
    return Container(
      height: 350,
        padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 16.0, bottom: 16.0),
        alignment: Alignment.center,
        child: GridView.count(
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            children: section_list.map((e) => returnElevatedButton(context, e)).toList()
        ),
    );
  }

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
              color: Colors.white,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  WarningWidgetValueNotifier(),
                  Container(
                      padding: EdgeInsets.all(16.0),
                      child: widgetWeather(context, weather)),
                  Container(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.calendar,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 25.0),
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
                            AppLocalizations.of(context)!.see_all,
                            style: TextStyle(
                                fontSize: 15.5,
                                color: Color.fromRGBO(244, 144, 20, 1),
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  ),
                  slideEvents(context, section),
                  specialButtons(context),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(16.0),
                    child: Text(AppLocalizations.of(context)!.notifications,
                        style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 25.0)),
                  ),
                  slideNotifications(context, section)
                ],
              )),
        ),
        bottomNavigationBar: bottomNavigation(context, 0));
  }
}

//Widget weather
Widget widgetWeather(BuildContext context, Weather weather) {
  return SizedBox(
    height: 150.0,
    width: double.maxFinite,
    child: GestureDetector(
      child: Card.Card(
          color: Color.fromRGBO(240, 240, 240, 1),
          elevation: 0.0,
          child: Container(
            padding: EdgeInsets.only(left: 40, right: 40),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset('assets/bolea_shield.png',
                    width: 120.0, height: 120.0),
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
                      padding: EdgeInsets.only(top: 30.0),
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
                                color: Colors.black,
                              )),
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

//slide notifications
Widget slideNotifications(BuildContext context, Section section) {
  return Container(
    margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 16.0),
    child: Observer(builder: (context) {
      if (section.getBandos.isNotEmpty){
       return ListView.builder(
            shrinkWrap: true,
            itemCount: section.getBandos.length > 7 ? 7 : section.getBandos.length,
            itemBuilder: (context, index) {
              return cardBandos(section.getBandos[index]);
            });
      } else {
        return Center(child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Icon(Icons.sms_failed, size: 35.0),
          SizedBox(width: 8.0),
          Text(AppLocalizations.of(context)!.no_band, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0))
        ]));
      }
    })
  );
}

Widget cardBandos(Bandos bando){
  return Container(
      decoration:
      BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
      child: Card.Card(
        color: Color.fromRGBO(253, 178, 108, 1),
        child: ExpansionTile(
          backgroundColor: Colors.transparent,
          iconColor: Colors.black,
          collapsedIconColor: Colors.black,
          childrenPadding: const EdgeInsets.symmetric(
              vertical: 10.0, horizontal: 20.0),
          expandedCrossAxisAlignment: CrossAxisAlignment.end,
          title: Text(bando.title!, style: const TextStyle(
              color: Colors.black
          )),
          children: [
            Text(bando.description!, style: const TextStyle(
                color: Colors.black
            ))
          ],
        ),
      )
  );
}


//Slider of events
Widget slideEvents(BuildContext context, Section section) {
  return Container(
    padding: EdgeInsets.only(top: 16.0, left: 16.0, bottom: 16.0),
    height: 120,
    child: Observer(builder: (context){
      if (section.getListEvent.isNotEmpty){
       return ListView(scrollDirection: Axis.horizontal, children: section.getListEvent.map((e) => cardEventsCalendar(context, e)).toList());
      }else {
       return Center(child: Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Icon(Icons.event_busy, size: 35.0),
           SizedBox(width: 8.0),
           Text(AppLocalizations.of(context)!.events_empty, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0))
         ],
       ));
      }
    }
  ));
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

Widget cardEventsCalendar(BuildContext context, Event event) {
  return Container(
      alignment: Alignment.center,
      decoration:
      BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
      width: 260,
      child: Card.Card(
        color: Color.fromRGBO(253, 178, 108, 1),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  padding: EdgeInsets.only(left: 16.0, top: 10.0),
                  width: 70.0,
                  child: Column(children: [
                    Text(event.startDate!.substring(8),
                      style: TextStyle(fontSize: 25.0),
                    ),
                    Text(returnDate(context, event),
                        style: TextStyle(
                            fontSize: 18.0, color: Colors.white))
                  ])),
              VerticalDivider(
                color: Colors.deepOrange,
                thickness: 1.0,
                width: 1.0,
                indent: 16.0,
                endIndent: 16.0,
              ),
              Container(
                  padding:
                  EdgeInsets.only(right: 5.0, top: 5.0, bottom: 5.0),
                  width: 170.0,
                  child: Text(
                    event.title!,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ))
            ]),
      ));
}

String returnDate(BuildContext context, Event e){
  switch(e.startDate?.substring(5, 7)){
    case '01': return AppLocalizations.of(context)!.january;
    case '02': return AppLocalizations.of(context)!.february;
    case '03': return AppLocalizations.of(context)!.march;
    case '04': return AppLocalizations.of(context)!.april;
    case '05': return AppLocalizations.of(context)!.may;
    case '06': return AppLocalizations.of(context)!.june;
    case '07': return AppLocalizations.of(context)!.july;
    case '08': return AppLocalizations.of(context)!.august;
    case '09': return AppLocalizations.of(context)!.september;
    case '10': return AppLocalizations.of(context)!.october;
    case '11': return AppLocalizations.of(context)!.november;
    case '12': return AppLocalizations.of(context)!.december;
    default: return '';
  }
}

IconData returnIconSection(String section) {
  switch (section) {
    case 'Eventos':
      return Icons.celebration;
    case 'Turismo':
      return Icons.map;
    case 'Farmacias':
      return Icons.medication;
    case 'Servicios':
      return Icons.medical_information;
    case 'Noticias':
      return Icons.newspaper;
    case 'Bandos':
      return Icons.campaign;
    case 'Anuncios':
      return Icons.tab;
    case 'Galería':
      return Icons.perm_media;
    case 'Defunciones':
      return Icons.heart_broken_sharp;
    case 'Enlaces':
      return Icons.link;
    case 'Patrocinadores':
      return Icons.handshake;
    case 'Incidentes':
      return Icons.dangerous;
    case 'Reservas':
      return Icons.beenhere;
    case 'Enseres':
      return Icons.recycling;
    case 'Yo decido':
      return Icons.quiz;
    default:
      return Icons.disabled_by_default;
  }
}

Function() returnFunctionNavigate(String sectionName, BuildContext context){
  switch(sectionName) {
    case 'Eventos': return () => Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => PageEvents()));
    case 'Turismo': return () => Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => PageTourism()));
    case 'Farmacias': return () => Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => PagePharmacies()));
    case 'Bandos': return () => Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => PageBandos()));
    case 'Servicios': return () => Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => PageServices()));
    case 'Noticias': return () => Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => PageNews(pageContext: context)));
    case 'Anuncios': return () => Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => PageAd()));
    case 'Galería': return () => Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => PageGallery()));
    case 'Defunciones': return () => Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => PageDefunctions()));
    case 'Enlaces': return () => Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => PageLinks()));
    case 'Patrocinadores': return () => Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => PageSponsors()));
    case 'Incidentes': return () => Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => PageIncidents()));
    case 'Reservas': return () => Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => PageListReserves()));
    case 'Enseres': return () => Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => PageEnseres()));
    case 'Yo decido': return () => Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => PageQuiz()));
    default: return () => print('Is not working');
  }
}
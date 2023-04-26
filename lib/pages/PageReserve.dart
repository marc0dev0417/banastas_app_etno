import 'package:etno_app/models/ReserveUser.dart';
import 'package:etno_app/store/section.dart';
import 'package:etno_app/widgets/appbar_navigation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';
import '../bloc/color/color_bloc.dart';
import '../models/Reserve.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class PageReserve extends StatefulWidget {
  const PageReserve({super.key, required this.reserve});
  final Reserve reserve;
  @override
  State<StatefulWidget> createState() {
    return PageState();
  }
}
class PageState extends State<PageReserve> {
  String data = '';
  final Section section = Section();
  Reserve get props => widget.reserve;
  bool? isReserved = false;
  @override
  void initState() {
    setState(() {
      isReserved = props.isReserved;
    });
    super.initState();
  }
  Future<void> launchInBrowser(Uri url) async{
    if(!await launchUrl(
        url,
        mode: LaunchMode.externalApplication
    )){
      throw Exception('Could not launch $url');
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: context.watch<ColorBloc>().state.colorPrimary), dialogTheme: const DialogTheme(backgroundColor: Colors.white)),
      home: Scaffold(
        floatingActionButton:
        Container(
          width: 200.0,
          child: Visibility(
            visible:  props.reserveUsers!.isNotEmpty ? false : true,
            child: Container(
              width: 600.0,
              child: FloatingActionButton(
                backgroundColor: isReserved! ? Colors.grey : context.watch<ColorBloc>().state.colorPrimary,
                onPressed: () {
                  if (props.reserveUsers!.isEmpty){
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        backgroundColor: Colors.white,
                        title: Column(
                          children: [Text(AppLocalizations.of(context)!.intro_email_phone, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)), Text(AppLocalizations.of(context)!.confirm_reserve, textAlign: TextAlign.center, style: TextStyle(fontSize: 10.0))],
                        ),
                        content: TextFormField(
                          onChanged: (value) => setState(() {
                            data = value;
                          }),
                          decoration: const InputDecoration(fillColor: Colors.white),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, AppLocalizations.of(context)!.cancel),
                            child: Text(AppLocalizations.of(context)!.cancel),
                          ),
                          TextButton(
                            style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(context.watch<ColorBloc>().state.colorPrimary)),
                            onPressed: () {
                              if (data != ''){
                                FirebaseMessaging.instance.getToken().then((fcmToken) => section.sendReserve('Bolea', props.name!, ReserveUser(fcmToken,data, props.place, props.isReserved, props.description, props.phone, props.place?.latitude, props.place?.longitude, props.date, props.reserveSchedules)));
                                Navigator.pop((context));
                              } else {
                                Fluttertoast.showToast(
                                    msg: AppLocalizations.of(context)!.toast_error,
                                    toastLength: Toast.LENGTH_SHORT,
                                    fontSize: 12,
                                    textColor: Colors.white,
                                    backgroundColor: Colors.red
                                );
                              }
                            },
                            child: Text(AppLocalizations.of(context)!.subscribe, style: TextStyle(color: context.watch<ColorBloc>().state.colorSecondary)),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:  [
                    Text(!isReserved! ? AppLocalizations.of(context)!.reserve_now : AppLocalizations.of(context)!.no_reserve, style: const TextStyle(color: Colors.white)),
                    const Icon(Icons.arrow_forward, color: Colors.white)
                  ],
                ),
              ),
            ),
          ),
        ),
        appBar: appBarCustom(context, true, AppLocalizations.of(context)!.section_booking, Icons.language, false, () => null),
        body: SafeArea(
            child: Container(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    props.place?.imageUrl == null ?
                    Container(
                      height: 200.0,
                      decoration: BoxDecoration(image: const DecorationImage( image: AssetImage('assets/reserva.png')), borderRadius: BorderRadius.circular(20.0)),
                    ):
                    Container(
                      width: double.maxFinite,
                      height: 300.0,
                      decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(props.place!.imageUrl!)), borderRadius: BorderRadius.circular(20.0)),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(props.place!.name!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
                        GestureDetector(
                            onTap: () => launchInBrowser(Uri.parse('https://maps.google.com/?daddr=${props.place?.latitude!},${props.place?.longitude!}')),
                            child: Text(AppLocalizations.of(context)!.show_map, style: TextStyle(color: Colors.blue))
                        )
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    ReadMoreText(
                      props.description!,
                      trimLines: 2,
                      colorClickableText: Colors.blue,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: AppLocalizations.of(context)!.read_more,
                      trimExpandedText: AppLocalizations.of(context)!.show_less,
                      moreStyle: const TextStyle(fontSize: 12.0, color: Colors.blue),
                      lessStyle: const TextStyle(fontSize: 12.0, color: Colors.blue),
                    ),
                    const SizedBox(height: 16.0),
                    Text(AppLocalizations.of(context)!.schedule, style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8.0),
                    Text(props.date!),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: props.reserveSchedules!.map((e) => Text(e.date!)).toList()
                    )
                  ],
                )
            )
        ),
      ),
    );
  }
}
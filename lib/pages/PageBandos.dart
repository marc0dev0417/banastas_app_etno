import 'package:etno_app/store/section.dart';
import 'package:etno_app/utils/WarningWidgetValueNotifier.dart';
import 'package:etno_app/widgets/appbar_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../bloc/color/color_bloc.dart';
import '../models/Bandos.dart';
class PageBandos extends StatefulWidget {
  const PageBandos({super.key});
  @override
  State<StatefulWidget> createState() {
    return PageState();
  }
}

class PageState extends State<PageBandos> {
  final Section section = Section();

  @override
  void initState() {
    section.getAllBandosByLocality('Bolea');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBarCustom(
            context,
            true,
            AppLocalizations.of(context)!.section_bando,
            Icons.language,
            false,
                () => null,
            null),
        body: Column(children: [
          const WarningWidgetValueNotifier(),
          Observer(builder: (context) {
            if (section.getBandos.isNotEmpty) {
              return Expanded(
                  child: ListView(
                      shrinkWrap: true,
                      children: section.getBandos
                          .map((e) => carBando(e, context))
                          .toList()));
            } else {
              return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 300.0),
                  child: Column(children: [
                    Text(AppLocalizations.of(context)!.no_band,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Icon(Icons.campaign, size: 50.0)
                  ]));
            }
          })
        ]));
  }
}

Widget carBando(Bandos bandos, BuildContext context) {
  return SizedBox(
    height: 60,
    child: InkWell(
      onTap: () {
        showDialogBandos(context, bandos);
      },
      child: Card(
        color: Colors.white,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Icon(Icons.campaign, color: context.watch<ColorBloc>().state.colorDark),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(bandos.title!,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(bandos.issuedDate!,
                        style:
                        const TextStyle(color: Colors.grey, fontSize: 12.0))
                  ]),
              Icon(Icons.subdirectory_arrow_right, color: context.watch<ColorBloc>().state.colorDark)
            ]),
      ),
    ),
  );
}

showDialogBandos(BuildContext context, Bandos bandos) => showBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    builder: (context) {
      return SafeArea(
          minimum: EdgeInsets.only(bottom: 16.0),
          child: Wrap(
            children: [
              Column(
                children: [
                  Container(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: bandos.imageUrl != null
                          ? Image.network(bandos.imageUrl!, fit: BoxFit.fill)
                          : Icon(Icons.campaign,
                          size: 80.0, color: context.watch<ColorBloc>().state.colorDark)),
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
                                child: Text(bandos.title!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0)),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 15.0),
                                alignment: Alignment.topLeft,
                                child: Text('${bandos.username} · Huesca',
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 10.0)),
                              ),
                              const Divider(),
                              Container(
                                padding:
                                const EdgeInsets.only(left: 15.0, top: 4.0),
                                alignment: Alignment.topLeft,
                                child: Text(AppLocalizations.of(context)!.issued,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0)),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 15.0),
                                alignment: Alignment.topLeft,
                                child: Text(bandos.issuedDate!,
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 10.0)),
                              ),
                              const Divider(),
                              Container(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  alignment: Alignment.topLeft,
                                  child: Text(bandos.description!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11.0)))
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ));
    });
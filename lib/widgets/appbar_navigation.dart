import 'package:etno_app/bloc/color/color_bloc.dart';
import 'package:etno_app/pages/event/PageEvents.dart';
import 'package:etno_app/widgets/DropDownLanguage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

PreferredSizeWidget appBarCustom(
    BuildContext context,
    bool isVisibleBack,
    String title,
    IconData iconData,
    bool isVisibleLanguage,
    Function() action,
    [tabs]
    ){
  return AppBar(
    backgroundColor: context.watch<ColorBloc>().state.colorPrimary,
    automaticallyImplyLeading: false,
    leading: Visibility(
      visible: isVisibleBack,
      child: GestureDetector(
        onTap: () {
          if (title == AppLocalizations.of(context)!.subscribe){
            Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => PageEvents()));
          } else {
            Navigator.pop(context);
          }
        },
        child: Icon(Icons.chevron_left, color: context.watch<ColorBloc>().state.colorSecondary),
      ),
    ),
    title: Text(title, style: TextStyle(color: context.watch<ColorBloc>().state.colorSecondary)),
    actions:  [
      Visibility(
        visible: isVisibleLanguage,
          child: LanguagePickerWidget()
      )
    ],
  );
}

PreferredSizeWidget appBarNews(
    BuildContext context,
    String title,
    IconData iconData,
    Function() action,
    List<String> tabs
    ){

  return AppBar(
      backgroundColor: context.watch<ColorBloc>().state.colorPrimary,
      automaticallyImplyLeading: false,
      title: Text(title, style: TextStyle(color: context.watch<ColorBloc>().state.colorSecondary)),
    bottom: TabBar(
      labelColor: Colors.white,
      indicatorColor: Colors.white,
      unselectedLabelColor: Colors.black,
      isScrollable: true,
      tabs: [ for (final tab in tabs) Tab(text: tab)]
    ),
  );
}
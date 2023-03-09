import 'package:etno_app/pages/PageMenuSections.dart';
import 'package:etno_app/pages/PageNews.dart';
import 'package:etno_app/pages/event/PageEvents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../main.dart';

Widget bottomNavigation(BuildContext context, int bottomIndex){
  return BottomNavigationBar(
    currentIndex: bottomIndex,
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.white,
    selectedItemColor: Colors.red,
    unselectedItemColor: Colors.black,
    selectedFontSize: 10,
    unselectedFontSize: 12,
    onTap: (value) {
        bottomIndex = value;

      switch(value){
        case 0 : Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) =>
        const Home(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero
        ));
        break;
        case 1 : Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) =>
        const PageEvents(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero
        ));
        break;
        case 2 : Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) =>
        const PageNews(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero
        ));
        break;
        case 3 : Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) =>
        const PageMenuSections(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero));
        break;
      }
    },
    items:  [
      BottomNavigationBarItem(
        label: AppLocalizations.of(context)!.bottom_home,
        icon: const Icon(Icons.home),
      ),
      BottomNavigationBarItem(
        label: AppLocalizations.of(context)!.bottom_event,
        icon: const Icon(Icons.celebration),
      ),
      BottomNavigationBarItem(
        label: AppLocalizations.of(context)!.bottom_news,
        icon: const Icon(Icons.newspaper),
      ),
      BottomNavigationBarItem(
        label: AppLocalizations.of(context)!.bottom_menu,
        icon: const Icon(Icons.library_books),
      ),
    ],
  );
}
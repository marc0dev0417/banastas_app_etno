import 'package:etno_app/pages/PageMenuSections.dart';
import 'package:flutter/material.dart';

import '../main.dart';

Widget bottomNavigation(BuildContext context, int bottomIndex){
  return BottomNavigationBar(
    currentIndex: bottomIndex,
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.red,
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.white,
    selectedFontSize: 10,
    unselectedFontSize: 12,
    onTap: (value) {
        bottomIndex = value;

      switch(value){
        case 0 : Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) =>
        const Home(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero
        ));
        break;
        case 3 : Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) =>
        const PageMenuSections(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero));
        break;
      }
    },
    items: const [
      BottomNavigationBarItem(
        label: 'Inicio',
        icon: Icon(Icons.home),
      ),
      BottomNavigationBarItem(
        label: 'Eventos',
        icon: Icon(Icons.celebration),
      ),
      BottomNavigationBarItem(
        label: 'Noticias',
        icon: Icon(Icons.newspaper),
      ),
      BottomNavigationBarItem(
        label: 'Menú',
        icon: Icon(Icons.library_books),
      ),
    ],
  );
}
import 'package:etno_app/pages/PageAd.dart';
import 'package:etno_app/pages/PageBandos.dart';
import 'package:etno_app/pages/PageDefunctions.dart';
import 'package:etno_app/pages/incident/PageIncidents.dart';
import 'package:etno_app/pages/PageLinks.dart';
import 'package:etno_app/pages/PageNews.dart';
import 'package:etno_app/pages/PagePharmacies.dart';
import 'package:etno_app/pages/PageServices.dart';
import 'package:etno_app/pages/PageSponsors.dart';
import 'package:etno_app/pages/PageTourism.dart';
import 'package:etno_app/pages/event/PageEvents.dart';
import 'package:etno_app/pages/gallery/PageGallery.dart';
import 'package:etno_app/store/section.dart';
import 'package:etno_app/widgets/appbar_navigation.dart';
import 'package:etno_app/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class PageMenuSections extends StatefulWidget {
  const PageMenuSections({super.key});

  @override
  State<StatefulWidget> createState() {
      return PageState();
  }
}

class PageState extends State<PageMenuSections> {
  final sectionStore = Section();
  int bottomIndex = 3;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom('Menú', Icons.language, () => print('Internalization in Menu')),
       body: SafeArea(
         child: Container(
           decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/Bolea.png'))),
           padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
           child: Column(
             children: [
               Expanded(child: Observer(builder: (context) => GridView.count(
                   crossAxisCount: 3,
                   children: sectionStore.getSections.map((e) =>
                       Center(
                           child: SizedBox(
                             height: 150,
                             width: 150,
                             child: InkWell(
                               onTap: () {
                                 switch(e.title){
                                   case 'Eventos': Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => const PageEvents(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)); break;
                                   case 'Turismo': Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => const PageTourism(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)); break;
                                   case 'Farmacias': Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => const PagePharmacies(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)); break;
                                   case 'Anuncios': Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => const PageAd(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)); break;
                                   case 'Noticias': Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => const PageNews(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)); break;
                                   case 'Galería': Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => const PageGallery(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)); break;
                                   case 'Enlaces': Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => const PageLinks(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)); break;
                                   case 'Defunciones': Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => const PageDefunctions(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)); break;
                                   case 'Servicios': Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => const PageServices(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)); break;
                                   case 'Patrocinadores': Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => const PageSponsors(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)); break;
                                   case 'Bandos': Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => PageBandos(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)); break;
                                   case 'Incidentes': Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => const PageIncidents(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero)); break;
                                 }
                               },
                               child: Card(
                                 color: Colors.transparent,
                                 elevation: 1.0,
                                 shadowColor: Colors.grey,
                                 child: Center(
                                     child: Column(
                                       mainAxisSize: MainAxisSize.min,
                                       crossAxisAlignment: CrossAxisAlignment.center,
                                       children: [
                                         Icon(e.icon, color: Colors.white),
                                         Text(e.title!, style: const TextStyle( fontWeight: FontWeight.bold, fontSize: 10.0, color: Colors.white))
                                       ],
                                     )
                                 ),
                               ),
                             ),
                           )
                       )
                   ).toList()
               )
               ))
             ],
           )
         ),
       ),
      bottomNavigationBar: bottomNavigation(context, 3)
    );
  }
}
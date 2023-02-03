import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:etno_app/pages/PagePharmacies.dart';
import 'package:etno_app/pages/PageServices.dart';
import 'package:etno_app/pages/PageTourism.dart';
import 'package:etno_app/store/section.dart';
import 'package:etno_app/widgets/home_widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      title: 'Etno App',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}
class HomeState extends State<Home>{
  int bottomIndex = 0;
  final Section section = Section();

  @override
  void initState() {
    section.getAllNewByLocality('Bolea');
    section.getAllEventsByLocality('Bolea');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(10.0),
          children: [
           const Text(
                'Explorar',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
           // const Text('Noticias', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.5)),
            const Text('Noticias sugeridas para ti', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20.0),
            swiperNews(section),

            const SizedBox(height: 20.0),
            const Text('Farmacias', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
            const Text('Encuentras las farmacias de tu localidad', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20.0),
            cardPharmacies('Farmacias de guardia y normal', context, 80.0),
            const SizedBox(height: 20.0),
            const Text('Turismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
            const Text('Turismo más relevante', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20.0),
            cardTourism('Turismo', context, 218.0),
            const SizedBox(height: 20.0),
            const Text('Eventos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
            const Text('Mira los eventos más destacados', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20.0),
            swiperEvent(section),
            const SizedBox(height: 20.0),
            const Text('Servicios', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
            const Text('Servicios más relevante', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20.0),
            cardServices('Los mejores servicios de tu localidad', context, 40.0)
          ],
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF6200EE),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        onTap: (value) {
          setState(() {
            bottomIndex = value;
          });
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
      ),
    );
  }
}

Widget cardPharmacies(String title, BuildContext context, double width){
  return InkWell(
    onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const PagePharmacies())); },
    child: Card(
        child:
        Container(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const Icon(Icons.access_time),
                const SizedBox(width: 20.0),
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: width),
                const Icon(Icons.chevron_right)
              ],
            )
        )
    ),
  );
}

Widget cardTourism(String title, BuildContext context, double width){
  return InkWell(
    onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const PageTourism())); },
    child: Card(
        child:
        Container(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const Icon(Icons.access_time),
                const SizedBox(width: 20.0),
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: width),
                const Icon(Icons.chevron_right)
              ],
            )
        )
    ),
  );
}

Widget cardServices(String title, BuildContext context, double width){
  return InkWell(
    onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const PageServices())); },
    child: Card(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children:  [
            const Icon(Icons.access_time),
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
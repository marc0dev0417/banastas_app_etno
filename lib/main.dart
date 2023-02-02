import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
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
            card('Farmacias de guardia y normal', context, 80.0),
            const SizedBox(height: 20.0),
            const Text('Turismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
            const Text('Turismo más relevante', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20.0),
            card('Turismo', context, 218.0),
            const SizedBox(height: 20.0),
            swiperEvent(section),
          ],
        )
      )
    );
  }
}

Widget card(String title, BuildContext context, double width){
  return Card(
    child:
        Container(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children:  [
              const Icon(Icons.access_time),
              const SizedBox(width: 20.0),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(width: width),
              const Icon(Icons.chevron_right)
            ],
          )
        )
  );
}
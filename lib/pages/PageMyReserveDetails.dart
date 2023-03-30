import 'package:etno_app/widgets/appbar_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/Reserve.dart';

class PageMyReserveDetails extends StatefulWidget {
  const PageMyReserveDetails({super.key, required this.reserve});
  final Reserve reserve;
  @override
  State<StatefulWidget> createState() {
    return PageState();
  }
}
class PageState extends State<PageMyReserveDetails> {
  Reserve get props => widget.reserve;


  Future<void> launchInBrowser(Uri url) async {
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
      title: 'My reserve details',
      home: Scaffold(
        appBar: appBarCustom(context, true, 'Reserva detalles', Icons.language, () => null),
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
                        child: const Text('Mostrar Mapa', style: TextStyle(color: Colors.blue))
                    )
                  ],
                ),
                const SizedBox(height: 16.0),
                ReadMoreText(
                  props.description!,
                  trimLines: 2,
                  colorClickableText: Colors.blue,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Leer Más',
                  trimExpandedText: ' Mostrar menos',
                  moreStyle: const TextStyle(fontSize: 12.0, color: Colors.blue),
                  lessStyle: const TextStyle(fontSize: 12.0, color: Colors.blue),
                ),
                const SizedBox(height: 16.0),
                const Text('Horario:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8.0),
                const Text('9:30 a 13:30 h'),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
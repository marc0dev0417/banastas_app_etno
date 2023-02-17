import 'dart:async';

import 'package:card_swiper/card_swiper.dart';
import 'package:etno_app/models/PharmaciesButton.dart';
import 'package:etno_app/models/Pharmacy.dart';
import 'package:etno_app/store/section.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PagePharmacies extends StatefulWidget{
  const PagePharmacies({super.key});

  @override
  State<StatefulWidget> createState() {
   return PharmaciesState();
  }
}
class PharmaciesState extends State<PagePharmacies>{
  final Section section = Section();
  Set<Marker> listMarker = {  };
  Set<Marker> listMarkerSaved = {  };
  List<PharmaciesButton> pharmaciesButton = [
    PharmaciesButton(Icons.local_pharmacy, Colors.black, 'Todo'),
    PharmaciesButton(Icons.local_pharmacy, Colors.blue, 'Normal'),
    PharmaciesButton(Icons.local_pharmacy, Colors.red, 'Guardia')
  ];

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(42.13639592850662, -0.41057481476933433),
    zoom: 14.4746,
  );

  @override
  void initState() {
      section.getAllPharmaciesByLocality('Bolea').then((value) =>
      value.forEach((element) {
        setState(() {
          listMarker.add(
              Marker(
                onTap: () {
                  showModalBottomSheet(context: context, builder: (context) {
                    return Wrap(
                        children: [
                             Column(
                                children: [
                                  renderImagePharmacy(element),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding:  const EdgeInsets.all(15.0),
                                          alignment: Alignment.topLeft,
                                          child: Column(
                                            children:  [
                                              Container(
                                                padding: const EdgeInsets.only(left: 15.0),
                                                alignment: Alignment.topLeft,
                                                child: Text(element.name!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(left: 15.0),
                                                alignment: Alignment.topLeft,
                                                child:  Text('${element.username!} · Huesca', style: const TextStyle(color: Colors.grey, fontSize: 10.0)),
                                              ),
                                             const Divider(),
                                              Container(
                                                alignment: Alignment.topLeft,
                                                padding: const EdgeInsets.only(top: 5.0, left: 15.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(element.schedule!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
                                                    Text(element.type!, style: TextStyle(fontSize: 15.0, backgroundColor: element.type == 'Normal' ? Colors.blue : Colors.red)
                                                    )
                                                  ],
                                                )
                                              ),
                                              const Divider(),
                                              Container(
                                                  alignment: Alignment.topLeft,
                                                  padding: const EdgeInsets.only(top: 5.0, left: 15.0),
                                                  child: Text(element.description!, style: const TextStyle(color: Colors.grey))
                                              ),
                                            ],
                                          )
                                        ),
                                      ],
                                    )
                                  )
                                ],
                            ),
                    ],
                    );
                  });
                },
                  markerId: MarkerId(element.type!),
                  position: LatLng(element.latitude!, element.longitude!),
                  draggable: true,
                  onDragEnd: (value) {
                  },
                infoWindow: InfoWindow(title: element.name)
              )
          );
          listMarkerSaved = listMarker;
        });
      })
      );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pharmacies',
      home: DefaultTabController(
        initialIndex: 0,
        length: pharmaciesButton.length,
        child: Scaffold(
            body:
            SafeArea(
                child:
                Stack(
                  children: [
                    GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: _kGooglePlex,
                        onMapCreated: (GoogleMapController controller){
                          _controller.complete(controller);
                        },
                        markers: listMarker
                    ),
                         TabBar(
                           indicatorColor: Colors.transparent,
                           isScrollable: true,
                             tabs: [ for (final tab in pharmaciesButton) ElevatedButton(
                                style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.white)),
                                 onPressed: () {
                                   switch(tab.name){
                                     case 'Normal': setState(() {
                                       listMarker = listMarkerSaved;
                                       listMarker = listMarker.where((element) => element.markerId.value == 'Normal').toSet();
                                     });
                                     break;
                                     case 'Guardia': setState(() {
                                       listMarker = listMarkerSaved;
                                       listMarker = listMarker.where((element) => element.markerId.value == 'Guardia').toSet();
                                     });
                                     break;
                                     case 'Todo': setState(() {
                                       listMarker = listMarkerSaved;
                                     });
                                   }
                                 },
                                 child: Row(
                                   children: [
                                     Icon(tab.iconData, color: tab.color),
                                     Text(tab.name!, style: const TextStyle(color: Colors.black))
                                   ]
                                 )
                             )]
                         )
                  ],
                )
            )
        ),
      ),
    );
  }
}

Widget renderImagePharmacy(Pharmacy pharmacy){
  if(pharmacy.imageUrl == null){
    return Image.asset('assets/Loading_icon.gif', height: 200, fit: BoxFit.fill, width: 400);
  }else{
    return Image.network(pharmacy.imageUrl!, fit: BoxFit.fill, height: 200, width: 300);
  }
}
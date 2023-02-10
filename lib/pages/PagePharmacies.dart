import 'dart:async';

import 'package:card_swiper/card_swiper.dart';
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
  final List<String> list = ['Todo', 'Normal', 'Guardia'];
  Set<Marker> listMarker = {  };
  Set<Marker> listMarkerSaved = {  };

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
    return Scaffold(
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
                    SizedBox(
                      height: 40,
                      width: 320.0,
                      child: Swiper(
                        index: 0,
                        scrollDirection: Axis.horizontal,
                          loop: false,
                          itemBuilder: (BuildContext context, int index){
                            return  Row(
                              children: [

                                TextButton(
                                  style: TextButton.styleFrom(backgroundColor: Colors.white),
                                  onPressed: () {
                                    switch(list[index]){
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
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.access_time),
                                      Text(list[index], style: const TextStyle(color: Colors.black))
                                    ],
                                  )
                                )

                              ],
                            );
                          },
                          itemCount: list.length,
                          viewportFraction: 0.3
                      ),
                    )
                  ],
                )
          )
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
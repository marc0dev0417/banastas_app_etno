import 'dart:async';

import 'package:card_swiper/card_swiper.dart';
import 'package:etno_app/store/section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
  Set<Marker> listMarker = {};

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
                        children:  [
                             Column(
                                children: [
                                  Image.network('http://192.168.137.1:8080/images/sponsors/hotel.jpg', fit: BoxFit.fill),
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
                                                child: const Text('Bolea · Huesca', style: TextStyle(color: Colors.grey, fontSize: 10.0)),
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
                  markerId: MarkerId(element.name!),
                  position: LatLng(element.latitude!, element.longitude!),
                  draggable: true,
                  onDragEnd: (value) {
                  },
                infoWindow: InfoWindow(title: element.name)
              )
          );
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
                    Observer(builder: (context) => GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: _kGooglePlex,
                        onMapCreated: (GoogleMapController controller){
                          _controller.complete(controller);
                        },
                        markers: listMarker
                    )),
                    SizedBox(
                      height: 50,
                      width: double.maxFinite,
                      child: Swiper(
                        index: 1,
                        scrollDirection: Axis.horizontal,
                          loop: false,
                          itemBuilder: (BuildContext context, int index){
                            return  Row(
                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(backgroundColor: Colors.white),
                                  onPressed: () {},
                                  child: Row(
                                    children: [
                                      const Icon(Icons.access_time),
                                      const SizedBox(
                                        width: 5
                                      ),
                                      Text(list[index])
                                    ],
                                  )
                                )
                              ],
                            );
                          },
                          itemCount: list.length,
                          viewportFraction: 0.3,
                          scale: 0.3,
                      ),
                    )
                  ],
                )
          )
      );
  }
}
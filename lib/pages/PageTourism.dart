import 'dart:async';
import 'dart:ui' as ui;
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/Tourism.dart';
import '../models/TourismButton.dart';
import '../store/section.dart';

class PageTourism extends StatefulWidget {
  const PageTourism({super.key});

  @override
  State<StatefulWidget> createState() {
    return TourismState();
  }
}

class TourismState extends State<PageTourism> {
  final Section section = Section();

  Set<Marker> listMarker = {};
  Set<Marker> listMarkerSaved = {};
  List<TourismButton> tourismButton = [
    TourismButton('', Colors.black, 'Todo'),
    TourismButton('assets/vajilla.png', Colors.green, 'Restaurante'),
    TourismButton('assets/museo.png', Colors.yellow, 'Museo'),
    TourismButton('assets/hotel.png', Colors.indigo, 'Hotel')
  ];

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(42.13639592850662, -0.41057481476933433),
    zoom: 14.4746,
  );

  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))?.buffer.asUint8List();
  }

  @override
  void initState() {

    section.getAllTourismByLocality('Bolea').then((value) async {
      Uint8List? markerIcon;
        for (var element in value) {
          switch(element.type){
            case 'Museo': markerIcon = await getBytesFromAsset('assets/museo.png', 80);
            break;
            case 'Restaurante': markerIcon = await getBytesFromAsset('assets/vajilla.png', 80);
            break;
            case 'Hotel': markerIcon = await getBytesFromAsset('assets/hotel.png', 80);
            break;
          }
          setState(()  {
            listMarker.add(Marker(
              icon: BitmapDescriptor.fromBytes(markerIcon!),
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Wrap(
                          children: [
                            Column(
                              children: [
                                renderImageTourism(element),
                                Container(
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      children: [
                                        Container(
                                            padding: const EdgeInsets.all(15.0),
                                            alignment: Alignment.topLeft,
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      left: 15.0),
                                                  alignment: Alignment.topLeft,
                                                  child: Text(element.title!,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontSize: 15.0)),
                                                ),
                                                Container(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      left: 15.0),
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                      '${element.username!} · Huesca',
                                                      style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 10.0)),
                                                ),
                                                const Divider(),
                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  padding:
                                                  const EdgeInsets.only(
                                                      top: 5.0, left: 15.0),
                                                  child: Text(element.type!,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontSize: 15.0)),
                                                ),
                                                const Divider(),
                                                Container(
                                                    alignment:
                                                    Alignment.topLeft,
                                                    padding:
                                                    const EdgeInsets.only(
                                                        top: 5.0,
                                                        left: 15.0),
                                                    child: Text(
                                                        element.description!,
                                                        style: const TextStyle(
                                                            color:
                                                            Colors.grey))),
                                              ],
                                            )),
                                      ],
                                    ))
                              ],
                            ),
                          ],
                        );
                      });
                },
                markerId: MarkerId(element.type!),
                position: LatLng(element.latitude!, element.longitude!),
                draggable: true,
                onDragEnd: (value) {},
                infoWindow: InfoWindow(title: element.title)));
            listMarkerSaved = listMarker;
          });
        }
    });
    BackButtonInterceptor.add(myInterceptor);
    super.initState();
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  Future<bool> myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) async {
   // Navigator.of(context).push(MaterialPageRoute(builder: (_) => ));
    await Future.delayed(const Duration(milliseconds: 500));
    Navigator.of(context).pop();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tourism',
      home: DefaultTabController(
        animationDuration: Duration.zero,
        initialIndex: 0,
        length: tourismButton.length,
        child: Scaffold(
            body: SafeArea(
                child: Stack(
                  children: [
                    GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: _kGooglePlex,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      markers: listMarker,
                    ),
                    TabBar(
                        indicatorColor: Colors.transparent,
                        isScrollable: true,
                        tabs: [ for (final tab in tourismButton) ElevatedButton(
                            style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.white)),
                            onPressed: () {
                              switch(tab.name){
                                case 'Restaurante': setState(() {
                                  listMarker = listMarkerSaved;
                                  listMarker = listMarker.where((element) => element.markerId.value == 'Restaurante').toSet();
                                });
                                break;
                                case 'Monumento': setState(() {
                                  listMarker = listMarkerSaved;
                                  listMarker = listMarker.where((element) => element.markerId.value == 'Monumento').toSet();
                                });
                                break;
                                case 'Museo': setState(() {
                                  listMarker = listMarkerSaved;
                                  listMarker = listMarker.where((element) => element.markerId.value == 'Museo').toSet();
                                });
                                break;
                                case 'Hotel': setState(() {
                                  listMarker = listMarkerSaved;
                                  listMarker = listMarker.where((element) => element.markerId.value == 'Hotel').toSet();
                                });
                                break;
                                case 'Todo': setState(() {
                                  listMarker = listMarkerSaved;
                                });
                              }
                            },
                            child: renderImageTab(tab.assetUrl!, tab.name!)
                        )]
                    )
                  ],
                )),
          ),
        )
    );
  }
}

Widget renderImageTourism(Tourism tourism) {
  if (tourism.imageUrl == null) {
    return Image.asset('assets/Loading_icon.gif',
        height: 200, fit: BoxFit.fill, width: 400);
  } else {
    return Image.network(tourism.imageUrl!,
        fit: BoxFit.fill, height: 200, width: 300);
  }
}
Widget renderImageTab(String urlAsset, String name){
  if(urlAsset != ''){
   return Row(
      children: [
        Image.asset(urlAsset, height: 35.0, width: 35.0),
        Text(name, style: const TextStyle(color: Colors.black))
      ],
    );
  } else {
   return Row(
      children: [
        Text(name, style: const TextStyle(color: Colors.black))
      ],
    );
  }
}
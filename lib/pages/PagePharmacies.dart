import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:etno_app/models/PharmaciesButton.dart';
import 'package:etno_app/models/Pharmacy.dart';
import 'package:etno_app/store/section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PagePharmacies extends StatefulWidget {
  const PagePharmacies({super.key});

  @override
  State<StatefulWidget> createState() {
    return PharmaciesState();
  }
}

class PharmaciesState extends State<PagePharmacies> {
  final Section section = Section();
  Set<Marker> listMarker = {};
  Set<Marker> listMarkerSaved = {};
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

  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))?.buffer.asUint8List();
  }

  @override
  void initState() {
    section.getAllPharmaciesByLocality('Bolea').then((value) =>
        value.forEach((element) async {
          Uint8List? markerIcon;
            switch (element.type) {
              case 'Guardia':
                markerIcon = await getBytesFromAsset('assets/pharmacy_blue.png', 80);
                break;
              case 'Normal':
                markerIcon = await getBytesFromAsset('assets/pharmacy_red.png', 80);
                break;
            }
          setState(() {
            listMarker.add(Marker(
              icon: BitmapDescriptor.fromBytes(markerIcon!),
                onTap: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.white,
                      context: context,
                      builder: (context) {
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
                                            padding: const EdgeInsets.all(16.0),
                                            alignment: Alignment.topLeft,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          left: 15.0),
                                                      alignment: Alignment.topLeft,
                                                      child: Text(element.name!,
                                                          style: const TextStyle(
                                                              fontWeight:
                                                              FontWeight.bold,
                                                              fontSize: 15.0)),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(right: 15.0),
                                                      child: Text(element.type!,
                                                          style: TextStyle(
                                                              fontSize: 15.0,
                                                              backgroundColor:
                                                              element.type ==
                                                                  'Guardia'
                                                                  ? Colors
                                                                  .blue
                                                                  : Colors
                                                                  .red)),
                                                    )
                                                  ],
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
                                                    alignment:
                                                        Alignment.topLeft,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5.0,
                                                            left: 15.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(element.schedule!,
                                                            style: const TextStyle(
                                                                fontSize:
                                                                    12.0)),
                                                      ],
                                                    )),
                                                const Divider(),
                                                Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5.0,
                                                            left: 15.0),
                                                    child: Text(
                                                        element.direction!,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.grey))),
                                              ],
                                            )),
                                      ],
                                    )),

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
                infoWindow: InfoWindow(title: element.name)));
            listMarkerSaved = listMarker;
          });
        }));
    BackButtonInterceptor.add(myInterceptor);
    super.initState();
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  Future<bool> myInterceptor(
      bool stopDefaultButtonEvent, RouteInfo info) async {
    // Navigator.of(context).push(MaterialPageRoute(builder: (_) => ));
    await Future.delayed(const Duration(milliseconds: 500));
    Navigator.of(context).pop();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pharmacies',
      home: DefaultTabController(
        initialIndex: 0,
        length: pharmaciesButton.length,
        child: Scaffold(
          backgroundColor: Colors.red,
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
            body: Stack(
          children: [
            GoogleMap(
                myLocationButtonEnabled: false,
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: listMarker),
            TabBar(
                padding: EdgeInsets.only(top: 66.0, left: 16.0, right: 16.0),
                indicatorColor: Colors.transparent,
                isScrollable: true,
                tabs: [
                  for (final tab in pharmaciesButton)
                    ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.white)),
                        onPressed: () {
                          switch (tab.name) {
                            case 'Normal':
                              setState(() {
                                listMarker = listMarkerSaved;
                                listMarker = listMarker
                                    .where((element) =>
                                        element.markerId.value == 'Normal')
                                    .toSet();
                              });
                              break;
                            case 'Guardia':
                              setState(() {
                                listMarker = listMarkerSaved;
                                listMarker = listMarker
                                    .where((element) =>
                                        element.markerId.value == 'Guardia')
                                    .toSet();
                              });
                              break;
                            case 'Todo':
                              setState(() {
                                listMarker = listMarkerSaved;
                              });
                          }
                        },
                        child: Row(children: [
                          renderImageToTab(tab.name!),
                          SizedBox(width: 8.0),
                          Text(tab.name!,
                              style: const TextStyle(color: Colors.black))
                        ]))
                ])
          ],
            ),
                floatingActionButton: FloatingActionButton(
                  backgroundColor: Colors.red,
            onPressed: () => Navigator.pop(context),
              child: Icon(Icons.chevron_left),
        ),
        ),
      ),
    );
  }
}

Widget renderImagePharmacy(Pharmacy pharmacy) {
  if (pharmacy.imageUrl == null) {
    return const SizedBox(
        width: 20.0, height: 20.0, child: CircularProgressIndicator());
  } else {
    return Image.network(pharmacy.imageUrl!,
        fit: BoxFit.fill, height: 200, width: 300);
  }
}
Widget renderImageToTab(String tabName){
  switch(tabName){
    case 'Normal': return Image.asset('assets/pharmacy_red.png', width: 30.0, height: 30.0);
    case 'Guardia': return Image.asset('assets/pharmacy_blue.png', width: 30.0, height: 30.0);
    default: return Image.asset('assets/todo_pharmacy.png', width: 30.0, height: 30.0);
  }
}
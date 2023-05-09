import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/Tourism.dart';

class PageSpecificMarker extends StatefulWidget {
  final Tourism tourism;
  PageSpecificMarker({super.key, required this.tourism});

  @override
  State<PageSpecificMarker> createState() => _PageSpecificMarkerState();
}

class _PageSpecificMarkerState extends State<PageSpecificMarker> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(42.181186, -0.452474);

  CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();

  final Set<Marker> markers = {};

  @override
  void initState() {
    setState(() {
      markers.add(Marker(
        onTap: () {
          _customInfoWindowController.addInfoWindow!(
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         widget.tourism.imageUrl != null ? Image.network(widget.tourism.imageUrl!, height: 80.0, width: 80.0) : Image.asset('assets/app.png'),
                          SizedBox(
                            width: 8.0,
                          ),
                          Row(
                            children: [
                              Text('Nombre:', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                              SizedBox(width: 4.0),
                              Text(
                                widget.tourism.title!
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ],
            ),
            LatLng(widget.tourism.latitude!, widget.tourism.longitude!)
          );
        },
        markerId: MarkerId(widget.tourism.idTourism!),
        position: LatLng(widget.tourism.latitude!, widget.tourism.longitude!),
        infoWindow: InfoWindow(
          title: widget.tourism.title,
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
    super.initState();
  }

  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: <Widget>[
          GoogleMap(
            onTap: (position) {
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove!();
            },
            onMapCreated: (GoogleMapController controller) async {
              _customInfoWindowController.googleMapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 15.4746,
            ),
            markers: markers,
          )
        ],
      ),
    );
  }
}


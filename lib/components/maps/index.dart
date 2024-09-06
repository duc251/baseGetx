import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../common/constants/app_size_device.dart';

class GoogleMapComponent extends StatefulWidget {
  const GoogleMapComponent({super.key});

  @override
  State<GoogleMapComponent> createState() => _GoogleMapComponentState();
}

class _GoogleMapComponentState extends State<GoogleMapComponent> {
  final Completer<GoogleMapController> _controller = Completer();

  GoogleMapController? mapController;

  static const LatLng myLocation =
      LatLng(20.980620004384953, 105.76684114041556);

  static const LatLng store_1_location =
      LatLng(20.89641610425306, 106.30360174039619);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthDevice(context),
      height: 300,
      child: GoogleMap(
        myLocationButtonEnabled: false,
        onMapCreated: (controller) {
          mapController = controller;
        },
        initialCameraPosition:
            const CameraPosition(target: myLocation, zoom: 7.5),
        markers: {
          const Marker(
            markerId: MarkerId('HN'),
            position: myLocation,
            infoWindow: InfoWindow(title: 'Cơ sở Hà Nội', snippet: "48 Tố Hữu"),
          ),
          const Marker(
              markerId: MarkerId('HD'),
              position: store_1_location,
              infoWindow:
                  InfoWindow(title: 'Cơ sở Hải Dương', snippet: "48 Tố Hữu"))
        },
        onTap: (argument) {},
        gestureRecognizers: Set()
          ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer())),
        // gestureRecognizers: <Factory<OneSequenceGestureRecognizer>> [
        //   new Factory<OneSequenceGestureRecognizer>(() => new EagerGestureRecognizer())
        // ].toSet(),
      ),
    );
  }
}

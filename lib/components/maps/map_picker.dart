import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../common/base/base_button.dart';
import '../../common/base/base_container.dart';
import '../../common/constants/app_colors.dart';
import '../../common/constants/app_spacing.dart';
import '../../common/constants/app_typography.dart';

import '../../common/constants/app_size_device.dart';

class MapPickerNPP extends StatefulWidget {
  MapPickerNPP({required this.comfirmPosition, super.key});

  Function comfirmPosition;

  @override
  State<MapPickerNPP> createState() => _MapPickerNPPState();
}

class _MapPickerNPPState extends State<MapPickerNPP> {
  GoogleMapController? mapController;

  CameraPosition? positionMap;

  static const LatLng myLocation =
      LatLng(20.980620004384953, 105.76684114041556);

  // static const LatLng store_1_location =
  //     LatLng(20.89641610425306, 106.30360174039619);

  bool _isLoading = false;

  Timer? timer;

  List<Placemark>? placemark;

  Future<void> getAddressFromLatLong() async {
    if (timer != null) {
      timer!.cancel();
    }

    timer = Timer(const Duration(seconds: 1), () async {
      await placemarkFromCoordinates(
              positionMap!.target.latitude, positionMap!.target.longitude)
          .then((value) {
        setState(() {
          _isLoading = false;
          placemark = value;
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    mapController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            SizedBox(
              width: widthDevice(context),
              height: heightDevice(context),
              child: GoogleMap(
                myLocationButtonEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
                onCameraMove: (position) {
                  setState(() {
                    positionMap = position;
                    _isLoading = true;
                  });
                  getAddressFromLatLong();
                },
                initialCameraPosition:
                    const CameraPosition(target: myLocation, zoom: 15),
                // markers: {
                //   Marker(
                //     markerId: MarkerId('HN'),
                //     position: myLocation,
                //     infoWindow: InfoWindow(title: 'Cơ sở Hà Nội', snippet: "48 Tố Hữu"),
                //   ),
                //   Marker(
                //     markerId: MarkerId('HD'),
                //     position: store_1_location,
                //     infoWindow: InfoWindow(title: 'Cơ sở Hải Dương', snippet: "48 Tố Hữu")
                //   )
                // },
                // onTap: (argument) {

                // },
                gestureRecognizers: Set()
                  ..add(Factory<PanGestureRecognizer>(
                      () => PanGestureRecognizer())),
                // gestureRecognizers: <Factory<OneSequenceGestureRecognizer>> [
                //   new Factory<OneSequenceGestureRecognizer>(() => new EagerGestureRecognizer())
                // ].toSet(),
              ),
            ),
            const Positioned(
              child: Center(
                child: Icon(
                  Icons.location_pin,
                  size: 32,
                  color: AppColors.red_1,
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: BaseContainer(
            context,
            Column(
              children: [
                if (_isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                else
                  RichText(
                    text: TextSpan(
                      text: 'Địa chỉ CHTH là: ',
                      style:
                          AppTypography.p6.copyWith(color: AppColors.greyColor),
                      children: [
                        if (placemark != null)
                          TextSpan(
                            text:
                                '${placemark![0].street}, ${placemark![0].subAdministrativeArea}, ${placemark![0].administrativeArea}',
                            style: AppTypography.h6
                                .copyWith(color: AppColors.mainColor),
                          ),
                      ],
                    ),
                  ),
                SizedBox(height: sp16),
                SizedBox(
                  width: double.infinity,
                  child: MainButton(
                    title: 'Xác nhận địa chỉ',
                    event: () {
                      confirmAddress();
                    },
                    largeButton: false,
                    icon: null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void confirmAddress() {
    widget.comfirmPosition(
      // positionMap!,
      '${placemark![0].street}, ${placemark![0].subAdministrativeArea}, ${placemark![0].administrativeArea}',
    );
    // _controller.updateAddress(
    //   positionMap!,
    //   '${placemark![0].street}, ${placemark![0].subAdministrativeArea}, ${placemark![0].administrativeArea}',
    // );

    Get.back();
  }
}

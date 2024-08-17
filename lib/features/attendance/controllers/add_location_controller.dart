import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_attendance/utils/loading_dialog.dart';
import 'package:mobile_attendance/utils/locator_service.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class AddLocationController extends GetxController {
  late List<MapLatLng> mapMarkers;
  late MapLatLng initialMarker;
  late MapTileLayerController mapController;

  @override
  void onInit() {
    var locatorServicePosition = LocatorService.currentPosition!;
    mapController = MapTileLayerController();
    initialMarker = MapLatLng(
        locatorServicePosition.latitude, locatorServicePosition.longitude);
    mapMarkers = <MapLatLng>[
      initialMarker,
    ];
    super.onInit();
  }

  setPinLocation(BuildContext context, PointerUpEvent event) {
    final RenderBox markerRenderBox = context.findRenderObject()! as RenderBox;
    // To obtain the maps local point, we have converted the global
    // point into local point using the marker render box. After that
    // we have converted that point into latlng and updated it’s
    // position.
    final MapLatLng latLng = mapController.pixelToLatLng(
      markerRenderBox.globalToLocal(event.position),
    );
    mapMarkers[0] = MapLatLng(latLng.latitude, latLng.longitude);
    mapController.updateMarkers([0]);
  }

  saveLocation(
    BuildContext context,
  ) async {
    LoadingScreen.show(context, 'Mohon Tunggu sebentar..');

    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('attendance_location');

    collectionReference.doc('hcUnodxIEHDZrKAuaDpk').update({
      'latitude': mapMarkers[0].latitude,
      'longitude': mapMarkers[0].longitude,
    }).then((_) {
      LoadingScreen.hide(context);

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green.shade300,
          content: const Text('Attendance Location Pin Saved')));
    }).catchError((error) {
      LoadingScreen.hide(context);

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red.shade300,
          content: const Text(
            'Failed to Save Attendance Location Pin ',
          )));
    });
  }
}

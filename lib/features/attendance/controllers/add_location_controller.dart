import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_attendance/features/attendance/models/location_pinned.dart';
import 'package:mobile_attendance/utils/loading_dialog.dart';
import 'package:mobile_attendance/utils/locator_service.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

/// `AddLocationController` adalah controller yang mengelola logika
/// untuk layar menambahkan lokasi, termasuk menempatkan pin pada peta
/// dan menyimpan lokasi tersebut ke Firestore.
class AddLocationController extends GetxController {
  // Daftar marker peta dan controller peta.
  late List<MapLatLng> mapMarkers;
  late MapLatLng initialMarker;
  late MapTileLayerController mapController;

  @override
  void onInit() {
    // Mendapatkan posisi saat ini dari `LocatorService`.
    var locatorServicePosition = LocatorService.currentPosition!;

    // Inisialisasi controller peta dan marker.
    mapController = MapTileLayerController();
    initialMarker = MapLatLng(
        locatorServicePosition.latitude, locatorServicePosition.longitude);
    mapMarkers = <MapLatLng>[
      initialMarker,
    ];
    super.onInit();
  }

  /// Menetapkan lokasi pin pada peta berdasarkan event pointer up.
  ///
  /// Menggunakan `PointerUpEvent` untuk menentukan lokasi di peta
  /// dan memperbarui posisi marker dengan koordinat tersebut.
  setPinLocation(BuildContext context, PointerUpEvent event) {
    final RenderBox markerRenderBox = context.findRenderObject()! as RenderBox;

    /// Mengonversi titik global ke titik lokal dan kemudian ke latLng
    // untuk memperbarui posisi marker di peta.
    final MapLatLng latLng = mapController.pixelToLatLng(
      markerRenderBox.globalToLocal(event.position),
    );
    mapMarkers[0] = MapLatLng(latLng.latitude, latLng.longitude);
    mapController.updateMarkers([0]);
  }

  /// Menyimpan lokasi pin ke Firestore.
  ///
  /// Menampilkan layar loading saat proses penyimpanan berlangsung.
  /// Menyimpan data lokasi pin ke collection `attendance_location` di Firestore.
  /// Menampilkan SnackBar yang sesuai berdasarkan hasil operasi.
  saveLocation(
    BuildContext context,
  ) async {
    LoadingScreen.show(context, 'Mohon Tunggu sebentar..');

    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('attendance_location');

    var pinnedLocation = LocationPinned(
      latitude: mapMarkers[0].latitude,
      longitude: mapMarkers[0].longitude,
    );
    collectionReference
        .doc('hcUnodxIEHDZrKAuaDpk')
        .update(pinnedLocation.toJson())
        .then((_) {
      LoadingScreen.hide(context);

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green.shade400,
          content: const Text('Pin Lokasi Absensi berhasil disimpan')));
    }).catchError((error) {
      LoadingScreen.hide(context);

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red.shade400,
          content: const Text(
            'Gagal Menyimpan Pin Lokasi Absensi',
          )));
    });
  }
}

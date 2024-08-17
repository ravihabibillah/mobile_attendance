// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_attendance/features/attendance/models/location_pinned.dart';
import 'package:mobile_attendance/utils/custom_dialog.dart';
import 'package:mobile_attendance/utils/locator_service.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

/// `LiveAttendanceController` adalah controller yang mengelola logika
/// untuk layar absensi langsung, termasuk mengambil lokasi yang dipin
/// dan memeriksa apakah pengguna berada di lokasi yang benar.
class LiveAttendanceController extends GetxController {
  // untuk Menyimpan informasi lokasi yang dipin.
  LocationPinned pinnedLocation = LocationPinned(
    latitude: 0,
    longitude: 0,
  );

  // untuk Menyimpan status loading dan data.
  var isLoading = true.obs;
  var hasData = false.obs;

  // Daftar marker peta dan controller untuk peta.
  late List<MapLatLng> mapMarkers;
  late MapLatLng initialMarker;
  late MapTileLayerController mapController;

  @override
  void onInit() async {
    // Mengambil lokasi yang dipin saat inisialisasi controller.
    await getPinnedLocation();

    // Mendapatkan posisi saat ini dari `LocatorService`.
    var locatorServicePosition = LocatorService.currentPosition!;

    // Inisialisasi controller peta dan marker.
    mapController = MapTileLayerController();
    initialMarker = MapLatLng(
        locatorServicePosition.latitude, locatorServicePosition.longitude);
    mapMarkers = <MapLatLng>[
      initialMarker,
      MapLatLng(pinnedLocation.latitude!, pinnedLocation.longitude!)
    ];
    super.onInit();
  }

  /// Mengambil lokasi yang dipin dari Firestore.
  ///
  /// Metode ini membaca data dari collection `attendance_location` di Firestore,
  /// kemudian memperbarui `pinnedLocation` dengan data yang diambil.
  getPinnedLocation() async {
    try {
      final snapshots = await FirebaseFirestore.instance
          .collection('attendance_location')
          .get();

      if (snapshots.docs.isNotEmpty) {
        final locationData =
            snapshots.docs.map((e) => LocationPinned.fromSnapshot(e)).first;

        pinnedLocation = locationData;
        hasData(true);
      }
      isLoading(false);
    } catch (error) {
      isLoading(false);
      debugPrint(error.toString());
    }
  }

  /// Memeriksa apakah pengguna berada di dalam area lokasi yang dipin.
  ///
  /// Menggunakan `LocatorService` untuk memeriksa jarak antara lokasi
  /// pengguna saat ini dengan lokasi yang dipin. Menampilkan dialog
  /// yang sesuai berdasarkan hasil pengecekan.
  checkLocation(BuildContext context) async {
    var isInLocation = await LocatorService().checkInAreaOrNot(
        allowedDistance: 50,
        pinLatitude: pinnedLocation.latitude!,
        pinLongitude: pinnedLocation.longitude!);

    if (isInLocation) {
      CustomDialog.show(
        context,
        title: 'Absensi berhasil',
        details: 'Data Kehadiranmu telah disimpan.',
      );
    } else {
      CustomDialog.show(
        context,
        title: 'Absensi ditolak',
        details: 'Kamu berada lebih dari 50 meter dari lokasi absen.',
      );
    }
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_attendance/features/attendance/models/location_pinned.dart';
import 'package:mobile_attendance/utils/custom_dialog.dart';
import 'package:mobile_attendance/utils/locator_service.dart';

class LiveAttendanceController extends GetxController {
  LocationPinned pinnedLocation = LocationPinned(
    latitude: 0,
    longitude: 0,
  );

  var isLoading = true.obs;
  var hasData = false.obs;

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

  @override
  void onInit() {
    getPinnedLocation();
    super.onInit();
  }
}

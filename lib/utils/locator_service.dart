import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocatorService {
  static String? currentAddress;
  static Position? currentPosition;

  static Future<bool> handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> getCurrentPosition(BuildContext context) async {
    final hasPermission = await handleLocationPermission(context);
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      currentPosition = position;
      log('Current Position is ${position.latitude} and ${position.longitude}');
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<bool> checkInAreaOrNot({
    required double allowedDistance,
    required double pinLatitude,
    required double pinLongitude,
  }) async {
    int distanceInKilometers = (Geolocator.distanceBetween(
      pinLatitude,
      pinLongitude,
      currentPosition!.latitude,
      currentPosition!.longitude,
    )).toInt();

    print('Jarak lokasi saat ini dengan pinned location adalah ' +
        distanceInKilometers.toString() +
        ' Meter');

    if (distanceInKilometers < allowedDistance) {
      return true;
    } else {
      return false;
    }
  }
}

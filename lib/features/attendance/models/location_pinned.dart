// To parse this JSON data, do
//
//     final locationPinned = locationPinnedFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

LocationPinned locationPinnedFromJson(String str) =>
    LocationPinned.fromJson(json.decode(str));

String locationPinnedToJson(LocationPinned data) => json.encode(data.toJson());

class LocationPinned {
  double? latitude;
  double? longitude;

  LocationPinned({
    this.latitude,
    this.longitude,
  });

  factory LocationPinned.fromJson(Map<String, dynamic> json) => LocationPinned(
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  factory LocationPinned.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return LocationPinned(
      latitude: data['latitude'],
      longitude: data['longitude'],
    );
  }

  Map<String, dynamic> toJson() => {
        "latitude": latitude.toString(),
        "longitude": longitude.toString(),
      };
}

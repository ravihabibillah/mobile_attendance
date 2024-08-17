import 'package:cloud_firestore/cloud_firestore.dart';

/// `LocationPinned` adalah model data yang mewakili lokasi yang dipin
/// dengan informasi latitude dan longitude. Kelas ini juga menyediakan
/// metode untuk konversi data dari dan ke format yang digunakan dalam
/// Firestore.
class LocationPinned {
  double? latitude; // Latitude lokasi yang dipin.
  double? longitude; // Longitude lokasi yang dipin.

  LocationPinned({
    this.latitude,
    this.longitude,
  });

  /// Membuat instance `LocationPinned` dari `DocumentSnapshot` Firestore.
  ///
  /// Metode ini digunakan untuk mengonversi data dokumen Firestore ke dalam
  /// format objek `LocationPinned`.
  factory LocationPinned.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    // Mengambil data dari dokumen Firestore.
    final data = document.data()!;

    return LocationPinned(
      latitude: data['latitude'],
      longitude: data['longitude'],
    );
  }

  /// Mengonversi instance `LocationPinned` menjadi format JSON.
  ///
  /// Metode ini digunakan untuk menyimpan data `LocationPinned` ke Firestore
  /// dalam format yang dapat dipahami oleh Firestore.
  Map<String, dynamic> toJson() => {
        "latitude": latitude.toString(),
        "longitude": longitude.toString(),
      };
}

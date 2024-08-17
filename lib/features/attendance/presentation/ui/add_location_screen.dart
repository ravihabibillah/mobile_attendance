import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_attendance/features/attendance/controllers/add_location_controller.dart';
import 'package:mobile_attendance/shared_widgets/custom_button.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

/// `AddLocationScreen` adalah halaman yang memungkinkan pengguna untuk mendaftarkan
/// lokasi baru dengan memilih lokasi pada peta
///
/// catatan: hanya bisa mendaftarkan satu lokasi.
class AddLocationScreen extends StatelessWidget {
  const AddLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftarkan Lokasi Absensi'),
      ),
      body: CustomSFMaps(),
    );
  }
}

/// `CustomSFMaps` adalah widget yang menampilkan peta dan memungkinkan pengguna
/// untuk menambahkan lokasi baru dengan memilih titik pada peta.
class CustomSFMaps extends StatelessWidget {
  CustomSFMaps({super.key});

  // Mengambil instance dari `AddLocationController` menggunakan GetX.
  final controller = Get.find<AddLocationController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Listener untuk menangani interaksi dengan peta.
        Listener(
          onPointerUp: (event) => controller.setPinLocation(
              context, event), // Akshi Untuk melakukan set pin pada peta
          child: SfMaps(
            layers: [
              MapTileLayer(
                initialZoomLevel: 15,
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                controller: controller.mapController,
                initialMarkersCount: controller.mapMarkers.length,
                initialFocalLatLng: controller.initialMarker,
                zoomPanBehavior: MapZoomPanBehavior(),
                markerBuilder: (BuildContext context, int index) {
                  var mapMarker = controller.mapMarkers[index];
                  return MapMarker(
                    longitude: mapMarker.longitude,
                    latitude: mapMarker.latitude,
                    child: GestureDetector(
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 50,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        // Tombol untuk menyimpan lokasi yang ditempatkan di bawah layar.
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              text: 'Simpan Lokasi',
              onPressed: () {
                // Memanggil fungsi untuk menyimpan lokasi ketika tombol ditekan.
                controller.saveLocation(context);
              },
            ),
          ),
        )
      ],
    );
  }
}

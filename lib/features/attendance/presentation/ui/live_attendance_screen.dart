import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_attendance/features/attendance/controllers/live_attendance_controller.dart';
import 'package:mobile_attendance/shared_widgets/custom_button.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

/// `LiveAttendanceScreen` adalah halaman yang menampilkan peta untuk
/// melakukan absensi secara langsung berdasarkan lokasi pengguna.
class LiveAttendanceScreen extends StatelessWidget {
  LiveAttendanceScreen({super.key});

  // Mengambil instance dari `LiveAttendanceController` menggunakan GetX.
  final controller = Get.find<LiveAttendanceController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Attendance'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          // Menampilkan indikator loading ketika data sedang dimuat.
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.hasData.value) {
          // Menampilkan peta jika data tersedia.
          return CustomSFMaps();
        } else {
          // Menampilkan pesan kesalahan jika terjadi masalah dalam memuat data.
          return const Center(
            child: Text('Terjadi Kesalahan'),
          );
        }
      }),
    );
  }
}

/// `CustomSFMaps` adalah widget yang menampilkan peta dengan menggunakan
/// package `syncfusion_flutter_maps` untuk menampilkan lokasi dan absensi.
class CustomSFMaps extends StatelessWidget {
  CustomSFMaps({super.key});

  // Mengambil instance dari `LiveAttendanceController` menggunakan GetX.
  final controller = Get.find<LiveAttendanceController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Menampilkan peta dengan marker berdasarkan lokasi pengguna.
        SfMaps(
          layers: [
            MapTileLayer(
              initialZoomLevel: 15,
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              controller: controller.mapController,
              initialMarkersCount: controller.mapMarkers.length,
              initialFocalLatLng: controller.initialMarker,
              markerBuilder: (BuildContext context, int index) {
                var marker = controller.mapMarkers[index];
                return MapMarker(
                  longitude: marker.longitude,
                  latitude: marker.latitude,
                  child: GestureDetector(
                    child: index > 0
                        ? const Icon(
                            Icons.location_on,
                            color: Colors.green,
                            size: 50,
                          )
                        : const Icon(
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
        // Tombol untuk melakukan absensi yang ditempatkan di bawah layar.
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              text: 'Lakukan Absensi',
              onPressed: () {
                // Memanggil fungsi untuk melakukan pengecekan lokasi saat tombol ditekan.
                controller.checkLocation(context);
              },
            ),
          ),
        )
      ],
    );
  }
}

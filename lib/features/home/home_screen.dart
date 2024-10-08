import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_attendance/config/app_pages.dart';
import 'package:mobile_attendance/shared_widgets/custom_button.dart';
import 'package:mobile_attendance/utils/locator_service.dart';

/// `HomeScreen` adalah layar utama aplikasi yang menampilkan antarmuka untuk
/// menavigasi ke halaman lain seperti "Live Attendance" dan menambahkan lokasi pin.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // service lokasi dijalankan untuk mendapatkan posisi pengguna saat ini.
    LocatorService().getCurrentPosition(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Judul Aplikasi
          title: const Text('Mobile Attendance'), // Judul aplikasi di AppBar.
        ),
        // Tombol Untuk Menambahkan Lokasi Baru
        floatingActionButton: FloatingActionButton.extended(
          label: const Row(
            children: [
              Icon(Icons.add_location),
              SizedBox(width: 8),
              Text('Tambahkan Pin Lokasi')
            ],
          ),
          backgroundColor: Colors.orange.shade400,
          onPressed: () {
            // Navigasi ke halaman "Tambahkan Lokasi" ketika tombol ditekan.
            Get.toNamed(Routes.addPinnedLocation);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
              child: CustomButton(
            text: 'Live Attendance',
            onPressed: () {
              // Navigasi ke halaman "Live Attendance" ketika tombol ditekan.
              Get.toNamed(Routes.liveAttendance);
            },
          )),
        ));
  }
}

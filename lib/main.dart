import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_attendance/config/app_pages.dart';

void main() async {
  // Memastikan binding widget sudah terinisialisasi sebelum menjalankan fungsi async.
  WidgetsFlutterBinding.ensureInitialized();

  // Menginisialisasi Firebase agar dapat digunakan di dalam aplikasi.
  await Firebase.initializeApp();

  // Menjalankan aplikasi dengan widget utama MainApp.
  runApp(const MainApp());
}

/// Kelas MainApp merupakan root dari aplikasi.
/// Kelas ini menggunakan GetMaterialApp dari GetX untuk mengatur navigasi dan state management.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Inisialisasi route awal berdasarkan konfigurasi di AppPages.
      initialRoute: AppPages.initial,

      // Mendefinisikan seluruh halaman yang dapat dinavigasi dalam aplikasi.
      getPages: AppPages.routes,
    );
  }
}

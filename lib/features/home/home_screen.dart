import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mobile_attendance/features/location/presentation/ui/add_location_screen.dart';
import 'package:mobile_attendance/shared_widgets/custom_button.dart';
import 'package:mobile_attendance/utils/locator_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    LocatorService().getCurrentPosition(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Judul Aplikasi
          title: const Text('Mobile Attendance'),
        ),
        // Tombol Untuk Menambahkan Lokasi Baru
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add_location),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const AddLocationScreen();
            }));
          },
        ),
        body: Padding(
          padding: EdgeInsets.all(24.0),
          child: Center(
              child: CustomButton(
            text: 'Live Attendance',
            onPressed: () {},
          )),
        ));
  }
}

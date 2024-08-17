import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mobile_attendance/shared_widgets/custom_button.dart';
import 'package:mobile_attendance/shared_widgets/custom_textformfield.dart';
import 'package:mobile_attendance/utils/locator_service.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class AddLocationScreen extends StatefulWidget {
  const AddLocationScreen({super.key});

  @override
  State<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  final formKey = GlobalKey<FormState>();
  final latitudeFieldController = TextEditingController();
  final longitudeFieldController = TextEditingController();

  final latitudeFieldFocus = FocusNode();
  final longitudeFieldFocus = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Daftarkan Lokasi Absensi'),
        ),
        body: CustomSFMaps()
        // Column(
        //   children: [
        //     Form(
        //       key: formKey,
        //       child: Padding(
        //         padding: const EdgeInsets.all(16.0),
        //         child: Column(
        //           children: [
        //             CustomTextFormField(
        //               controller: latitudeFieldController,
        //               focusNode: latitudeFieldFocus,
        //               hint: 'Masukkan Latitude',
        //               label: 'Latitude',
        //               validator: (value) {
        //                 if (value == null) {
        //                   return 'Latitude harus diisi!';
        //                 }
        //                 return null;
        //               },
        //               onSubmit: (value) {
        //                 latitudeFieldFocus.unfocus();
        //                 FocusScope.of(context).requestFocus(longitudeFieldFocus);
        //               },
        //             ),
        //             CustomTextFormField(
        //               controller: longitudeFieldController,
        //               focusNode: longitudeFieldFocus,
        //               hint: 'Masukkan Longitude',
        //               label: 'Longitude',
        //               validator: (value) {
        //                 if (value == null) {
        //                   return 'Longitude harus diisi!';
        //                 }
        //                 return null;
        //               },
        //               onSubmit: (value) {
        //                 latitudeFieldFocus.unfocus();
        //                 FocusScope.of(context).requestFocus(longitudeFieldFocus);
        //               },
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),

        );
  }
}

class CustomSFMaps extends StatefulWidget {
  const CustomSFMaps({super.key});

  @override
  State<CustomSFMaps> createState() => _CustomSFMapsState();
}

class _CustomSFMapsState extends State<CustomSFMaps> {
  late List<MapLatLng> mapMarkers;
  late MapLatLng marker;
  late MapTileLayerController mapController;

  @override
  void initState() {
    var locatorServicePosition = LocatorService.currentPosition!;
    mapController = MapTileLayerController();
    marker = MapLatLng(
        locatorServicePosition.latitude,
        // ?? -6.2088,
        locatorServicePosition.longitude
        // ?? 106.8456
        );
    mapMarkers = <MapLatLng>[
      marker,
      // MapLatLng(28.7041, 77.1025) // India
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Listener(
          onPointerUp: (event) {
            final RenderBox markerRenderBox =
                context.findRenderObject()! as RenderBox;
            // To obtain the maps local point, we have converted the global
            // point into local point using the marker render box. After that
            // we have converted that point into latlng and updated it’s
            // position.
            final MapLatLng latLng = mapController.pixelToLatLng(
              markerRenderBox.globalToLocal(event.position),
            );
            mapMarkers[0] = MapLatLng(latLng.latitude, latLng.longitude);
            mapController.updateMarkers([0]);
          },
          child: SfMaps(
            layers: [
              MapTileLayer(
                initialZoomLevel: 15,
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                controller: mapController,
                initialMarkersCount: mapMarkers.length,
                initialFocalLatLng: marker,
                zoomPanBehavior: MapZoomPanBehavior(),
                markerBuilder: (BuildContext context, int index) {
                  return MapMarker(
                    longitude: mapMarkers[index].longitude,
                    latitude: mapMarkers[index].latitude,
                    child: GestureDetector(
                      // onPanUpdate: (DragUpdateDetails details) {
                      //   final RenderBox markerRenderBox =
                      //       context.findRenderObject()! as RenderBox;
                      //   // To obtain the maps local point, we have converted the global
                      //   // point into local point using the marker render box. After that
                      //   // we have converted that point into latlng and updated it’s
                      //   // position.
                      //   final MapLatLng latLng = mapController.pixelToLatLng(
                      //       markerRenderBox
                      //           .globalToLocal(details.globalPosition));
                      //   mapMarkers[index] =
                      //       MapLatLng(latLng.latitude, latLng.longitude);
                      //   mapController.updateMarkers([index]);
                      // },
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
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              text: 'Simpan Lokasi',
              onPressed: () {},
            ),
          ),
        )
      ],
    );
  }
}

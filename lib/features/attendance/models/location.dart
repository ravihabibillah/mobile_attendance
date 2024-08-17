// To parse this JSON data, do
//
//     final hotelCityData = hotelCityDataFromJson(jsonString);

import 'dart:convert';

HotelCityData hotelCityDataFromJson(String str) =>
    HotelCityData.fromJson(json.decode(str));

String hotelCityDataToJson(HotelCityData data) => json.encode(data.toJson());

class HotelCityData {
  String? latitude;
  String? longitude;

  HotelCityData({
    this.latitude,
    this.longitude,
  });

  factory HotelCityData.fromJson(Map<String, dynamic> json) => HotelCityData(
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

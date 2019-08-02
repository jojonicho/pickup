import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationApiClient {
  static const baseUrl =
      'https://maps.googleapis.com/maps/api/place/nearbysearch';
  final http.Client httpClient;
  Location location = Location();

  LocationApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<List> getCourts() async {
    var pos = await location.getLocation();
    final latitude = pos.latitude;
    final longitude = pos.longitude;
    final locationUrl =
        '$baseUrl/json?location=$latitude,$longitude&radius=3500&keyword=basket&key=AIzaSyA6g7pytqXm3WEBzyDpbvJW2jEfxSPTDAk';
    final locationResponse = await this.httpClient.get(locationUrl);
    if (locationResponse.statusCode != 200) {
      throw Exception('error getting location');
    }

    final locationJson = jsonDecode(locationResponse.body) as List;
    return (locationJson.first)['Results'];
  }

// _animateToUser() async {
//   var pos = await location.getLocation();

//   mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//     target: LatLng(pos['latitude'], pos['longitude']),
//     zoom: 17.0,
//   )));
// }
}

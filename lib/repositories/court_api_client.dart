import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class CourtApiClient {
  static const baseUrl =
      'https://maps.googleapis.com/maps/api/place/nearbysearch';
  static const testUrl =
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-6.182412,106.734575&radius=3500&keyword=basket&key=AIzaSyA6g7pytqXm3WEBzyDpbvJW2jEfxSPTDAk';
  final http.Client httpClient;

  CourtApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future fetchCourts(location) async {
    final lat = location.latitude;
    final lng = location.longitude;
    final locationUrl =
        '$baseUrl/json?location=$lat,$lng&radius=3500&keyword=basket&key=AIzaSyA6g7pytqXm3WEBzyDpbvJW2jEfxSPTDAk';
    final locationResponse = await this.httpClient.get(locationUrl);
    if (locationResponse.statusCode != 200) {
      throw Exception('error getting location');
    }

    final locationJson = jsonDecode(locationResponse.body);
    //final courtsJson =  locationJson['Results'];
    return CourtList.fromJson(locationJson);
  }

// _animateToUser() async {
//   var pos = await location.getLocation();

//   mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//     target: LatLng(pos['latitude'], pos['longitude']),
//     zoom: 17.0,
//   )));
// }
}

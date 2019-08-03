import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:scratch/models/court.dart';
import 'package:scratch/widgets/widgets.dart';
import 'package:scratch/style.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final courts = Court.fetchAll();
    return Scaffold(
      appBar: AppBar(
        title: Text('PICKUP', style: defaultStyle),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      drawer: Drawer(),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition:
                CameraPosition(target: LatLng(-6, 106), zoom: 5),
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            myLocationButtonEnabled: false,
          ),
          Align(
            alignment: Alignment(0.00, 0.70),
            child: Card(
              //padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
              color: Colors.yellow[50],
              margin: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: ListView.builder(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  shrinkWrap: true,
                  itemCount: courts.length,
                  itemBuilder: (context, index) =>
                      _itemBuilder(context, courts[index]),
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_on),
        onPressed: _currentLocation,
        backgroundColor: Colors.indigo[300],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _currentLocation() async {
    final GoogleMapController controller = await _controller.future;
    LocationData currentLocation;
    var location = new Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }

    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 17.0,
      ),
    ));
  }

  _onLocationTap(BuildContext context, int courtID) {
    Navigator.pushNamed(context, CourtRoute, arguments: {"id": courtID});
  }

  _itemBuilder(BuildContext context, Court court) {
    return InkWell(
      onTap: () => _onLocationTap(context, court.id),
      child: GenerateCourt(court.name, court.address),
    );
  }
}

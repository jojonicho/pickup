import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:scratch/bloc/bloc.dart';
// import 'package:scratch/models/court.dart';
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
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('PICKUP', style: defaultStyle),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                // final court = await Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => CitySelection(),
                //   ),
                // );
                // if (court != null) {
                //   locationBloc.dispatch(FetchLocation(location: court));
                // }
              })
        ],
      ),
      drawer: Drawer(),
      body: Center(
        child:
            BlocBuilder<LocationBloc, LocationState>(builder: (context, state) {
          if (state is InitialLocationState) {
            locationBloc.dispatch(FetchLocation());
            return Center(child: Text('Welcome To Pickup'));
          }
          if (state is LocationLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is LocationLoaded) {
            // locationBloc.dispatch(FetchCourt(location: state.location));
            final location = state.location;
            return Stack(
              children: <Widget>[
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: LatLng(location.latitude, location.longitude),
                      zoom: 17),
                  myLocationEnabled: true,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  myLocationButtonEnabled: false,
                ),
                CourtListView(location: location)
              ],
            );
          }
          if (state is LocationError) {
            return RefreshIndicator(
              onRefresh: () {
                locationBloc.dispatch(FetchLocation());
                return null;
              },
              child: ListView(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                        child: Text(
                          'Something went wrong!',
                          style: TextStyle(color: Colors.red, fontSize: 18),
                        ),
                      ),
                      Text('Pull to refresh', style: TextStyle(fontSize: 14))
                    ],
                  ),
                ],
              ),
            );
          }
        }),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_on),
        onPressed: _currentLocation,
        backgroundColor: Colors.indigo[300],
      ),
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
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:scratch/bloc/bloc.dart';
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
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final courts = Court.fetchAll();
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
            return Stack(
              children: <Widget>[
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: LatLng(
                          state.location.latitude, state.location.longitude),
                      zoom: 7),
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
                        borderRadius: BorderRadius.circular(7)),
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
            );
          }
          if (state is LocationError) {
            return Text(
              'Something went wrong!',
              style: TextStyle(color: Colors.red),
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

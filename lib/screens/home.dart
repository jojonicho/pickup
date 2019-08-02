import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:scratch/models/court.dart';
import 'package:scratch/main.dart';
import 'package:scratch/repositories/location_api_client.dart';
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
            initialCameraPosition: CameraPosition(
              target: LatLng(2, 5),
            ),
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete();
            },
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
                  // children: courts.map((court) => InkWell(
                  //   onTap: () => _onLocationTap(context, court.id),
                  //   child: GenerateCourt(court.name, court.address),
                  // )).toList()
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_on),
        onPressed: _currentLocation,
        backgroundColor: Colors.deepPurple[400],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Future _currentLocation() async {
    final GoogleMapController controller = await _controller.future;
    final lolocation = await LocationApiClient.getCurrentLocation();
    controller.animateCamera(CameraUpdate.newCameraPosition(lolocation));
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

class GenerateCourt extends StatelessWidget {
  final String name;
  final String address;
  GenerateCourt(this.name, this.address);

  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
        child: Column(children: [
          Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      name,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Helvetica'),
                    ),
                  ),
                  Text(
                    address,
                    style: TextStyle(color: Colors.grey[500]),
                  )
                ],
              ),
            ),
            Favorite(),
          ]),
          Divider(
            height: 28,
            color: Colors.deepPurple[100],
          ),
        ]));
  }
}

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  bool _isFavorited = true;
  int _favoriteCount = Random.secure().nextInt(98);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Container(
        padding: EdgeInsets.all(0),
        child: IconButton(
          icon: (_isFavorited ? Icon(Icons.star) : Icon(Icons.star_border)),
          color: Colors.indigo[300],
          onPressed: _toggleFavorite,
        ),
      ),
      SizedBox(
        width: 18,
        child: Container(
          child: Text('$_favoriteCount'),
        ),
      ),
    ]);
  }

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }
}

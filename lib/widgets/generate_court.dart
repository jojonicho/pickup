import 'package:flutter/material.dart';
import 'dart:math';

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

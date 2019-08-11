// import 'package:flutter/material.dart';
// import 'package:scratch/style.dart';
// import 'package:scratch/models/models.dart';

// class CourtDetail extends StatelessWidget {
//   final int _courtID;
//   CourtDetail(this._courtID);

//   @override
//   Widget build(BuildContext context) {
//     final court = Court.fetchByID(_courtID);
//     return Scaffold(
//         backgroundColor: Colors.indigo[300],
//         appBar: AppBar(
//           elevation: 0,
//           title: Text(
//             court.name,
//             style: defaultStyle,
//           ),
//         ),
//         body: Stack(
//           children: <Widget>[
//             Positioned(
//               height: MediaQuery.of(context).size.height * 0.75,
//               width: MediaQuery.of(context).size.width * 0.95,
//               left: 10,
//               top: MediaQuery.of(context).size.height * 0.1,
//               child: Card(
//                   color: Colors.yellow[50],
//                   margin: EdgeInsets.all(10),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30)),
//                   elevation: 2,
//                   child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
//                           child: Text(
//                             court.address,
//                             style: defaultStyleBlack,
//                           ),
//                         )
//                       ])),
//             )
//           ],
//         ));
//   }
// }

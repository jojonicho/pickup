import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scratch/bloc/bloc.dart';
import 'package:scratch/models/court.dart';
import 'package:meta/meta.dart';

import 'widgets.dart';

class CourtListView extends StatefulWidget {
  final location;
  CourtListView({@required this.location}) : assert(location != null);
  @override
  _CourtListViewState createState() => _CourtListViewState();
}

class _CourtListViewState extends State<CourtListView> {
  @override
  Widget build(BuildContext context) {
    final courtBloc = BlocProvider.of<CourtBloc>(context);
    // final courts = Court.fetchAll();
    return Align(
      alignment: Alignment(0.00, 0.76),
      child: Card(
        //padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
        color: Colors.yellow[50],
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child:
                BlocBuilder<CourtBloc, CourtState>(builder: (context, state) {
              // if (state is LocationLoaded) {
              //   courtBloc.dispatch(FetchCourt(location: widget.location));
              // }
              if (state is InitialCourtState) {
                courtBloc.dispatch(FetchCourt(location: widget.location));
                return Center(child: Text('There seems to be nothing here'));
              }
              if (state is CourtLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is CourtLoaded) {
                return Center(child: Text('Loaded lol'));
              }
              if (state is CourtError) {
                return RefreshIndicator(
                  onRefresh: () {
                    courtBloc.dispatch(FetchCourt(location: widget.location));
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
                          Text('Pull to refresh',
                              style: TextStyle(fontSize: 14))
                        ],
                      ),
                    ],
                  ),
                );
              }
            })
            //     ListView.builder(
            //   padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            //   shrinkWrap: true,
            //   itemCount: courts.length,
            //   itemBuilder: (context, index) =>
            //       _itemBuilder(context, courts[index]),
            // ),
            ),
      ),
    );
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

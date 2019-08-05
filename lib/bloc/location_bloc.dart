import 'dart:async';
import 'package:location/location.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  @override
  LocationState get initialState => InitialLocationState();

  @override
  Stream<LocationState> mapEventToState(
    LocationEvent event,
  ) async* {
    if (event is FetchLocation) {
      yield LocationLoading();
      try {
        LocationData currentLocation;
        var pos = Location();
        try {
          currentLocation = await pos.getLocation();
        } on Exception {
          currentLocation = null;
        }
        final LocationData location = currentLocation;
        yield LocationLoaded(location: location);
      } catch (_) {
        yield LocationError();
      }
    }
  }
}

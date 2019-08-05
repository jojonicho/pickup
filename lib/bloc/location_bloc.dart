import 'dart:async';
import 'package:location/location.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:scratch/models/models.dart';
import 'package:scratch/repositories/repositories.dart';
import './bloc.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final CourtRepository courtRepository;

  LocationBloc({@required this.courtRepository})
      : assert(courtRepository != null);

  @override
  LocationState get initialState => LocationLoading();

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
        final List<Court> court =
            await CourtRepository.getNearCourts(currentLocation);
        yield LocationLoaded(court: court, location: location);
      } catch (_) {
        yield LocationError();
      }
    }
  }
}

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:location/location.dart';
import 'package:scratch/models/models.dart';
import 'package:scratch/repositories/repositories.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

class CourtBloc extends Bloc<CourtEvent, CourtState> {
  final CourtRepository courtRepository;

  CourtBloc({@required this.courtRepository}) : assert(courtRepository != null);

  @override
  CourtState get initialState => InitialCourtState();

  @override
  Stream<CourtState> mapEventToState(
    CourtEvent event,
  ) async* {
    if (event is FetchCourt) {
      yield CourtLoading();
      try {
        LocationData currentLocation = event.location;
        final CourtList court = await CourtRepository(
                courtApiClient: courtRepository.courtApiClient)
            .getNearCourts(currentLocation);
        yield CourtLoaded(court: court);
      } catch (error) {
        print(error.toString());
        yield CourtError();
      }
    }
  }
}

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scratch/models/models.dart';

@immutable
abstract class CourtState extends Equatable {
  CourtState([List props = const []]) : super(props);
}

class InitialCourtState extends CourtState {}

class CourtLoading extends CourtState {}

class CourtLoaded extends CourtState {
  final CourtList court;

  CourtLoaded({@required this.court})
      : assert(court != null),
        super([court]);
}

class CourtError extends CourtState {
  // final String error;

  // CourtError({@required this.error})
  //     : assert(error != null),
  //       super([error]);
}

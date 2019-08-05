import 'package:equatable/equatable.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CourtEvent extends Equatable {
  CourtEvent([List props = const []]) : super(props);
}

class FetchCourt extends CourtEvent {
  final LocationData location;
  FetchCourt({@required this.location})
      : assert(location != null),
        super([location]);
}

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LocationEvent extends Equatable {
  LocationEvent([List props = const []]) : super(props);
}

class FetchLocation extends LocationEvent {
  FetchLocation();
}

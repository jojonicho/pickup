import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LocationState extends Equatable {
  LocationState([List props = const []]) : super(props);
}

class InitialLocationState extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final LocationData location;

  LocationLoaded({@required this.location})
      : assert(location != null),
        super([location]);
}

class LocationError extends LocationState {}

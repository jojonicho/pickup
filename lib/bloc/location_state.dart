import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';
import 'package:scratch/models/models.dart';

@immutable
abstract class LocationState extends Equatable {
  LocationState([List props = const []]) : super(props);
}

class LocationEmpty extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final List<Court> court;
  final LocationData location;

  LocationLoaded({@required this.court, @required this.location})
      : assert(court != null, location != null),
        super([court, location]);
}

class LocationError extends LocationState {}

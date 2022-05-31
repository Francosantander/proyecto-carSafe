part of 'gps_bloc.dart';

abstract class GpsEvent extends Equatable {
  const GpsEvent();

  @override
  List<Object> get props => [];
}

// Evento que va a modificar el estado del permiso del gps

class GpsAndPermissionEvent extends GpsEvent {
  final bool isGpsEnable;
  final bool isGpsPermissionGranted;

//Constructor
  const GpsAndPermissionEvent({
    required this.isGpsEnable,
    required this. isGpsPermissionGranted
  });
}

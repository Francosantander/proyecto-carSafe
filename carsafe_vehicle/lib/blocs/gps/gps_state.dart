part of 'gps_bloc.dart';

class GpsState extends Equatable {
  // estado del gps
  final bool isGpsEnable;
  final bool isGpsPermissionGranted;

  bool get isAllGranted => isGpsEnable && isGpsPermissionGranted;

  // Constructor
  const GpsState(
      {required this.isGpsEnable, required this.isGpsPermissionGranted});

  // Vamos a regresar el valor del GpsState, si tenemos el valor en alguna de la variables, entonces usa ese valor
  // Si no tiene ningun valor, usamos el valor que se coloca por defecto
  GpsState copywith({bool? isGpsEnable, bool? isGpsPermissionGranted}) =>
      GpsState(
          isGpsEnable: isGpsEnable ?? this.isGpsEnable,
          isGpsPermissionGranted:
              isGpsPermissionGranted ?? this.isGpsPermissionGranted);

  @override
  List<Object> get props => [isGpsEnable, isGpsPermissionGranted];

  @override
  String toString() =>
      '{ isGpsEnable: $isGpsEnable, isGpsPermissionGranted: $isGpsPermissionGranted }';
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
part 'gps_event.dart';
part 'gps_state.dart';

//Logica de lo que sucede cuando recibo un evento del tipo GpsBloc
// Este evento al llamarlo va a cambiar los valores del evento
class GpsBloc extends Bloc<GpsEvent, GpsState> {
  StreamSubscription? gpsServiceSubscription;
  GpsBloc()
      : super(
            const GpsState(isGpsEnable: false, isGpsPermissionGranted: false)) {
    on<GpsAndPermissionEvent>((event, emit) => emit(state.copywith(
        isGpsEnable: event.isGpsEnable,
        isGpsPermissionGranted: event.isGpsPermissionGranted)));
    _init();
  }

// Metodo que nos devuelve la informacion del geolocator
  Future<void> _init() async {
    final gpsInitialStatus = await Future.wait([
      _checkGpsStatus(),
      _isPermissionGranted(),
    ]);

    add(GpsAndPermissionEvent(
        isGpsEnable: gpsInitialStatus[0],
        isGpsPermissionGranted: gpsInitialStatus[1]));
  }

  Future<bool> _isPermissionGranted() async {
    final isGranted = await Permission.location.isGranted;
    return isGranted;
  }

// Tenemos un listen que esta pendiente de cualquier cambio del gps
  Future<bool> _checkGpsStatus() async {
    // Aca sabemos cual es el estado del gps apenas carga la aplicacion
    // Imprimo en pantalla la ubicacion del dispositivo, la ubicacion se actualiza cada 100 segundos
    final isEnable = await Geolocator.isLocationServiceEnabled();
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100);
    StreamSubscription<Position> positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen(
    (Position? position) {
        print(position == null ? 'Unknown' : 'latitud: ${position.latitude.toString()}, longuitud: ${position.longitude.toString()}');
    });
    // Aca sabemos cuando el estado del gps cambia
    gpsServiceSubscription =
        Geolocator.getServiceStatusStream().listen((event) {
      final isEnable = (event.index == 1) ? true : false;
      add(GpsAndPermissionEvent(
          isGpsEnable: isEnable,
          isGpsPermissionGranted: state.isGpsPermissionGranted));
    });
    return isEnable;
  }

  Future<void> askGpsAccess() async {
    final status = await Permission.location.request();
    switch (status) {
      case PermissionStatus.granted:
        add(GpsAndPermissionEvent(
            isGpsEnable: state.isGpsEnable, isGpsPermissionGranted: true));
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        add(GpsAndPermissionEvent(
            isGpsEnable: state.isGpsEnable, isGpsPermissionGranted: false));
        openAppSettings();
        break;
      default:
    }
  }

  @override
  Future<void> close() {
    gpsServiceSubscription?.cancel();
    return super.close();
  }
}

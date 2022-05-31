import 'package:carsafe/blocs/blocs.dart';
import 'package:carsafe/screens/gps_access_screen.dart';
import 'package:carsafe/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) {
          return state.isAllGranted
              ? const MapScreen()
              : const GpsAccessScreen();
        },
      ),
    );
  }
}

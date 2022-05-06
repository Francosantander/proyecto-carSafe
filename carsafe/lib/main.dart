import 'package:carsafe/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/gps/gps_bloc.dart';
// Inicializo la aplicacion llamando al metodo GPSBLOC
void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GpsBloc())
      ],
      child: const CarSafe(),
    )
    );
  }

class CarSafe extends StatelessWidget {
  const CarSafe({Key? key}) : super(key: key);
// Cargo la pagina de inicio
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CarSafe',
        home: LoadingScreen());
  }
}

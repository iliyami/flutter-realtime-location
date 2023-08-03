import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_socket_test/feature/location/presenter/bloc/location_bloc.dart';
import 'package:location_socket_test/feature/location/presenter/map_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebSocket Map Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<LocationBloc>(
        create: (context) => LocationBloc(context),
        child: const MapPage(),
      ),
    );
  }
}

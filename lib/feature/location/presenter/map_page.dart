import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location_socket_test/feature/location/presenter/bloc/location_bloc.dart';
import 'package:location_socket_test/feature/location/presenter/bloc/states/location_states.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Locations on Map'),
      ),
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case LocationInitialState:
              return const Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.blue,
                ),
              );
            case LocationFilledState:
              debugPrint('UI: ${state.locations.length}');
              return FlutterMap(
                options: MapOptions(
                  center: LatLng(
                    state.locations.first.lat,
                    state.locations.first.long,
                  ),
                  zoom: 10,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  MarkerLayer(
                    markers: [
                      ...state.locations.map((loc) => Marker(
                            point: LatLng(loc.lat, loc.long),
                            width: 48,
                            height: 48,
                            builder: (context) =>
                                Image.asset('assets/images/marker.png'),
                          ))
                    ],
                  )
                ],
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}

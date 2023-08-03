import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:location_socket_test/core/constants/urls/error_messages.dart';
import 'package:location_socket_test/core/constants/urls/urls.dart';
import 'package:location_socket_test/feature/location/data/models/location_model.dart';
import 'package:location_socket_test/feature/location/presenter/bloc/events/location_events.dart';
import 'package:location_socket_test/feature/location/presenter/bloc/states/location_states.dart';
import 'package:web_socket_channel/io.dart';

class LocationBloc extends Bloc<LocationSocketEvent, LocationState> {
  late final IOWebSocketChannel _webSocketChannel;
  final BuildContext context;
  final List<LocationModel> _locations = [];

  LocationBloc(this.context) : super(LocationInitialState()) {
    _webSocketChannel = IOWebSocketChannel.connect(
      Urls.baseWsUrl + Urls.locationsWs,
    );

    _webSocketChannel.ready.then(_onLocationSocketConnected);

    on<LocationSocketConnected>((event, emit) {
      emit(LocationLoadingState());
      ScaffoldMessenger.of(context).showSnackBar(
        _successSnack('Connection Established Successfully!'),
      );
    });

    on<LocationSocketReceivingData>((event, emit) {
      emit(LocationFilledState([..._locations]));
    });

    on<LocationSocketDisconnected>((event, emit) {
      ScaffoldMessenger.of(context).showSnackBar(
        _successSnack('All Locations Recieved!'),
      );
    });
  }

  void _onLocationSocketConnected(_) {
    add(LocationSocketConnected());
    final subscription = _webSocketChannel.stream.listen((data) {
      debugPrint(data);
      final newLocation = LocationModel.fromSocketChannel(data);
      if (newLocation == null) return;
      _locations.add(newLocation);
      add(LocationSocketReceivingData());
    });
    subscription.onError(
      (e) => debugPrint('${APIErrorMessages.socketError} $e'),
    );
    subscription.onDone(() {
      add(LocationSocketDisconnected());
    });
  }

  SnackBar _successSnack(String text) {
    return SnackBar(
      content: Text(text),
      backgroundColor: Colors.green,
    );
  }

  @override
  Future<void> close() {
    _webSocketChannel.sink.close();
    return super.close();
  }
}

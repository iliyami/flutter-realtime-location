import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:location_socket_test/core/constants/urls/error_messages.dart';

class LocationModel extends Equatable {
  const LocationModel({required this.lat, required this.long});
  final double lat;
  final double long;

  static LocationModel? fromSocketChannel(data) {
    try {
      if (data is String) {
        final latLong = data.toString().split(',');
        final lat = double.tryParse(latLong.first);
        final long = double.tryParse(latLong.last);
        if (lat == null || long == null) {
          throw Exception(APIErrorMessages.typeError);
        }
        return LocationModel(lat: lat, long: long);
      }

      throw Exception(APIErrorMessages.typeError);
    } catch (e) {
      debugPrint('$e');
    }
    return null;
  }

  @override
  List<Object?> get props => [lat, long];
}

import 'package:equatable/equatable.dart';
import 'package:location_socket_test/feature/location/data/models/location_model.dart';

sealed class LocationState extends Equatable {
  const LocationState(this.locations);
  final List<LocationModel> locations;

  @override
  List<Object?> get props => [locations];
}

final class LocationInitialState extends LocationState {
  LocationInitialState() : super([]);
}

final class LocationLoadingState extends LocationState {
  LocationLoadingState() : super([]);
}

final class LocationFilledState extends LocationState {
  const LocationFilledState(super.locations);
}

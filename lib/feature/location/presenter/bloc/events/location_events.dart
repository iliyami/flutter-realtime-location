sealed class LocationSocketEvent {}

final class LocationSocketConnected extends LocationSocketEvent {}

final class LocationSocketReceivingData extends LocationSocketEvent {}

final class LocationSocketDisconnected extends LocationSocketEvent {}

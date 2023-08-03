# location_socket_test
This project demonstrates how to connect to a WebSocket server and display locations on a map using Flutter.

## Requirements

* Flutter SDK
* flutter_map
* web_socket_channel
* flutter_bloc

## Usage

1. Clone the repository.
2. Install the dependencies.
3. Run the application.

The application will connect to the WebSocket server and display four locations on a map.

## Code

The code for the application is available in the `lib` directory. The `LocationsBloc` class handles WebSocket events, such as `LocationsConnected` and `LocationsError`. The `LocationsState` class represents the state of the application, which includes the list of locations. The `MapView` widget displays the map and the markers.

## License

This project is licensed under the MIT License.


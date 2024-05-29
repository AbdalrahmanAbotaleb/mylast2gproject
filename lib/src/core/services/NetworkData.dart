import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<ConnectivityResult> get onConnectivityChanged;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;
  late final StreamController<bool> _connectionChangeController;
  late bool _previousConnected = true;
  late Timer _timer;

  NetworkInfoImpl(this.connectivity) {
    _connectionChangeController = StreamController<bool>.broadcast(
      onListen: () {
        _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) async {
          final connected = await isConnected;
          if (connected != _previousConnected) {
            _connectionChangeController.add(connected);
            _previousConnected = connected;
          }
        });
      },
      onCancel: () {
        _timer.cancel();
        _connectionChangeController.close();
      },
    );
  }

  @override
  Future<bool> get isConnected async {
    final result = await connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  @override
  Stream<ConnectivityResult> get onConnectivityChanged =>
      connectivity.onConnectivityChanged;
}

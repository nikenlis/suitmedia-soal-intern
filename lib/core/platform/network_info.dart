

import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> isConnected();
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl({required this.connectivity});


  @override
  Future<bool> isConnected() async {
   final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
   if (connectivityResult.contains(ConnectivityResult.mobile) || connectivityResult.contains(ConnectivityResult.wifi)){
    return true;
   }
   return false;
  }
}
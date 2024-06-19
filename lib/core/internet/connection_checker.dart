import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectionChecker {
  final InternetConnectionChecker _internet = InternetConnectionChecker();

   Future<bool> get isConnected async  => await _internet.hasConnection ;

}
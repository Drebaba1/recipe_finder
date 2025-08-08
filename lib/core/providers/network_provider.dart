import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

final networkProvider = Provider<Connectivity>((ref) {
  return Connectivity();
});

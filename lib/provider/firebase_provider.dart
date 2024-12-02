import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:city_guide/services/city_guide_services.dart';

final firebaseServiceProvider = Provider<CityGuideServices>((ref) {
  return CityGuideServices();
});
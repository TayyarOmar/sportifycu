import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:sportify_app/api/gym_api.dart';
import 'package:sportify_app/models/gym.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sportify_app/utils/web_location.dart'
    if (dart.library.html) 'dart:html' as html;

class GymProvider with ChangeNotifier {
  final GymApi _gymApi = GymApi();

  List<Gym> _nearbyGyms = [];
  List<Gym> get nearbyGyms => _nearbyGyms;

  List<Gym> _allGyms = [];
  List<Gym> get allGyms => _allGyms;

  bool _isLoadingNearby = false;
  bool get isLoadingNearby => _isLoadingNearby;

  bool _isLoadingAll = false;
  bool get isLoadingAll => _isLoadingAll;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Position? _currentLocation;
  Position? get currentLocation => _currentLocation;

  Future<void> fetchNearbyGyms() async {
    _isLoadingNearby = true;
    _errorMessage = null;
    notifyListeners();

    try {
      Position position = await _determinePosition();
      _currentLocation = position;
      // Fetch gyms with a 50km radius
      _nearbyGyms = await _gymApi.getGymsAroundYou(
          position.latitude, position.longitude,
          radius: 50000);
    } catch (e) {
      _errorMessage = e.toString().replaceFirst("Exception: ", "");
    } finally {
      _isLoadingNearby = false;
      notifyListeners();
    }
  }

  Future<void> fetchAllGyms() async {
    _isLoadingAll = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _allGyms = await _gymApi.getAllGyms();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoadingAll = false;
      notifyListeners();
    }
  }

  /// Determine the current position of the device.
  ///
  /// When location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}

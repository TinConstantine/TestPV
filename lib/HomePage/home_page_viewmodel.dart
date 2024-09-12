import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_app/api/Api.dart';

import '../model/auto_suggest_address.dart';

class HomePageViewmodel extends ChangeNotifier {
  Timer? _debounce;
  bool _isLoading = false;
  AutoSuggestAddress? _autoSuggestAddress;

  get isLoading => _isLoading;

  // get autoSuggestAddress => _autoSuggestAddress ?? AutoSuggestAddress();

  AutoSuggestAddress autoSuggestAddress() =>
      _autoSuggestAddress ?? AutoSuggestAddress();

  void setLoading(bool b) {
    _isLoading = b;
    notifyListeners();
  }


  void queryResult(String query, Position? p) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 1000),
      () async {
        try {
          _isLoading = true;
          notifyListeners();
          print(p.toString());
          _autoSuggestAddress = await MapAppApi().getAutoSuggestAddress(
              lat: p?.latitude.toString() ?? "0",
              lon: p?.longitude.toString() ?? "0",
              q: query);
        } catch (e) {
          print("Error: $e");
        } finally {
          _isLoading = false;
          notifyListeners();
        }
      },
    );
  }

  Future<Position?> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Location services are disable");
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Location permissions are denied");
        return null;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      print(
          'Location permissions are permanently denied, we cannot request permissions.');
      return null;
    }
    return await Geolocator.getCurrentPosition();
  }

  void clear(TextEditingController controller){
    controller.clear();
    _autoSuggestAddress = AutoSuggestAddress();
    notifyListeners();
  }
}

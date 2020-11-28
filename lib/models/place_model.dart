import 'package:flutter/foundation.dart';
import 'dart:io';

class PlaceLocation {
  final double latidute;
  final double longitude;
  final String address;

  const PlaceLocation({
    @required this.longitude,
    @required this.latidute,
    this.address,
  });
}

class PlaceModel {
  final String id;
  final String title;
  final PlaceLocation location;
  final File image;

  PlaceModel({
    @required this.id,
    @required this.title,
    @required this.image,
    @required this.location,
  });
}

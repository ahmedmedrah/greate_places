import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:greate_places/helpers/db_helper.dart';
import 'package:greate_places/helpers/location_helper.dart';
import 'package:greate_places/models/place_model.dart';

class PlacesProvider with ChangeNotifier {
  List<PlaceModel> _items = [];

  List<PlaceModel> get items {
    return [..._items];
  }

  Future addPlace(String title, File image, PlaceLocation location) async {
    final address = await LocationHelper.getPlaceAddress(
        location.latidute, location.longitude);
    final updatedLocation = PlaceLocation(
        longitude: location.longitude,
        latidute: location.latidute,
        address: address);
    final newPlace = PlaceModel(
      id: DateTime.now().toString(),
      title: title,
      image: image,
      location: updatedLocation,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latidute,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.fetchData('places');
    _items = dataList
        .map((e) => PlaceModel(
              id: e['id'],
              title: e['title'],
              image: File(e['image']),
              location: PlaceLocation(
                latidute: e['loc_lat'],
                longitude: e['loc_lng'],
                address: e['address'],
              ),
            ))
        .toList();
    notifyListeners();
  }

  PlaceModel findById(String id){
    return _items.firstWhere((element) => element.id == id);
}
}

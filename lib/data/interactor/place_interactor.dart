import 'dart:async';

import 'package:places/data/model/place.dart';
import 'package:places/data/model/search_model.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/service/api_client.dart';

class PlaceInteractor {
  static final PlaceInteractor _singleton = PlaceInteractor._();

  final favorites = <Place>[];
  final visit = <Place>[];
  final searchResult = <Place>[];

  late final PlaceRepository _placeRepository =
      PlaceRepository(ApiClient().createDio());

  factory PlaceInteractor() => _singleton;

  PlaceInteractor._();

  Future<void> searchPlaces() async {
    final result = await _placeRepository.getPlaceList(SearchModel());
    searchResult
      ..clear()
      ..addAll(result);
  }

  Future<List<Place>> getPlaces() async {
    return _placeRepository.getPlaceList(SearchModel());
  }

  Future<Place> getPlaceDetails(int id) => _placeRepository.getPlace(id);

  Future<void> addNewPlace(Place place) => _placeRepository.createPlace(place);

  Future<List<Place>> getFavoritesPlace() async {
    return favorites;
  }

  Future<List<Place>> getVisitPlaces() async {
    return visit;
  }

  Future<void> addToVisitingPLaces(Place place) async {
    favorites.add(place);
  }

  Future<void> removeFromVisit(Place place) async {
    favorites.remove(place);
  }
}

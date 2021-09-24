import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';

abstract class SearchAction {}

class GetSearchResultAction extends SearchAction {
  final String search;
  final RangeValues range;

  GetSearchResultAction({required this.search, required this.range});
}

class LoadedSearchResultAction extends SearchAction {
  final List<Place> result;

  LoadedSearchResultAction(this.result);
}

class GetSearchHistoryAction extends SearchAction {}

class LoadedSearchHistoryAction extends SearchAction {
  final List<String> result;

  LoadedSearchHistoryAction(this.result);
}

class RemoveRequestFromHistoryAction extends SearchAction {
  final int index;

  RemoveRequestFromHistoryAction(this.index);
}

class ClearHistorySearchAction extends SearchAction {}

class SearchErrorAction extends SearchAction {}

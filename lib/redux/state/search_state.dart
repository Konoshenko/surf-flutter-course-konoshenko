import 'package:places/data/model/place.dart';

abstract class SearchState {
  const SearchState();
}

class SearchInitialState extends SearchState {
  const SearchInitialState();
}

class SearchLoadingState extends SearchState {
  const SearchLoadingState();
}

class SearchResultState extends SearchState {
  final List<Place> result;

  const SearchResultState(this.result);
}

class SearchResultHistoryState extends SearchState {
  final List<String> result;

  const SearchResultHistoryState(this.result);
}

import 'package:places/redux/action/search_action.dart';
import 'package:places/redux/app_state.dart';
import 'package:places/redux/state/search_state.dart';

AppState getSearchResultReducer(
  AppState state,
  GetSearchResultAction _,
) =>
    state.copyWith(searchState: const SearchLoadingState());

AppState loadedSearchResultReducer(
  AppState state,
  LoadedSearchResultAction action,
) =>
    state.copyWith(searchState: SearchResultState(action.result));

AppState getSearchHistoryReducer(
  AppState state,
  GetSearchHistoryAction _,
) =>
    state.copyWith(searchState: const SearchLoadingState());

AppState loadedSearchHistoryReducer(
  AppState state,
  LoadedSearchHistoryAction action,
) =>
    state.copyWith(searchState: SearchResultHistoryState(action.result));

AppState removeRequestFromHistoryReducer(
  AppState state,
  RemoveRequestFromHistoryAction _,
) =>
    state.copyWith(searchState: const SearchLoadingState());

AppState clearHistorySearchReducer(
  AppState state,
  ClearHistorySearchAction _,
) =>
    state.copyWith(searchState: const SearchLoadingState());

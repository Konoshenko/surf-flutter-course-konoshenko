part of 'visited_list_bloc.dart';

@immutable
abstract class VisitedListState extends Equatable {}

class VisitedListData extends VisitedListState {
  final Set<Place> places;

  @override
  List<Object?> get props => [places];

  VisitedListData(this.places);
}

class VisitedListLoading extends VisitedListState {
  @override
  List<Object?> get props => [];
}

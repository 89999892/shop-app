part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}
class SearchSuccessState extends SearchState {
  SearchModel searchModel;
  SearchSuccessState(this.searchModel);
}
class SearchLoadingState extends SearchState {}
class SearchErrorState extends SearchState {}
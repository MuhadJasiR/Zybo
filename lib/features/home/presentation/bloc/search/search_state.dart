part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Product> products;
  SearchLoaded(this.products);
  @override
  List<Object> get props => [products];
}

class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
  @override
  List<Object> get props => [message];
}

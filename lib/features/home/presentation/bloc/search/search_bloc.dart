import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:zybo/features/home/domain/entities/product.dart';
import 'package:zybo/features/home/domain/usecase/search_product.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchProduct searchProduct;
  Timer? _debounce;
  SearchBloc(this.searchProduct) : super(SearchInitial()) {
    on<SearchQueryChanged>(_onSearchQueryChanged);
  }

  void _onSearchQueryChanged(
      SearchQueryChanged event, Emitter<SearchState> emit) async {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {});

    final query = event.query.trim();
    if (query.isEmpty) {
      emit(SearchInitial());
    }

    emit(SearchLoading());

    try {
      final product = await searchProduct(query);
      if (!emit.isDone) emit(SearchLoaded(product));
    } catch (e) {
      log(e.toString(), name: "search error");
      if (!emit.isDone) emit(SearchError("An error occurred while searching"));
    }
  }
}

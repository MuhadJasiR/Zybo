import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svg_flutter/svg.dart';
import 'package:zybo/core/theme/app_color.dart';
import 'package:zybo/features/home/presentation/bloc/search/search_bloc.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    super.key,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _searchController = TextEditingController();

  Timer? _debounce;
  @override
  initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 500),
      () {
        log("Search event triggered with: ${_searchController.text}");
        BlocProvider.of<SearchBloc>(context)
            .add(SearchQueryChanged(_searchController.text));
      },
    );
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 20),
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: AppColor.greyColor),
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            height: 25,
            width: 1.2,
            color: AppColor.blackColor,
          ),
          GestureDetector(
              onTap: () {
                log("hy...");
                BlocProvider.of<SearchBloc>(context)
                    .add(SearchQueryChanged(_searchController.text.trim()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SvgPicture.asset("assets/icon/search.svg"),
              ))
        ],
      ),
    );
  }
}

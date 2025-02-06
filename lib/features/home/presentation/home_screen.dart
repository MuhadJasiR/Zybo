import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zybo/core/theme/app_color.dart';
import 'package:zybo/core/theme/const_size.dart';
import 'package:zybo/features/home/domain/entities/product.dart';
import 'package:zybo/features/home/presentation/bloc/banner/banner_bloc.dart';
import 'package:zybo/features/home/presentation/bloc/product/product_bloc.dart';
import 'package:zybo/features/home/presentation/bloc/search/search_bloc.dart';
import 'package:zybo/features/home/presentation/widgets/product_card.dart';
import 'package:zybo/features/home/presentation/widgets/search_bar.dart';
import 'package:zybo/features/home/presentation/widgets/top_banner.dart';
import 'package:zybo/init_dependencies.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) =>
                      serviceLocator<ProductBloc>()..add(LoadProducts()),
                ),
                BlocProvider(
                  create: (context) =>
                      serviceLocator<BannerBloc>()..add(FetchBanner()),
                ),
                BlocProvider(
                  create: (context) => serviceLocator<SearchBloc>(),
                )
              ],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomSearchBar(),
                  kHeight(24),
                  const TopBanner(),
                  kHeight(20),
                  BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, searchState) {
                      if (searchState is SearchLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (searchState is SearchLoaded) {
                        return _buildProductGrid(searchState.products);
                      } else if (searchState is SearchError) {
                        return const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "No item found",
                              style: TextStyle(
                                  color: AppColor.primaryColor,
                                  fontWeight: FontWeight.w500),
                            ),
                            Icon(
                              Icons.shopping_bag_outlined,
                              color: AppColor.primaryColor,
                            )
                          ],
                        );
                      } else {
                        return BlocBuilder<ProductBloc, ProductState>(
                            builder: (context, state) {
                          if (state is ProductLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is ProductLoaded) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Popular Product',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                kHeight(20),
                                _buildProductGrid(state.products),
                                const Text('Latest Products',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                kHeight(20),
                                _buildProductGrid(state.products),
                              ],
                            );
                          } else if (state is ProductError) {
                            return Center(child: Text(state.message));
                          }
                          return const Center(
                              child: Text("No Products Available"));
                        });
                      }
                    },
                  ),
                  kHeight(90)
                ],
              )),
        ),
      )),
    );
  }

  Widget _buildProductGrid(List<Product> products) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      childAspectRatio: 0.75,
      children: products
          .map(
            (products) => ProductCard(
              products: products,
              isInWishlist: false,
            ),
          )
          .toList(),
    );
  }
}

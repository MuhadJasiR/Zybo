import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zybo/core/theme/const_size.dart';
import 'package:zybo/features/home/presentation/widgets/product_card.dart';
import 'package:zybo/features/wishlist/presentation/bloc/bloc/wishlist_bloc.dart';
import 'package:zybo/features/wishlist/presentation/widget/no_Item_wishlist_icon_text.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    _loadWishlist();
    super.initState();
  }

  Future<void> _loadWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token") ?? "";

    context.read<WishlistBloc>().add(LoadWishList(token));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Wishlist",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: BlocBuilder<WishlistBloc, WishlistState>(
          builder: (context, state) {
            if (state is WishListLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WishlistLoaded) {
              if (state.wishList.isEmpty) {
                return const NoItemWishListIconText();
              }
              return SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        kHeight(30),
                        _buildProductGrid(state.wishList),
                      ],
                    )),
              );
            } else if (state is WishlistError) {
              return Center(
                child: Text(state.message),
              );
            }
            return const NoItemWishListIconText();
          },
        ),
      ),
    );
  }

  Widget _buildProductGrid(List<dynamic> products) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 0.75,
      children: products
          .map(
              (products) => ProductCard(products: products, isInWishlist: true))
          .toList(),
    );
  }
}

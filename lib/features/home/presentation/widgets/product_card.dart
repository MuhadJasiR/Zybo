// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:svg_flutter/svg.dart';
import 'package:zybo/core/theme/app_color.dart';
import 'package:zybo/core/theme/const_size.dart';
import 'package:zybo/features/home/domain/entities/product.dart';
import 'package:zybo/features/wishlist/presentation/bloc/bloc/wishlist_bloc.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.products,
    required this.isInWishlist,
  });

  final Product products;
  final bool isInWishlist;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late bool isWishListed;

  @override
  void initState() {
    super.initState();
    isWishListed = widget.isInWishlist;
  }

  Future<void> _toggleWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token") ?? "";
    context
        .read<WishlistBloc>()
        .add(ToggleWishlist(widget.products.id.toString(), token));
    setState(() {
      isWishListed = !isWishListed;
    });

    await Fluttertoast.showToast(
        msg: isWishListed ? "Added to wishlist" : "Removed from wishlist",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);

    context.read<WishlistBloc>().add(LoadWishList(token));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            SizedBox(
                height: 180,
                width: double.infinity,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                        fit: BoxFit.cover, widget.products.imageUrl[0]))),
            Positioned(
                top: 10,
                right: 10,
                child: InkWell(
                    onTap: _toggleWishlist,
                    child: SvgPicture.asset(isWishListed
                        ? "assets/icon/dislike.svg"
                        : "assets/icon/like.svg"))),
          ],
        ),
        kHeight(5),
        Row(
          children: [
            Text(
              "${widget.products.oldPrice}",
              style: const TextStyle(decoration: TextDecoration.lineThrough),
            ),
            kWidth(5),
            Text(
              "${widget.products.price}",
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primaryColor),
            ),
            const Spacer(),
            const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            kWidth(5),
            Text("${widget.products.rating}"),
            kWidth(5),
          ],
        ),
        kHeight(5),
        Expanded(
          child: Text(
            widget.products.name,
            style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }
}

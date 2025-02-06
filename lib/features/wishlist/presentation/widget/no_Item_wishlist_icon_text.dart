import 'package:flutter/material.dart';
import 'package:zybo/core/theme/app_color.dart';
import 'package:zybo/core/theme/const_size.dart';

class NoItemWishListIconText extends StatelessWidget {
  const NoItemWishListIconText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            size: 40,
            Icons.shopping_bag_outlined,
            color: AppColor.primaryColor,
          ),
          kWidth(5),
          const Text(
            "No items in wishlist!",
            style: TextStyle(
                color: AppColor.primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 20),
          ),
        ],
      ),
    );
  }
}

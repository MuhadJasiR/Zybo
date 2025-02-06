import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zybo/core/theme/app_color.dart';

import '../../../../core/theme/const_size.dart';

class ShimmerBannerLoading extends StatelessWidget {
  const ShimmerBannerLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 130.0,
      child: Shimmer.fromColors(
          baseColor: AppColor.greyColor,
          highlightColor: AppColor.whiteColor,
          child: Container(
            decoration: BoxDecoration(
                color: AppColor.greyColor,
                borderRadius: BorderRadius.circular(10)),
          )),
    );
  }
}

class ProductShimmerLoading extends StatelessWidget {
  const ProductShimmerLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 150,
                  height: 150.0,
                  child: Shimmer.fromColors(
                      baseColor: AppColor.greyColor,
                      highlightColor: AppColor.whiteColor,
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColor.greyColor,
                            borderRadius: BorderRadius.circular(10)),
                      )),
                ),
                kHeight(5),
                SizedBox(
                  width: 150,
                  height: 25.0,
                  child: Shimmer.fromColors(
                      baseColor: AppColor.greyColor,
                      highlightColor: AppColor.whiteColor,
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColor.greyColor,
                            borderRadius: BorderRadius.circular(10)),
                      )),
                ),
                kHeight(5),
                SizedBox(
                  width: 100,
                  height: 10.0,
                  child: Shimmer.fromColors(
                      baseColor: AppColor.greyColor,
                      highlightColor: AppColor.whiteColor,
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColor.greyColor,
                            borderRadius: BorderRadius.circular(10)),
                      )),
                ),
              ],
            ),
            kWidth(15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 150,
                  height: 150.0,
                  child: Shimmer.fromColors(
                      baseColor: AppColor.greyColor,
                      highlightColor: AppColor.whiteColor,
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColor.greyColor,
                            borderRadius: BorderRadius.circular(10)),
                      )),
                ),
                kHeight(5),
                SizedBox(
                  width: 150,
                  height: 25.0,
                  child: Shimmer.fromColors(
                      baseColor: AppColor.greyColor,
                      highlightColor: AppColor.whiteColor,
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColor.greyColor,
                            borderRadius: BorderRadius.circular(10)),
                      )),
                ),
                kHeight(5),
                SizedBox(
                  width: 100,
                  height: 10.0,
                  child: Shimmer.fromColors(
                      baseColor: AppColor.greyColor,
                      highlightColor: AppColor.whiteColor,
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColor.greyColor,
                            borderRadius: BorderRadius.circular(10)),
                      )),
                ),
              ],
            ),
          ],
        ),
        kHeight(15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 150,
                  height: 150.0,
                  child: Shimmer.fromColors(
                      baseColor: AppColor.greyColor,
                      highlightColor: AppColor.whiteColor,
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColor.greyColor,
                            borderRadius: BorderRadius.circular(10)),
                      )),
                ),
                kHeight(5),
                SizedBox(
                  width: 150,
                  height: 25.0,
                  child: Shimmer.fromColors(
                      baseColor: AppColor.greyColor,
                      highlightColor: AppColor.whiteColor,
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColor.greyColor,
                            borderRadius: BorderRadius.circular(10)),
                      )),
                ),
                kHeight(5),
                SizedBox(
                  width: 100,
                  height: 10.0,
                  child: Shimmer.fromColors(
                      baseColor: AppColor.greyColor,
                      highlightColor: AppColor.whiteColor,
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColor.greyColor,
                            borderRadius: BorderRadius.circular(10)),
                      )),
                ),
              ],
            ),
            kWidth(15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 150,
                  height: 150.0,
                  child: Shimmer.fromColors(
                      baseColor: AppColor.greyColor,
                      highlightColor: AppColor.whiteColor,
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColor.greyColor,
                            borderRadius: BorderRadius.circular(10)),
                      )),
                ),
                kHeight(5),
                SizedBox(
                  width: 150,
                  height: 25.0,
                  child: Shimmer.fromColors(
                      baseColor: AppColor.greyColor,
                      highlightColor: AppColor.whiteColor,
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColor.greyColor,
                            borderRadius: BorderRadius.circular(10)),
                      )),
                ),
                kHeight(5),
                SizedBox(
                  width: 100,
                  height: 10.0,
                  child: Shimmer.fromColors(
                      baseColor: AppColor.greyColor,
                      highlightColor: AppColor.whiteColor,
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColor.greyColor,
                            borderRadius: BorderRadius.circular(10)),
                      )),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

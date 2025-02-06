import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zybo/core/theme/app_color.dart';
import 'package:zybo/core/theme/const_size.dart';
import 'package:zybo/features/home/presentation/bloc/banner/banner_bloc.dart';

class TopBanner extends StatefulWidget {
  const TopBanner({
    super.key,
  });

  @override
  State<TopBanner> createState() => _TopBannerState();
}

class _TopBannerState extends State<TopBanner> {
  int currentImage = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannerBloc, BannerState>(
      builder: (context, state) {
        if (state is BannerLoading) {
          return SizedBox();
        } else if (state is BannerLoaded) {
          return Column(
            children: [
              CarouselSlider.builder(
                options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentImage = index;
                    });
                  },
                  autoPlay: false,
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                  aspectRatio: 20 / 9,
                ),
                itemCount: state.banners.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        SizedBox(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                        fit: BoxFit.fill, state.banners[itemIndex].imageUrl),
                  ),
                ),
              ),
              kHeight(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  state.banners.length,
                  (index) {
                    return indicator(index, currentImage);
                  },
                ),
              ),
            ],
          );
        } else if (state is BannerError) {
          return Center(child: Text(state.message));
        }
        return const Center(child: Text("No Banners Available"));
      },
    );
  }

  Widget indicator(int index, int currentImage) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      height: 10,
      width: currentImage == index ? 20 : 10,
      decoration: BoxDecoration(
          color: currentImage == index
              ? AppColor.blackColor
              : AppColor.greyColor100,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
    );
  }
}

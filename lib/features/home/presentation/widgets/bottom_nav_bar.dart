import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:zybo/core/theme/app_color.dart';
import 'package:zybo/features/home/presentation/home_screen.dart';
import 'package:zybo/features/profile/presentation/profile_screen.dart';
import 'package:zybo/features/wishlist/presentation/wishlist_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              HomeScreen(),
              WishlistScreen(),
              ProfileScreen(),
            ],
          ),
          Positioned(
            bottom: 5,
            child: Container(
              width: size.width - 35,
              height: 70,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem("assets/icon/home.svg", "Home", 0),
                  _buildNavItem("assets/icon/Like Button.svg", "WishList", 1),
                  _buildNavItem("assets/icon/profile.svg", "Profile", 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: isSelected
            ? BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(30),
              )
            : null,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: isSelected ? AppColor.whiteColor : AppColor.greyColor,
            ),
            if (isSelected)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  isSelected ? label : "",
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

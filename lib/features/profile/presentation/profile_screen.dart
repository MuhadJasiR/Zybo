import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zybo/core/theme/app_color.dart';
import 'package:zybo/core/theme/const_size.dart';
import 'package:zybo/features/auth/presentation/login_screen.dart';

import 'package:zybo/features/profile/presentation/bloc/bloc/user_bloc.dart';
import 'package:zybo/init_dependencies.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _logout(context);
              },
              child: const Text("Yes"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("No"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "My Profile",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () => _showLogoutDialog(context),
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocProvider(
            create: (context) =>
                serviceLocator<UserBloc>()..add(FetchUserData()),
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is UserLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Name",
                          style: TextStyle(color: AppColor.greyColor)),
                      kHeight(10),
                      Text(state.user.name,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      kHeight(20),
                      const Text("Phone",
                          style: TextStyle(color: AppColor.greyColor)),
                      kHeight(10),
                      Text("+91 ${state.user.phoneNumber}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      kHeight(20),
                    ],
                  );
                } else if (state is UserError) {
                  return Center(child: Text(state.message));
                }
                return const Center(child: Text("Failed to fetch user data"));
              },
            ),
          ),
        ),
      ),
    );
  }
}

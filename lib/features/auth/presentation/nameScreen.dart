import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zybo/core/theme/const_size.dart';
import 'package:zybo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:zybo/features/auth/presentation/widgets/back_button.dart';
import 'package:zybo/features/home/presentation/widgets/bottom_nav_bar.dart';

class NameScreen extends StatelessWidget {
  const NameScreen({super.key});

  onSubmit(TextEditingController nameController, BuildContext context) async {
    final fullName = nameController.text.trim();
    final prefs = await SharedPreferences.getInstance();
    final phoneNumber = await prefs.getString("phone_number");
    await prefs.setString("full_name", fullName);
    log(phoneNumber!, name: "phoneNUmber");
    context.read<AuthBloc>().add(LoginOrRegisterEvent(fullName, phoneNumber));
  }

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, bottom: 24, right: 24),
          child: Form(
            key: formKey,
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthLoggedIn) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => BottomNavBar(),
                    ),
                    (route) => false,
                  );
                } else if (state is AuthError) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    CustomBackButton(onPressed: () => Navigator.pop(context)),
                    kHeight(50),
                    TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your Full Name";
                        } else {
                          return null;
                        }
                      },
                      decoration:
                          const InputDecoration(hintText: "Enter Full Name"),
                    ),
                    kHeight(30),
                    ElevatedButton(
                        onPressed: () => onSubmit(
                              nameController,
                              context,
                            ),
                        child: const Text("Submit"))
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

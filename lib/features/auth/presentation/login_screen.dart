// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zybo/core/theme/app_color.dart';
import 'package:zybo/core/theme/const_size.dart';
import 'package:zybo/features/auth/presentation/bloc/auth_bloc.dart';

import 'package:zybo/features/auth/presentation/otp_screen.dart';
import 'package:zybo/features/home/presentation/widgets/bottom_nav_bar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  onSubmit(BuildContext context, TextEditingController phoneController,
      GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      final phoneNumber = phoneController.text.trim();
      await prefs.setString("phone_number", phoneNumber);
      context.read<AuthBloc>().add(VerifyUserEvent(phoneNumber));
    }
  }

  isUserLoggedIn(BuildContext context, AuthOtpSent state,
      TextEditingController phoneController) async {
    final prefs = await SharedPreferences.getInstance();
    final userLoggedIn = prefs.getBool("user_status");
    log("$userLoggedIn", name: "user_status");
    if (userLoggedIn!) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const BottomNavBar()));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OtpScreen(
                otp: state.otp,
                phoneNumber: phoneController.text.trim(),
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController phoneController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthOtpSent) {
                isUserLoggedIn(
                  context,
                  state,
                  phoneController,
                );
              } else if (state is AuthError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              return Form(
                key: formKey,
                child: Column(
                  children: [
                    kHeight(70),
                    const Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 35, fontWeight: FontWeight.w700),
                            ),
                            Text("Let's connect with our store"),
                          ],
                        ),
                      ],
                    ),
                    kHeight(30),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration:
                                  const InputDecoration(hintText: "+91"),
                            )),
                        kWidth(10),
                        Expanded(
                          flex: 7,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your Number";
                              } else if (value.length != 10) {
                                return "Number must be 10 digit";
                              } else {
                                return null;
                              }
                            },
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                                hintText: "Enter Phone Number"),
                          ),
                        ),
                      ],
                    ),
                    kHeight(25),
                    ElevatedButton(
                        onPressed: () => onSubmit(
                              context,
                              phoneController,
                              formKey,
                            ),
                        child: state is AuthLoading
                            ? const CircularProgressIndicator(
                                color: AppColor.whiteColor,
                              )
                            : const Text("Continue")),
                    kHeight(25),
                    const Text(
                      "By Continuing you accepting the Terms Of Use &\nPrivacy Policy",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 11),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

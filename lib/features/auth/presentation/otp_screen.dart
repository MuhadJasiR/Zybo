import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:zybo/core/theme/app_color.dart';
import 'package:zybo/core/theme/const_size.dart';

import 'package:zybo/features/auth/presentation/nameScreen.dart';
import 'package:zybo/features/auth/presentation/widgets/back_button.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.otp, required this.phoneNumber});

  final String phoneNumber;
  final String otp;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  get onPressed => null;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 60,
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            spreadRadius: -5,
            blurRadius: 10,
            offset: Offset(-5, -5),
          ),
        ],
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, bottom: 24, right: 24),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                CustomBackButton(onPressed: onPressed),
                kHeight(30),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "OTP VERIFICATION",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                ),
                kHeight(20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      text: 'Enter the OTP send to - ',
                      style: const TextStyle(color: AppColor.greyColor),
                      children: <TextSpan>[
                        TextSpan(
                          text: '+91 ${widget.phoneNumber}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColor.blackColor),
                        ),
                      ],
                    ),
                  ),
                ),
                kHeight(40),
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      text: 'OTP is ',
                      style: const TextStyle(color: AppColor.blackColor),
                      children: <TextSpan>[
                        TextSpan(
                          text: widget.otp,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColor.primaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
                kHeight(20),
                Pinput(
                  keyboardType: TextInputType.number,
                  length: 4,
                  defaultPinTheme: defaultPinTheme,
                  controller: _otpController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your OTP';
                    } else if (value != widget.otp) {
                      return "Invalid OTP";
                    }
                    return null;
                  },
                ),
                kHeight(20),
                const Text("00:00 sec"),
                kHeight(20),
                RichText(
                  text: const TextSpan(
                    text: "Don't receive code? ",
                    style: TextStyle(color: AppColor.blackColor),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Re-send',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColor.brightTealColor),
                      ),
                    ],
                  ),
                ),
                kHeight(34),
                ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const NameScreen(),
                        ));
                      }
                    },
                    child: const Text("Submit"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanohealth_task/provider/authentication/authentication_service_provider.dart';
import 'package:nanohealth_task/service/authentication/authentication_service.dart';
import 'package:nanohealth_task/utils/constants/constants.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = ref.watch(authenticationServiceProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            topSection(context),
            Constants.fixedBoxLarge,
            customFormField("Email", emailController, context),
            Constants.fixedBoxSmall,
            customFormField("Password", passwordController, context),
            Constants.fixedBoxxSmall,
            continueButton(context, authService),
            Constants.fixedBoxMid,
            needHelpText(),
            Constants.fixedBoxLarge,
          ],
        ),
      ),
    );
  }

  topSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Constants.secondColor,
            Constants.firstColor,
          ],
        ),
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.458, // Same with Figma
      child: Stack(
        children: [
          Center(
              child: Image.asset(
            "assets/images/logo.png",
            height: 117,
            width: MediaQuery.of(context).size.width * 0.57,
          )),
          const Positioned(
              bottom: 20,
              left: 30,
              child: Text(
                "Log In",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontFamily: "SFPro",
                    fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }

  customFormField(
      String label, TextEditingController controller, BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontFamily: "SFPro",
            ),
          ),
          TextField(
            controller: controller,
            obscureText: label == "Password" ? true : false,
            obscuringCharacter: "*",
            style: const TextStyle(fontSize: 15, fontFamily: "SFPro"),
            decoration: InputDecoration(
                suffixIcon: label == "Password"
                    ? Image.asset(
                        "assets/images/eye.png",
                        width: 1,
                        height: 1,
                      )
                    : Image.asset("assets/images/email_postfix.png")),
          )
        ],
      ),
    );
  }

  continueButton(
      BuildContext context, AuthenticationService authenticationService) {
    return ElevatedButton(
        onPressed: () {
          authenticationService.signIn(
              emailController.text, passwordController.text, context);
        },
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size>(Size(
              MediaQuery.of(context).size.width * 0.82, 74)), // Same with Figma
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(62.0),
          )),
          backgroundColor:
              MaterialStateProperty.all<Color>(Constants.firstColor),
        ),
        child: const Text(
          "Continue",
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontFamily: "SFPro",
          ),
        ));
  }

  needHelpText() {
    return const Text(
      "NEED HELP?",
      style: TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontFamily: "SFPro",
      ),
    );
  }
}

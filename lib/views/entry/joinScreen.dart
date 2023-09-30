import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:talent_trade/views/signup/signUpScreen.dart';

import '../signin/signInScreen.dart';

class JoinScreen extends StatelessWidget {
  const JoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie animation
            Lottie.asset(
              'assets/images/join.json',
              width: 400,
              height: 400,
              // Other Lottie parameters you might want to use
            ),

            SizedBox(height: 20),
            // Text "Let's get started" aligned to the start
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Let's get",
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Started",
                      style: GoogleFonts.roboto(
                        color: Colors.red[400],
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            // Text "Ignite a revolution..."
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Ignite a revolution of sharing and learning through our Talent Trade app, where skills converge and caring minds illuminate the path to limitless knowledge.",
                style: GoogleFonts.courgette(
                  color: Colors.white,
                  fontSize: 12,
                  // fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.justify,
              ),
            ),

            SizedBox(height: 15),

            // JOIN button
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => SignupScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[400],
                      ),
                      child: Text(
                        "Join Now",
                        style: GoogleFonts.lato(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Text "Already have an account? LogIN"
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 16,
                      fontStyle: FontStyle.italic),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => SigninScreen());
                  },
                  child: Text(
                    "Log In",
                    style: GoogleFonts.lato(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

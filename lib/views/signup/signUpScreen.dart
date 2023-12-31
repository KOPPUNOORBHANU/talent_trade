

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:talent_trade/views/signup/personalDetailScreen.dart';

import '../signin/signInScreen.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  User? currentUser=FirebaseAuth.instance.currentUser;

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Alert"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (_formKey.currentState!.validate()) {
                  Get.to(() => PersonalDetailsScreen());
                }else{
                  Get.to(() => SignupScreen());
                }
                
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.42,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Lottie.asset(
                        'assets/images/signup.json',
                        width: 280,
                        height: 280,
                      ),
                    ),
                    Text(
                      "Sign Up",
                      style: GoogleFonts.courgette(
                        color: Colors.white,
                        fontSize: 28,
                        // fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                )),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        labelText: "First Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        hintText: 'Enter Your Name.....',
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your first name.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        labelText: "Last Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        hintText: 'Enter Your Last Name.....',
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your last name.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: "Phone",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        hintText: 'Enter Your Phone Number.....',
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your phone number.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        hintText: 'Enter Your Email.....',
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your email.";
                        } else if (!value.contains('@')) {
                          return "Please enter a valid email.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        hintText: 'Enter Your Password.....',
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a password.";
                        } else if (value.length < 6) {
                          return "Password must be at least 6 characters.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // _showAlert("Signup successful!");
                          var firstName=_firstNameController.text.trim();
                          var lastName=_lastNameController.text.trim();
                          var phoneNumber=_phoneController.text.trim();
                          var userEmail=_emailController.text.trim();
                          var userPassword=_passwordController.text.trim();

                          FirebaseAuth.instance.createUserWithEmailAndPassword(email: userEmail, password: userPassword)
                          .then((value) => {
                            print("user created"),
                            FirebaseFirestore.instance.collection("users").doc(currentUser!.uid).set({
                              'firstName': firstName,
                              'lastName': lastName,
                              'phoneNumber':phoneNumber,
                              'userEmail':userEmail,
                              'create At': DateTime.now(),
                              'userId': currentUser!.uid,
                            }),
                            print("data stored"),
                          }
                          
                          );
                        // if (_formKey.currentState!.validate()) {
                          
                        //   Get.to(PersonalDetailsScreen());
                        // }else{
                        //   _showAlert("Please complete the required fields!!");
                        // }
                        
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[400],
                      ),
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.lato(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: GoogleFonts.lato(
                              color: Colors.black,
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
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:talent_trade/views/signup/personalDetailScreen.dart';

signUpUser(
    String firstName, String lastName, String phoneNumber, String userEmail) async{

      User? userId=FirebaseAuth.instance.currentUser;
      try {
  await FirebaseFirestore.instance.collection("users").doc(userId!.uid).set({
                          'firstName': firstName,
                          'lastName': lastName,
                          'phoneNumber':phoneNumber,
                          'userEmail':userEmail,
                          'create At': DateTime.now(),
                          'userId': userId.uid,
                        }).then((value) => 
                        {
                          Get.to(PersonalDetailsScreen()),
                        })
                        ;
} on FirebaseAuthException catch (e) {
  print("Error $e");
}

    }

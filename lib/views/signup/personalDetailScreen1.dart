import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:talent_trade/views/signup/profilePhotoScreen.dart';

class PersonalDetailsScreen1 extends StatefulWidget {
  @override
  _PersonalDetailsScreen1State createState() => _PersonalDetailsScreen1State();
}

class _PersonalDetailsScreen1State extends State<PersonalDetailsScreen1> {
  List<String> selectedSkills = [];
  String? workLink;
  String? description;

  // Function to toggle skill selection
  void toggleSkill(String skill) {
    setState(() {
      if (selectedSkills.contains(skill)) {
        selectedSkills.remove(skill);
      } else {
        selectedSkills.add(skill);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.47,
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
                      'assets/images/personal_details.json',
                      width: 280,
                      height: 280,
                    ),
                  ),
                  Text(
                    "Personal Details",
                    style: GoogleFonts.courgette(
                      color: Colors.white,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Skills",
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Wrap(
                    children: [
                      buildSkillChip("Java"),
                      buildSkillChip("Python"),
                      buildSkillChip("Dancing"),
                      buildSkillChip("Singing"),
                      // Add more skills as needed
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Work Link",
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        workLink = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Enter your LinkedIn/Website link",
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Description",
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        description = value;
                      });
                    },
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Enter a brief description",
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add logic to proceed with the entered details
                if (selectedSkills.isNotEmpty && workLink != null && description != null) {
                  Get.to(ProfilePhotoScreen());
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Next',
                  style: GoogleFonts.lato(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSkillChip(String skill) {
    final isSelected = selectedSkills.contains(skill);
    return ActionChip(
      onPressed: () => toggleSkill(skill),
      label: Text(skill),
      backgroundColor: isSelected ? Colors.black : Colors.grey[300],
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}

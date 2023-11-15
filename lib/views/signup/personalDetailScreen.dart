import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:talent_trade/views/signup/personalDetailScreen1.dart';

class PersonalDetailsScreen extends StatefulWidget {
  @override
  _PersonalDetailsScreenState createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  DateTime? selectedDate;
  String? selectedOccupation;
  String? selectedLocation;
  String? selectedCity;
  String? selectedState;
  String? selectedCountry;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ))!;

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectLocation(BuildContext context) async {
    try {
      // Request location permissions if not granted
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Handle the case where the user denies permission
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Handle the case where the user has permanently denied permission
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        String locationName = placemark.name ?? "";
        String city = placemark.locality ?? "";
        String state = placemark.subAdministrativeArea ?? "";
        String country = placemark.country ?? "";
        setState(() {
          selectedLocation = locationName;
          selectedCity = city;
          selectedState = state;
          selectedCountry = country;
        });
      }
    } catch (e) {
      // Handle any exceptions that occur during location fetching
      print("Error fetching location: $e");
      // You can provide user feedback or handle the error as needed
    }
  }

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
                    "Date of Birth",
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: Text(selectedDate == null
                        ? 'Select Date'
                        : '${selectedDate!.toLocal()}'.split(' ')[0]),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Occupation",
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: selectedOccupation,
                    items: [
                      DropdownMenuItem(
                        value: "Student",
                        child: Text("Student"),
                      ),
                      DropdownMenuItem(
                        value: "Employee",
                        child: Text("Employee"),
                      ),
                      DropdownMenuItem(
                        value: "School Student",
                        child: Text("School Student"),
                      ),
                      // Add more occupation options as needed
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedOccupation = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Location",
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => _selectLocation(context),
                    child: Text(selectedLocation == null
                        ? 'Select Current Location'
                        : '$selectedLocation, $selectedCity, $selectedState , $selectedCountry'),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add logic to proceed with the entered details
                if (selectedDate != null &&
                    selectedOccupation != null &&
                    selectedLocation != null) {
                  Get.to(PersonalDetailsScreen1());
                }else if(selectedDate==null){
                  _showAlert("Please select date of birth");
                  Get.to(PersonalDetailsScreen());
                }
                else if(selectedOccupation==null){
                  _showAlert("Please select your occupation");
                  Get.to(PersonalDetailsScreen());
                }
                else if(selectedLocation==null){
                  _showAlert("Please select your Location");
                  Get.to(PersonalDetailsScreen());
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
}

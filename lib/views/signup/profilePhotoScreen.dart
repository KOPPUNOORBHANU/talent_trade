import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:talent_trade/views/home/homeScreen.dart';

class ProfilePhotoScreen extends StatefulWidget {
  @override
  _ProfilePhotoScreenState createState() => _ProfilePhotoScreenState();
}

class _ProfilePhotoScreenState extends State<ProfilePhotoScreen> {
  File? _image;

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker()
        .pickImage(source: source, maxWidth: 1024, maxHeight: 1024);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      if (file.lengthSync() <= 1024 * 1024) {
        setState(() {
          _image = file;
        });
      } else {
        // Show an error message for exceeding the size limit
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Image Size Limit Exceeded'),
            content: Text(
                'Please select an image with a size less than or equal to 1 MB.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
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
                      'assets/images/profile_photo.json',
                      width: 280,
                      height: 280,
                    ),
                  ),
                  Text(
                    "Profile Photo",
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
                    "Select or Capture Photo",
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: _image == null
                        ? Text('No image selected.')
                        : Image.file(_image!),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _getImage(ImageSource.gallery),
                    child: Text('Select from Gallery'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => _getImage(ImageSource.camera),
                    child: Text('Capture from Camera'),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add logic to proceed with the selected/captured image
                if (_image != null) {
                  // Navigate to the next screen or perform any necessary action
                  Get.to(HomeScreen());
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

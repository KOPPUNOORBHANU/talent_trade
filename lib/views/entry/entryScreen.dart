import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:talent_trade/views/entry/joinScreen.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({Key? key}) : super(key: key);

  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  Future<void> _startTimer() async {
    await Future.delayed(Duration(seconds: 8));
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500),
        pageBuilder: (_, __, ___) => JoinScreen(),
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          var tween = Tween(begin: begin, end: end);
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 400.0,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Lottie.asset("assets/images/bulb2.json"),
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Talent Trade",
              style: GoogleFonts.jomhuria(fontSize: 60, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              "Sharing Skills, Building Dreams",
              style: GoogleFonts.lato(fontSize: 18, color: Colors.white),
            ),
            Expanded(child: Container()), // Spacer
            LinearProgressIndicator(
              backgroundColor: Color.fromARGB(255, 16, 16, 16),
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

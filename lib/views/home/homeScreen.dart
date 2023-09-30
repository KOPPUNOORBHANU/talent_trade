import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:talent_trade/views/home/sidemenu.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 2;

  // Define your screens here
  final List<Widget> _screens = [
    Placeholder(),
    Placeholder(),
    Placeholder(),
    Placeholder(),
    Placeholder(),
  ];

  @override
  Widget build(BuildContext context) {
    final items = [
      Icon(
        Icons.home,
        size: 30,
      ),
      Icon(
        Icons.search,
        size: 30,
      ),
      Icon(
        Icons.favorite,
        size: 30,
      ),
      Icon(
        Icons.settings,
        size: 30,
      ),
      Icon(
        Icons.person,
        size: 30,
      )
    ];
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white, // Background color for the entire screen
      body: Stack(
        children: [
          SideMenuScreen(),
          // Curved top black portion
          // CustomPaint(
          //   size: Size(
          //     MediaQuery.of(context).size.width,
          //     MediaQuery.of(context).size.height * 0.35,
          //   ),
          //   painter: CurvePainter(),
          // ),
          // // Middle scrollable white portion with screen content
          // SingleChildScrollView(
          //   padding:
          //       EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.25),
          //   child: _screens[index], // Display the selected screen
          // ),
        ],
      ),
      // bottomNavigationBar: CurvedNavigationBar(
      //   color: Colors.black12,
      //   buttonBackgroundColor: Colors.black38,
      //   backgroundColor: Colors.transparent,
      //   height: 60,
      //   index: index,
      //   items: items,
      //   onTap: (index) => setState(() => this.index = index),
      // ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.black;
    paint.style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.65);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height * 0.65);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart' hide LinearGradient;
import 'dart:math' as math;
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:talent_trade/views/home/home.dart';
import 'package:talent_trade/views/home/sidemenu.dart';

// Define commonTabScene and other constants as needed

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController? _animationController;
  late AnimationController? _onBoardingAnimController;
  late Animation<double> _onBoardingAnim;
  late Animation<double> _sidebarAnim;

  late SMIBool _menuBtn;
  int index = 2;

  bool _showOnBoarding = false;
  Widget _tabBody = Home(); // Change the color as needed
  final List<Widget> _screens = [
    Placeholder(),
    Placeholder(),
    Placeholder(),
    Home1(),
    Home(),

  ];

  final springDesc = const SpringDescription(
    mass: 0.1,
    stiffness: 40,
    damping: 5,
  );

  void _onMenuIconInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, "State Machine");
    artboard.addController(controller!);
    _menuBtn = controller.findInput<bool>("isOpen") as SMIBool;
    _menuBtn.value = true;
  }

  void _presentOnBoarding(bool show) {
    if (show) {
      setState(() {
        _showOnBoarding = true;
      });
      final springAnim = SpringSimulation(springDesc, 0, 1, 0);
      _onBoardingAnimController?.animateWith(springAnim);
    } else {
      _onBoardingAnimController?.reverse().whenComplete(() => {
            setState(() {
              _showOnBoarding = false;
            })
          });
    }
  }

  void onMenuPress() {
    if (_menuBtn.value) {
      final springAnim = SpringSimulation(springDesc, 0, 1, 0);
      _animationController?.animateWith(springAnim);
    } else {
      _animationController?.reverse();
      
    }
    _menuBtn.change(!_menuBtn.value);

    SystemChrome.setSystemUIOverlayStyle(_menuBtn.value
        ? SystemUiOverlayStyle.dark
        : SystemUiOverlayStyle.light);
  }

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      upperBound: 1,
      vsync: this,
    );
    _onBoardingAnimController = AnimationController(
      duration: const Duration(milliseconds: 350),
      upperBound: 1,
      vsync: this,
    );

    _sidebarAnim = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.linear,
    ));

    _onBoardingAnim = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _onBoardingAnimController!,
      curve: Curves.linear,
    ));

    _tabBody = _screens.first;
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _onBoardingAnimController?.dispose();
    super.dispose();
  }

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
      ),
    ];

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          
          AnimatedBuilder(
            animation: _sidebarAnim,
            builder: (BuildContext context, Widget? child) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(((1 - _sidebarAnim.value) * -30) * math.pi / 180)
                  ..translate((1 - _sidebarAnim.value) * -300),
                child: child,
              );
            },
            child:SideMenuScreen(onMenuPress: onMenuPress),
          ),
          AnimatedBuilder(
            animation: _sidebarAnim, 
            builder: (context, child){
              return SafeArea(

                child: Row(
                  children: [
                    SizedBox(width: _sidebarAnim.value*216,),
                    child!,
                  ],
                  ),
              );
            },child: GestureDetector(
                  onTap: onMenuPress,
                  child: Container(
                    width: 44,
                    height: 44,
                    margin: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(44/2),
                      boxShadow: [BoxShadow(
                        color: Colors.white38,
                        blurRadius: 5,
                        offset: Offset(0, 0),
                      ),
                      ]
                    ),
                    child: RiveAnimation.asset(
                      "assets/animated_icons/menu_button.riv",
                      stateMachines: ["State Machine"],
                      animations: ["open", "close"],
                      onInit: _onMenuIconInit,
                    ),
                  ),
                ),
            ),
             _screens[index],
              //  CustomPaint(
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
          // Rest of your UI
        ],
      ),
      bottomNavigationBar: AnimatedBuilder(
        animation: _sidebarAnim,
        builder: (BuildContext context, Widget? child) {
          return Transform.translate(
            offset: Offset(0, _sidebarAnim.value*300)
          ,child: child!,
          ) ;
        },
        child: CurvedNavigationBar(
          color: Colors.black12,
          buttonBackgroundColor: Colors.black38,
          backgroundColor: Colors.transparent,
          height: 60,
          items: items,
          onTap: (index) => setState(() => this.index = index),
        ),
      ),
    );
  }
}


// class CurvePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint();
//     paint.color = Colors.black;
//     paint.style = PaintingStyle.fill;

//     final path = Path();
//     path.moveTo(0, 0);
//     path.lineTo(0, size.height * 0.65);
//     path.quadraticBezierTo(
//         size.width / 2, size.height, size.width, size.height * 0.65);
//     path.lineTo(size.width, 0);
//     path.close();

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart' hide LinearGradient;
import 'dart:math' as math;
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:talent_trade/views/home/home.dart';
import 'package:talent_trade/views/home/sidemenu.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController? _animationController;
  late AnimationController? _onBoardingAnimController;
  late Animation<double> _sidebarAnim;

  late SMIBool _menuBtn;
  int index = 2;
  Widget _tabBody = Home(); // Change the color as needed

  final List<Widget> _screens = [
    const Home(),
    const Placeholder(),
    const Placeholder(),
    const Placeholder(),
    const Placeholder(),
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

    _sidebarAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Curves.linear,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      const Icon(
        Icons.home,
        size: 30,
      ),
      const Icon(
        Icons.search,
        size: 30,
      ),
      const Icon(
        Icons.favorite,
        size: 30,
      ),
      const Icon(
        Icons.settings,
        size: 30,
      ),
      const Icon(
        Icons.person,
        size: 30,
      ),
    ];

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: Stack(
        children: [

          if (_sidebarAnim.value == 0) ...[
      Positioned.fill(
        child: _screens[index],
      ),
      Positioned.fill(
        child: Container(color: Colors.black38),
      ),
    ],
          AnimatedBuilder(
            animation: _sidebarAnim,
            builder: (BuildContext context, Widget? child) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(((1 - _sidebarAnim.value) * -30) * math.pi / 180)
                  ..translate((1 - _sidebarAnim.value) * -300),
                child: FadeTransition(
                  opacity: _sidebarAnim,
                  child: SideMenuScreen(onMenuPress: onMenuPress),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: _sidebarAnim,
            builder: (BuildContext context, Widget? child) {
              return Transform.scale(
                scale: 1 - _sidebarAnim.value * 0.1,
                child: Transform.translate(
                  offset: Offset(_sidebarAnim.value * 265, 0),
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY((_sidebarAnim.value * 30) * math.pi / 180),
                    child: child,
                  ),
                ),
              );
            },
            child: _tabBody,
          ),
          AnimatedBuilder(
            animation: _sidebarAnim,
            builder: (context, child) {
              return SafeArea(
                child: Row(
                  children: [
                    SizedBox(width: _sidebarAnim.value * 216),
                    child!,
                  ],
                ),
              );
            },
            child: GestureDetector(
              onTap: onMenuPress,
              child: Container(
                width: 44,
                height: 44,
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(44 / 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white38,
                      blurRadius: 5,
                      offset: Offset(0, 0),
                    ),
                  ],
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
        ],
      ),
      bottomNavigationBar: AnimatedBuilder(
        animation: _sidebarAnim,
        builder: (BuildContext context, Widget? child) {
          return Transform.translate(
            offset: Offset(0, _sidebarAnim.value * 300),
            child: child!,
          );
        },
        child: CurvedNavigationBar(
          color: Colors.black12,
          buttonBackgroundColor: Colors.black38,
          backgroundColor: Colors.transparent,
          height: 60,
          items: items,
          onTap: (index) => setState(() => _tabBody = _screens[index]),
        ),
      ),
    );
  }
}

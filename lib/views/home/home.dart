import 'dart:ui';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Home1();
  }
}

class Home1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        decoration: BoxDecoration(
          // color: Color.fromARGB(155, 242, 246, 247),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          children:[
            // Background Image
            Container(
              color: Color.fromARGB(155, 242, 246, 247),
              // width: double.infinity, // Set width to cover the entire screen
              // height: double.infinity,
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //     image: AssetImage('assets/images/home_bg.jpg'), // Replace with your image path
              //     fit: BoxFit.cover, // You can adjust the fit as needed
              //   ),
              // ),
            ),
            Column(
            children: [
              // Upper curved black theme
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  child: Stack(
                    children: [
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 400, sigmaY: 400),
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.755),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.black),
                          gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.black.withOpacity(0.15),
                              Colors.black.withOpacity(0.05),
                            ]
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // Search bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              // Middle area with horizontally scrollable cards
              Container(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    buildGlassmorphicCard('Card 1'),
                    buildGlassmorphicCard('Card 2'),
                    buildGlassmorphicCard('Card 3'),
                    buildGlassmorphicCard('Card 4'),
                    buildGlassmorphicCard('Card 5'),
                  ],
                ),
              ),
              // Lower curved black theme
              
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),
          ]
        ),
      ),
    );
  }

  Widget buildGlassmorphicCard(String text) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            width: 150,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

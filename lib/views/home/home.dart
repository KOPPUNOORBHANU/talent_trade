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
      body: Column(
        children: [
          // Upper curved black theme
          Container(
            height: 100, // Adjust the height as needed
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
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
            height: 200, // Adjust the height as needed
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                buildCard('Card 1'),
                buildCard('Card 2'),
                buildCard('Card 3'),
                buildCard('Card 4'),
                buildCard('Card 5'),
              ],
            ),
          ),

          // Lower curved black theme
          Expanded(
            child: Container(
              height: 100, // Adjust the height as needed
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard(String text) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Container(
        width: 150, // Adjust the card width as needed
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}

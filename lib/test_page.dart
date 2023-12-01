import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});
  final String imagePath =
      "assets/nature-sky-water-sea-natural-landscape-ocean-1520813-pxhere.com.jpg";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Bidirectional Viewport Example'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            height: 300.0, // Set the height of the vertical viewport
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 500.0, // Set the width of the horizontal viewport
                child: Container(
                  color: Colors.blue,
                  child: Center(
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

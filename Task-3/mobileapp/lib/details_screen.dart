import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final Map<String, String> vehicle;

  DetailsScreen({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(vehicle['name']!)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(vehicle['image']!, height: 200, fit: BoxFit.cover),
            SizedBox(height: 20),
            Text(
              vehicle['name']!,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              vehicle['details']!,
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 61, 61, 61)),
                  child: Text("Back to Home"),
                ),
                SizedBox(width: 15), // Space between buttons
                ElevatedButton(
                  onPressed: () {
                    // No action, just a button
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: Text("Order it Now"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

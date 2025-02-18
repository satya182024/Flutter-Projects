import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ticket/pmt.dart';
import 'locPage.dart';

class LocationPage extends StatelessWidget {
  final String userEmail;
  final List<Map<String, String>> places = [
    {'id': '0g9hp1D9uVaddPvt5h3L', 'placeName': 'Ellora Caves'},
    {'id': '7oxm3SszFYvF34LpE4hk', 'placeName': 'Bibi Ka Maqbara'},
    {'id': 'B1GyNHA0MI5pIuyvEhyE', 'placeName': 'Daultabad'},
    {'id': 'FozwInsOYQcyoSZWjt1D', 'placeName': 'Ajanta Caves'},
    {'id': 'kz4W8gB5VOGakTrQdWFr', 'placeName': 'Aurangabad Caves'},
    // Add more places as needed
  ];
  LocationPage({required this.userEmail});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a Place'),
      ),
      body: ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          final place = places[index];
          return ListTile(
            title: Text(place['placeName']!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  // builder: (context) => pmtMthd(
                  builder: (context) => PaymentMethodPage(
                    title: 'Payment Options',
                    placeName: place['placeName']!,
                    autogeneratedId: place['id']!,
                    userEmail: userEmail,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

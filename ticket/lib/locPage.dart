import 'package:flutter/material.dart';
// import 'package:ticket/pmt.dart';
import 'locationPage.dart';

// void main() {
//   runApp(LocationPage1());
// }

class HistoricalPlace {
  final String name;
  final String imageAsset;
  final String information;

  HistoricalPlace({
    required this.name,
    required this.imageAsset,
    required this.information,
  });
}

class LocationPage1 extends StatelessWidget {
  final String userEmail;
  LocationPage1({required this.userEmail});
  final List<HistoricalPlace> places = [
    HistoricalPlace(
      name: 'Bibi ka Maqbara',
      imageAsset: 'images/bb.jpg',
      information: 'The Bibi ka Maqbara is an ivory-white marble mausoleum...',
    ),
    HistoricalPlace(
      name: 'Ajanta Caves',
      imageAsset: 'images/aj.jpg',
      information:
          'The Ajanta Caves are 29 rock-cut Buddhist cave monuments dating from the second century BCE to about 480 CE in the Aurangabad District of Maharashtra state in India. '
          'Ajanta Caves are a UNESCO World Heritage Site',
    ),
    HistoricalPlace(
      name: 'Daulatabad',
      imageAsset: 'images/da.jpg',
      information:
          'Daulatabad Fort, is a historic fortified citadel located in Daulatabad village near Aurangabad, Maharashtra,',
    ),
    HistoricalPlace(
      name: 'Ellora Caves',
      imageAsset: 'images/e2.jpg',
      information:
          'Ellora Caves are a multi-religious rock-cut cave complex with inscriptions dating from the period 6th century CE onwards, located in the Aurangabad District of Maharashtra, India.',
    ),
    HistoricalPlace(
      name: 'Aurangabad Caves',
      imageAsset: 'images/ac.jpg',
      information:
          'The Aurangabad caves are twelve rock-cut Buddhist shrines located on a hill running roughly east to west, close to the city of Aurangabad, Maharashtra.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Historical Places',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Goes back to the previous page
            },
          ),
          title: Text('Historical Places'),
        ),
        body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final place = places[index];
                  return HistoricalPlaceCard(
                    userEmail: userEmail,
                    place: place,
                    onPressed: () {
                      // Navigate to payment page with the selected location name
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              LocationPage(userEmail: userEmail),
                        ),
                      );
                    },
                  );
                },
                childCount: places.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HistoricalPlaceCard extends StatelessWidget {
  final HistoricalPlace place;
  final VoidCallback onPressed;
  final String userEmail;

  HistoricalPlaceCard(
      {required this.place, required this.onPressed, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Image.asset(
            place.imageAsset,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          ListTile(
            title: Text(place.name),
            trailing: IconButton(
              icon: Icon(Icons.info),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(place.name),
                      content: Text(place.information),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LocationPage(userEmail: userEmail)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: Text('Book Ticket'),
            ),
          ),
        ],
      ),
    );
  }
}

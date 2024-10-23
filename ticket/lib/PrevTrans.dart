// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class PrevTransPage extends StatefulWidget {
//   final String userEmail;
//
//   const PrevTransPage({Key? key, required this.userEmail}) : super(key: key);
//
//   @override
//   _PrevTransPageState createState() => _PrevTransPageState();
// }
//
// class _PrevTransPageState extends State<PrevTransPage> {
//   late Future<List<Map<String, dynamic>>> _fetchTransactions;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchTransactions = _getPrevTransactions(widget.userEmail);
//   }
//
//   Future<List<Map<String, dynamic>>> _getPrevTransactions(
//       String userEmail) async {
//     try {
//       QuerySnapshot<Map<String, dynamic>> querySnapshot =
//           await FirebaseFirestore.instance
//               .collection('payments')
//               .where('userEmail', isEqualTo: userEmail)
//               .get();
//
//       return querySnapshot.docs.map((doc) => doc.data()).toList();
//     } catch (e) {
//       print('Error fetching transactions: $e');
//       return [];
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Previous Transactions'),
//       ),
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: _fetchTransactions,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             List<Map<String, dynamic>> transactions = snapshot.data ?? [];
//             return transactions.isEmpty
//                 ? Center(child: Text('No previous transactions found.'))
//                 : _buildTransactionList(transactions);
//           }
//         },
//       ),
//     );
//   }
//
//   Widget _buildTransactionList(List<Map<String, dynamic>> transactions) {
//     return ListView.builder(
//       itemCount: transactions.length,
//       itemBuilder: (context, index) {
//         Map<String, dynamic> transaction = transactions[index];
//         return Card(
//           margin: EdgeInsets.all(10.0),
//           child: ListTile(
//             title: Text('Place: ${transaction['placeName']}'),
//             subtitle: Text('Total Amount: ${transaction['totalAmount']}'),
//             onTap: () {
//               // Add navigation to a detailed view if needed
//             },
//           ),
//         );
//       },
//     );
//   }
// }
//
// void main() {
//   runApp(MaterialApp(
//     home: PrevTransPage(
//         userEmail: 'user@example.com'), // Replace with the actual user email
//   ));
// }
//----------------------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PrevTransPage extends StatefulWidget {
  final String userEmail;

  const PrevTransPage({Key? key, required this.userEmail}) : super(key: key);

  @override
  _PrevTransPageState createState() => _PrevTransPageState();
}

class _PrevTransPageState extends State<PrevTransPage> {
  late Future<List<PaymentDetails>> transactions;

  @override
  void initState() {
    super.initState();
    transactions = fetchTransactions(widget.userEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Previous Transactions'),
      ),
      body: FutureBuilder<List<PaymentDetails>>(
        future: transactions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return TransactionCard(transaction: snapshot.data![index]);
              },
            );
          }
        },
      ),
    );
  }
}

class PaymentDetails {
  final String placeName;
  final String userEmail;
  final int adultTickets;
  final int childTickets;
  final int foreignerTickets;
  final int totalAmount;
  // final String bookingDate;
  // final String bookingTime;
  final String paymentId;
  final String bookedForDate;
  PaymentDetails({
    required this.placeName,
    required this.userEmail,
    required this.adultTickets,
    required this.childTickets,
    required this.foreignerTickets,
    required this.totalAmount,
    // required this.bookingDate,
    // required this.bookingTime,
    required this.paymentId,
    required this.bookedForDate,
  });
}

class TransactionCard extends StatelessWidget {
  final PaymentDetails transaction;

  const TransactionCard({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: ListTile(
        title: Text('Place: ${transaction.placeName}'),
        subtitle: Text('Total Amount: ${transaction.totalAmount}'),
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Transaction Details'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Place: ${transaction.placeName}'),
                    Text('User Email: ${transaction.userEmail}'),
                    Text('Adult Tickets: ${transaction.adultTickets}'),
                    Text('Child Tickets: ${transaction.childTickets}'),
                    Text('Foreigner Tickets: ${transaction.foreignerTickets}'),
                    Text('Total Amount: ${transaction.totalAmount}'),
                    Text('Booked for Date: ${transaction.bookedForDate}'),
                    Text('Payment ID: ${transaction.paymentId}'),
                  ],
                ),
                actions: [
                  ElevatedButton(
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
    );
  }
}

Future<List<PaymentDetails>> fetchTransactions(String userEmail) async {
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('payments')
        .where('userEmail', isEqualTo: userEmail)
        .get();

    List<PaymentDetails> transactions = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data()!;
      Timestamp timestamp = data['bookingDate'];
      DateTime dateTime = timestamp.toDate();
      DateTime bookedForDate = dateTime.add(Duration(days: 1));

      return PaymentDetails(
        placeName: data['placeName'],
        userEmail: data['userEmail'],
        adultTickets: data['adultTickets'],
        childTickets: data['childTickets'],
        foreignerTickets: data['foreignerTickets'],
        totalAmount: data['totalAmount'],
        bookedForDate: bookedForDate.toString(), // Convert DateTime to String
        paymentId: data['paymentId'],
      );
    }).toList();

    return transactions;
  } catch (e) {
    print('Error fetching transactions: $e');
    return [];
  }
}

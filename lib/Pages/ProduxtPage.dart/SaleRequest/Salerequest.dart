import 'package:flutter/material.dart';

class Salerequest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, // Set background color to black
        title: Text(
          'Sale Request',
          style: TextStyle(
            color: Colors.white, // Set text color to white
            fontWeight: FontWeight.bold, // Set text to bold
          ),
        ),
        centerTitle: true, // Center the title
        iconTheme: IconThemeData(
          color: Colors.white, // Set back button color to white
        ),
      ),
      body: Center(
        child: Text('This is the Sale Request screen'),
      ),
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// class AdminDashboard extends StatefulWidget {
//   @override
//   _AdminDashboardState createState() => _AdminDashboardState();
// }

// class _AdminDashboardState extends State<AdminDashboard> {
//   @override
//   void initState() {
//     super.initState();
//     listenToSellRequests();
//   }

//  void listenToSellRequests() {
//   FirebaseFirestore.instance
//       .collection('sellRequests')
//       .snapshots()
//       .listen((snapshot) {
//     snapshot.docChanges.forEach((change) {
//       if (change.type == DocumentChangeType.added) {
//         // Print out document data for debugging
//         print('Document Data: ${change.doc.data()}');

//         // Try to create a SellRequestModel instance
//         try {
//           SellRequestModel request = SellRequestModel.fromMap(change.doc.data());
//           // Handle the request or update UI
//           print('New Sell Request: ${request.productName}');
//         } catch (e) {
//           print('Error creating SellRequestModel: $e');
//         }
//       }
//       // Add logic for handling other types of changes (modified, removed)
//     });
//   });
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Admin Dashboard'),
//       ),
//       body: Center(
//         child: Text('Admin Dashboard'),
//       ),
//     );
//   }
// }

// class SellRequestModel {
//   final String categoryId;
//   final String requestId;
//   final String userId;
//   final String username;
//   final String email;
//   final String categoryName;
//   final String productName;
//   final String productId;
//   final String price;
//   final String unitFrom;
//   final String quantity;
//   final DateTime date;
//   final String productDescription;
//   final List<dynamic> productImages;

//   SellRequestModel({
//     required this.username,
//     required this.email,
//     required this.categoryName,
//     required this.productId,
//     required this.price,
//     required this.productDescription,
//     required this.productImages,
//     required this.requestId,
//     required this.userId,
//     required this.categoryId,
//     required this.productName,
//     required this.unitFrom,
//     required this.quantity,
//     required this.date,
//   });

//   factory SellRequestModel.fromMap(Map<String, dynamic> json) {
//     return SellRequestModel(
//       requestId: json['requestId'],
//       userId: json['userId'],
//       categoryId: json['categoryId'],
//       productName: json['productName'],
//       price: json['price'],
//       unitFrom: json['unitFrom'],
//       quantity: json['quantity'],
//       date: DateTime.parse(json['date']),
//       productDescription: json['productDescription'],
//       productImages: json['productImages'],
//       username: json['username'] ?? '',
//       email: json['email'] ?? '',
//       categoryName: json['categoryName'] ?? '',
//       productId: json['productId'] ?? '',
//     );
//   }
// }
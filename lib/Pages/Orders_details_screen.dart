// ignore_for_file: file_names, avoid_unnecessary_containers, prefer_const_constructors, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'CustomerDetails/individually_order_screen.dart';

class OrdersDetailScreen extends StatelessWidget {
  const OrdersDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Orders Detils Screen",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('orders')
            .orderBy('createdAt', descending: true)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Container(
              child: Center(
                child: Text('Error occurred while fetching orders!'),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Container(
              child: Center(
                child: Text('No orders found!'),
              ),
            );
          }

          if (snapshot.data != null) {
            return ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final data = snapshot.data!.docs[index];

                return Card(
                  elevation: 5,
                  child: ListTile(
                    onTap: () => Get.to(
                      () => individualCustomerOrderScreen(
                        docId: snapshot.data!.docs[index]['uId'],
                        customerName: snapshot.data!.docs[index]
                            ['customerName'],
                      ),
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(data['customerName'][0]),
                    ),
                    title: Text(data['customerName']),
                    subtitle: Text(data['customerPhone']),
                    trailing: Icon(Icons.edit),
                  ),
                );
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}

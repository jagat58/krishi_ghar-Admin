// ignore_for_file: must_be_immutable, file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import '../../Model/Order_model.dart';

class CheckOrderScreen extends StatelessWidget {
  String docId;
  OrderModel orderModel;
  CheckOrderScreen({
    super.key,
    required this.docId,
    required this.orderModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Order',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(orderModel.productName),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(orderModel.productTotalPrice.toString()),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('x' + orderModel.productQuantity.toString()),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(orderModel.productDescription),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50.0,
                foregroundImage: NetworkImage(orderModel.productImages[0]),
              ),
              CircleAvatar(
                radius: 50.0,
                foregroundImage: NetworkImage(orderModel.productImages[1]),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(orderModel.customerName),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(orderModel.customerPhone),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(orderModel.customerAddress),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(orderModel.customerId),
          ),
        ],
      ),
    );
  }
}

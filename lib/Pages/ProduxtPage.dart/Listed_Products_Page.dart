// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Model/product_model.dart';
import 'product_details.dart';

class ListedProductsScreen extends StatefulWidget {
  const ListedProductsScreen({super.key});

  @override
  State<ListedProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<ListedProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Products",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
      
        backgroundColor:Colors.black
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('products')
            .orderBy('categoryName', descending: true)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Container(
              child: Center(
                child: Text('Error occurred while fetching products!'),
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
                child: Text('No products found!'),
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

                ProductModel productModel = ProductModel(
                  productId: data['productId'],
                  categoryId: data['categoryId'],
                  productName: data['productName'],
                  categoryName: data['categoryName'],
                  price: data['price'],
                  productImages: data['productImages'],
                  deliveryTime: data['deliveryTime'],
                  isSale: data['isSale'],
                  productDescription: data['productDescription'],
                  create: data['create'],
                  update: data['update'],
                );

                return Card(
                  elevation: 5,
                  child: ListTile(
                    onTap: () {
                      // Get.to(() => ProductDetailScreen(
                      //     productModel: productModel));
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: CachedNetworkImageProvider(
                        productModel.productImages[0],
                        errorListener: (err) {
                          print('Error loading image');
                          Icon(Icons.error);
                        },
                      ),
                    ),
                    title: Text(productModel.productName),
                    subtitle: Text(productModel.productId),
                    // trailing: Icon(Icons.arrow_forward_ios),
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

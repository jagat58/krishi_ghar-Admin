// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors, must_be_immutable, sized_box_for_whitespace, prefer_is_empty, avoid_print, await_only_futures

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/caragory_deop_down.dart';
import '../../../controller/product_image_controller.dart';
import '../../../weidgets/deop_doen_product.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({super.key});

  AddProductImagesController addProductImagesController =
      Get.put(AddProductImagesController());

  //
  CategoryDropDownController categoryDropDownController =
      Get.put(CategoryDropDownController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Products",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Select Images"),
                      ElevatedButton(
                        onPressed: () {
                          addProductImagesController.showImagesPickerDialog();
                        },
                        child: Text("Select Images"),
                      )
                    ],
                  ),
                ),
              ),

              //show Images
              GetBuilder<AddProductImagesController>(
                init: AddProductImagesController(),
                builder: (imageController) {
                  return imageController.selectedIamges.length > 0
                      ? Container(
                          width: MediaQuery.of(context).size.width - 20,
                          height: Get.height / 3.0,
                          child: GridView.builder(
                            itemCount: imageController.selectedIamges.length,
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 10,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return Stack(
                                children: [
                                  Image.file(
                                    File(addProductImagesController
                                        .selectedIamges[index].path),
                                    fit: BoxFit.cover,
                                    height: Get.height / 4,
                                    width: Get.width / 2,
                                  ),
                                  Positioned(
                                    right: 10,
                                    top: 0,
                                    child: InkWell(
                                      onTap: () {
                                        imageController.removeImages(index);
                                        print(imageController
                                            .selectedIamges.length);
                                      },
                                      child: CircleAvatar(
                                        backgroundColor:
                                            Colors.blue,
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.amber,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        )
                      : SizedBox.shrink();
                },
              ),

              DropDownCategoriesWiidget(),
            ],
          ),
        ),
      ),
    );
  }
}
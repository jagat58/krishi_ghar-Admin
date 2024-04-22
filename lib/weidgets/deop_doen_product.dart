// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/caragory_deop_down.dart';

class DropDownCategoriesWiidget extends StatelessWidget {
  const DropDownCategoriesWiidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryDropDownController>(
      init: CategoryDropDownController(),
      builder: (categoriesDropDownController) {
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    value:
                        categoriesDropDownController.selectedCategoryId?.value,
                    items:
                        categoriesDropDownController.categories.map((catagories) {
                      return DropdownMenuItem<String>(
                        value: catagories['categoryId'],
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                catagories['categoryImage'].toString(),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Text(catagories['categoryName']),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (String? selectedValue) async {
                      categoriesDropDownController
                          .setSelectedCategory(selectedValue);
                      String? categoryName = await categoriesDropDownController
                          .getCategoryName(selectedValue);
                      categoriesDropDownController
                          .setSelectedCategoryName(categoryName);
                    },
                    hint: const Text(
                      'Select a catagories',
                    ),
                    isExpanded: true,
                    elevation: 10,
                    underline: const SizedBox.shrink(),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
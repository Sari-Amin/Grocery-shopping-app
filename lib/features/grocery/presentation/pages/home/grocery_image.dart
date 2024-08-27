import 'package:flutter/material.dart';

import '../../../../../core/Text_Style/text_style.dart';
import '../../../../../core/constant/width_height.dart';
import '../../../Domain/entity/grocery_entity.dart';

class GroceryImage extends StatelessWidget {
  final String imageUrl;
  final double price;
  final String disc;
  final String title;
  final String id;
  final double discount;
  final List<OptionEntity> options;
  final double rating;
  const GroceryImage(
      {super.key,
      required this.disc,
      required this.imageUrl,
      required this.price,
      required this.title,
      required this.id,
      required this.discount,
      required this.options,
      required this.rating});

  @override
  Widget build(BuildContext context) {
    double width = WidthHeight.screenWidth(context);
    return GestureDetector(
        onTap: () => {
              Navigator.pushNamed(context, '/detail', arguments: {
                'disc': disc,
                'imageUrl': imageUrl,
                'price': price,
                'name': title,
                'id': id,
                'options': options,
                'rating': rating,
                'discount' : discount,
              })
            },
        child: Column(
          children: [
            Container(
              color: const Color.fromARGB(255, 226, 225, 225),
              width: width,
              height: width * 0.5,
              child: Image.network(
                imageUrl,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: width * 0.418,
                      child: TextStyles(
                          text: title,
                          fontColor: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSizes: (width * 0.04).toInt())),
                  SizedBox(
                      width: width * 0.15,
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: TextStyles(
                              text: '\$$price',
                              fontColor: Colors.black,
                              fontSizes: 14))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: width * 0.65,
                      child: TextStyles(
                          text: disc,
                          fontColor: Colors.grey,
                          fontSizes: (width * 0.03).toInt())),
                  const Spacer(),
                  const Icon(Icons.star, color: Colors.yellow, size: 15),
                  SizedBox(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextStyles(
                        text: '(4.0)',
                        fontColor: Colors.grey,
                        fontSizes: 12,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

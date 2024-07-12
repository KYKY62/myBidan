import 'package:flutter/material.dart';
import 'package:mybidan/core/constants/text_style.dart';
import 'package:mybidan/core/extension/int_ext.dart';

class CardProduct extends StatelessWidget {
  final String image;
  final String title;
  final String type;
  final String normalPrice;
  final String discountPrice;

  const CardProduct(
      {super.key,
      required this.image,
      required this.title,
      required this.type,
      required this.normalPrice,
      required this.discountPrice});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          child: SizedBox(
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              width: 200,
            ),
          ),
        ),
        Positioned(
          top: 100,
          bottom: 20,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 8,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      title,
                      style: CustomTextStyle.smallerText.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 7.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      type,
                      style: CustomTextStyle.smallerText.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const SizedBox(width: 8.0),
                      Text(
                        int.parse(normalPrice).currencyFormatRp,
                        style: CustomTextStyle.smText.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 5.0),
                      SizedBox(
                        width: 90,
                        child: Text(
                          int.parse(discountPrice).currencyFormatRp,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: CustomTextStyle.bigText.copyWith(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

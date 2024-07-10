import 'package:flutter/material.dart';
import 'package:mybidan/core/assets/assets.gen.dart';
import 'package:mybidan/core/constants/text_style.dart';
import 'package:mybidan/core/extension/int_ext.dart';

class ListOrder extends StatelessWidget {
  final String image;
  final String nameOrder;
  final String dateOrder;
  final bool isSuccess;
  final String pay;
  const ListOrder({
    super.key,
    required this.image,
    required this.nameOrder,
    required this.dateOrder,
    required this.isSuccess,
    required this.pay,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Image.asset(
            image,
            width: 49,
            height: 46,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 11.0,
          ),
          SizedBox(
            width: 88,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nameOrder,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyle.primaryText,
                ),
                Text(
                  dateOrder,
                  style: CustomTextStyle.greenText.copyWith(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 11),
          Container(
            width: 2,
            height: 35,
            decoration: BoxDecoration(
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(width: 8),
          Image.asset(
            Assets.icons.documentTextSharp.path,
            width: 24,
            height: 24,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 8),
          Image.asset(
            isSuccess == true
                ? Assets.icons.checkmarkCircleOutline.path
                : Assets.icons.failedIcon.path,
            width: 24,
            height: 24,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 8),
          Container(
            width: 2,
            height: 35,
            decoration: BoxDecoration(
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Text(
              int.parse(pay).currencyFormatRp,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyle.primaryText,
            ),
          ),
        ],
      ),
    );
  }
}

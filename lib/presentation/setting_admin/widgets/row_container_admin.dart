import 'package:flutter/material.dart';
import 'package:mybidan/core.dart';

class RowContainerAdmin extends StatelessWidget {
  final String title;
  final String subTitle;
  const RowContainerAdmin(
      {super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title : ",
          style: CustomTextStyle.primaryText.copyWith(
            color: Colors.white,
          ),
        ),
        Expanded(
          child: Text(
            subTitle,
            style: CustomTextStyle.primaryText.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

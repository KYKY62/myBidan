import 'package:flutter/material.dart';
import 'package:mybidan/core/constants/text_style.dart';

class SmallCard extends StatelessWidget {
  final Color? color;
  final EdgeInsetsGeometry padding;
  final String icon;
  final String label;

  const SmallCard({
    super.key,
    this.color,
    required this.padding,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: color,
          child: Padding(
            padding: padding,
            child: Image.asset(
              icon,
              width: 20,
            ),
          ),
        ),
        Text(
          label,
          style: CustomTextStyle.smallerText,
        )
      ],
    );
  }
}

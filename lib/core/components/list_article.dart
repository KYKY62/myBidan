// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:mybidan/core/assets/assets.gen.dart';
import 'package:mybidan/core/constants/text_style.dart';

class ListArticle extends StatelessWidget {
  final String nameArticle;
  final dynamic photo;
  final dynamic onTapEdit;
  final dynamic onTapDelete;
  const ListArticle({
    super.key,
    required this.nameArticle,
    required this.photo,
    required this.onTapEdit,
    required this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Image.network(photo, width: 49, height: 46, fit: BoxFit.cover),
          const SizedBox(
            width: 11.0,
          ),
          Expanded(
            child: SizedBox(
              child: Text(
                nameArticle,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: CustomTextStyle.primaryText,
              ),
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
          GestureDetector(
            onTap: onTapEdit,
            child: Image.asset(
              Assets.icons.eyeOutline.path,
              width: 11,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onTapDelete,
            child: Image.asset(
              Assets.icons.delete.path,
              width: 11,
              fit: BoxFit.cover,
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
        ],
      ),
    );
  }
}

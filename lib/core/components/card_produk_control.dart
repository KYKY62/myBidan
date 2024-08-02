import 'package:flutter/material.dart';
import 'package:mybidan/core/constants/text_style.dart';
import 'package:mybidan/core/extension/int_ext.dart';

class CardProdukControl extends StatelessWidget {
  final String photo;
  final String title;
  final String kategori;
  final String hargaAsli;
  final String hargaPromo;
  const CardProdukControl({
    super.key,
    required this.photo,
    required this.title,
    required this.kategori,
    required this.hargaAsli,
    required this.hargaPromo,
  });

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
            child: Image.network(
              photo,
              fit: BoxFit.cover,
              width: 200,
              height: 200,
            ),
          ),
        ),
        Positioned(
          top: 100,
          bottom: 20,
          child: Container(
            width: 200,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black38,
                      blurRadius: 8,
                      offset: Offset(
                        0,
                        8,
                      )),
                ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: CustomTextStyle.smallerText.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 7.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      kategori,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
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
                        int.parse(hargaAsli).currencyFormatRp,
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
                          int.parse(hargaPromo).currencyFormatRp,
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

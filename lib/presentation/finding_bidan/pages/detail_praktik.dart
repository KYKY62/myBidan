import 'package:flutter/material.dart';
import 'package:mybidan/core/components/custom_card.dart';
import 'package:mybidan/core/constants/text_style.dart';

class DetailPraktikPage extends StatelessWidget {
  const DetailPraktikPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CustomCard(
              name: "Praktek Fatmawati",
              description: "Fatmawati S.Keb M.Keb",
              dateOperational: "13 april 2021",
              timeOperational: "13:00 - 14:00",
              horizontalGap: 25,
              findBidanPage: true,
              image:
                  'https://firebasestorage.googleapis.com/v0/b/getconnect-project-9b7d7.appspot.com/o/photoArticle-1722013448480.jpg?alt=media&token=3a57bdea-aa8b-41ca-b596-52d4bab7647c',
              backgroundColor: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Alamat :",
                        style: CustomTextStyle.smText.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 42,
                      ),
                      SizedBox(
                        width: 160,
                        child: Text(
                          "Jl. Ir. H. Juanda No.17, Jodipan, Kec. Blimbing, Kota Malang, Jawa Timur 65126",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                          style: CustomTextStyle.smText.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Telepon :",
                        style: CustomTextStyle.smText.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 39,
                      ),
                      SizedBox(
                        width: 140,
                        child: Text(
                          "0812-3456-7890",
                          style: CustomTextStyle.smText.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Jam Praktek :",
                        style: CustomTextStyle.smText.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      SizedBox(
                        width: 160,
                        child: Text(
                          "Senin 07.00-11.00, 16.00-20.00\nSelasa 07.00-11.00, 16.00-20.00",
                          style: CustomTextStyle.smText.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

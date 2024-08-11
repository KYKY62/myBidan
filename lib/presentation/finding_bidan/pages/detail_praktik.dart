import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mybidan/core.dart';

class DetailPraktikPage extends StatelessWidget {
  final DocumentSnapshot? klinikData;
  const DetailPraktikPage({super.key, this.klinikData});

  @override
  Widget build(BuildContext context) {
    Timestamp timeAwalstampConvert = klinikData!['jamAwalKerja'];
    Timestamp timeAkhirstampConvert = klinikData!['jamAkhirKerja'];

    String dateTimeAwal = timeAwalstampConvert.toDate().toFormattedInHours();
    String dateTimeAkhir = timeAkhirstampConvert.toDate().toFormattedInHours();
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
            CustomCard(
              name: klinikData!['namaKlinik'],
              description: klinikData!['namaBidan'],
              dateOperational: DateTime.now().toFormattedTime(),
              timeOperational: "$dateTimeAwal - $dateTimeAkhir",
              horizontalGap: 25,
              findBidanPage: true,
              image: klinikData!['photo'],
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
                          klinikData!['alamat'],
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
                          klinikData!['telepon'],
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
                          klinikData!['jamPraktek'],
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

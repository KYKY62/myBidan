import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:mybidan/core.dart';

class PremiumAction extends StatelessWidget {
  final chatC = Get.put(ChatController());
  PremiumAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Akun ada belum premium untuk menggunakan fitur ini.",
          textAlign: TextAlign.center,
          style: CustomTextStyle.primaryText,
        ),
        const SizedBox(
          height: 15.0,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: chatC.getAdmin(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                          height: 500,
                          width: Get.width,
                          child:
                              const Center(child: CircularProgressIndicator()),
                        );
                      }
                      var dataAdmin = snapshot.data!.docs;
                      return SizedBox(
                        height: 500,
                        width: Get.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  "Metode Pembayaran",
                                  style: CustomTextStyle.primaryText,
                                ),
                              ),
                              Obx(
                                () => chatC.accountBank.value != ''
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 24),
                                        child: Text(
                                          chatC.accountBank.value,
                                          style: CustomTextStyle.greenText
                                              .copyWith(
                                            fontSize: 24,
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                              ),
                              Obx(
                                () => Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 8.0,
                                  runSpacing: 4.0,
                                  children: [
                                    GestureDetector(
                                      onTap: () => chatC.chipSelected(
                                        chipValue: 1,
                                        akunBank: dataAdmin[0]['account_bca'],
                                      ),
                                      child: Chip(
                                        backgroundColor:
                                            chatC.isSelected.value == 1
                                                ? AppColors.green
                                                : Colors.white,
                                        label: const Text("BCA"),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => chatC.chipSelected(
                                        chipValue: 2,
                                        akunBank: dataAdmin[0]
                                            ['account_mandiri'],
                                      ),
                                      child: Chip(
                                        backgroundColor:
                                            chatC.isSelected.value == 2
                                                ? AppColors.green
                                                : Colors.white,
                                        label: const Text("MANDIRI"),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => chatC.chipSelected(
                                        chipValue: 3,
                                        akunBank: dataAdmin[0]['account_bri'],
                                      ),
                                      child: Chip(
                                        backgroundColor:
                                            chatC.isSelected.value == 3
                                                ? AppColors.green
                                                : Colors.white,
                                        label: const Text("BRI"),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => chatC.chipSelected(
                                        chipValue: 4,
                                        akunBank: dataAdmin[0]['account_bni'],
                                      ),
                                      child: Chip(
                                        backgroundColor:
                                            chatC.isSelected.value == 4
                                                ? AppColors.green
                                                : Colors.white,
                                        label: const Text("BNI"),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => chatC.chipSelected(
                                        chipValue: 5,
                                        akunBank: dataAdmin[0]['account_bsi'],
                                      ),
                                      child: Chip(
                                        backgroundColor:
                                            chatC.isSelected.value == 5
                                                ? AppColors.green
                                                : Colors.white,
                                        label: const Text("BSI Syariah"),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => chatC.chipSelected(
                                        chipValue: 6,
                                        akunBank: dataAdmin[0]
                                            ['account_permata'],
                                      ),
                                      child: Chip(
                                        backgroundColor:
                                            chatC.isSelected.value == 6
                                                ? AppColors.green
                                                : Colors.white,
                                        label: const Text("PERMATA"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              GestureDetector(
                                onTap: () => chatC.selectedImage(),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 155,
                                    decoration: const BoxDecoration(
                                      border: DashedBorder.fromBorderSide(
                                        dashLength: 15,
                                        side: BorderSide(
                                            color: Colors.black, width: 2),
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Obx(
                                      () => chatC.image.value != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              child: Image.memory(
                                                chatC.image.value!,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : const Center(
                                              child:
                                                  Text("Upload Bukti Transfer"),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              SizedBox(
                                width: Get.width,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: () => chatC.pembayaranAction(),
                                  child: Obx(
                                    () => Text(
                                      chatC.loading.value
                                          ? "Loading..."
                                          : "Selesai",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
            );
          },
          child: const Text("Premiumkan Sekarang"),
        ),
      ],
    );
  }
}

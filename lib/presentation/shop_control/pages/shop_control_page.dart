import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mybidan/core/assets/assets.gen.dart';
import 'package:mybidan/core/components/card_produk_control.dart';
import 'package:mybidan/core/components/custom_text_field.dart';
import 'package:mybidan/core/components/list_article.dart';
import 'package:mybidan/core/constants/colors.dart';
import 'package:mybidan/core/constants/text_style.dart';
import 'package:mybidan/core/routes/route_name.dart';
import 'package:mybidan/presentation/shop_control/controller/shop_control_controller.dart';

class ShopControlPage extends StatelessWidget {
  final shopC = Get.find<ShopControlController>();
  ShopControlPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.primary,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: AppColors.primary,
    ));

    Widget shortCutTextFormField(
        {required String title,
        required TextEditingController controller,
        required String hintLabel,
        TextInputType? keyboardType,
        List<TextInputFormatter>? inputFormatters}) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: CustomTextStyle.primaryText.copyWith(
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 7.0,
          ),
          CustomTextField(
            padding: 0,
            controller: controller,
            label: hintLabel,
            textStyle: CustomTextStyle.primaryText.copyWith(
              color: Colors.grey,
            ),
            keyboardType: keyboardType ?? TextInputType.text,
            inputColor: Colors.black,
            inputFormatters: inputFormatters ?? [],
          ),
        ],
      );
    }

    Widget shortCutMultiTextFrom({
      required String title,
      required TextEditingController controller,
      required String hintLabel,
    }) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: CustomTextStyle.primaryText.copyWith(
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 7.0,
          ),
          TextFormField(
            controller: controller,
            minLines: 5,
            maxLines: null,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintStyle: CustomTextStyle.primaryText.copyWith(
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              hintText: hintLabel,
              fillColor: Colors.white,
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text(
          "EDUKASI",
          style: CustomTextStyle.primaryText.copyWith(
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () => Get.offAllNamed(RouteName.login),
              child: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SizedBox(
        height: Get.height,
        child: ListView(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 400,
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Stack(
                        children: [
                          Column(
                            children: [
                              Stack(
                                children: [
                                  Image.asset(
                                    Assets.images.backgroundHome.path,
                                    fit: BoxFit.fill,
                                    width: Get.width,
                                  ),
                                  Positioned(
                                    top: 39,
                                    left: 20,
                                    child: Text(
                                      "New Produk",
                                      style:
                                          CustomTextStyle.primaryText.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 20,
                                    child: SizedBox(
                                      width: Get.width,
                                      height: 255,
                                      child: AspectRatio(
                                        aspectRatio: 0.9,
                                        child: StreamBuilder(
                                          stream: shopC.getArticle(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            } else if (!snapshot.hasData ||
                                                snapshot.data!.docs.isEmpty) {
                                              return Text(
                                                "Produk Belum Ada",
                                                style: CustomTextStyle.bigText
                                                    .copyWith(
                                                  color: Colors.white,
                                                ),
                                              );
                                            }
                                            var produkData =
                                                snapshot.data!.docs;

                                            return ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              padding: const EdgeInsets.only(
                                                  right: 30),
                                              itemCount: produkData.length,
                                              separatorBuilder:
                                                  (context, index) =>
                                                      const SizedBox(width: 20),
                                              itemBuilder: (context, index) {
                                                return CardProdukControl(
                                                  photo: produkData[index]
                                                      ['photo'],
                                                  title: produkData[index]
                                                      ['title'],
                                                  kategori: produkData[index]
                                                      ['kategori'],
                                                  hargaAsli: produkData[index]
                                                      ['harga_asli'],
                                                  hargaPromo: produkData[index]
                                                      ['harga_promo'],
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              width: Get.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 26, vertical: 36),
                child: Obx(
                  () => ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Manajement Produk",
                            style: CustomTextStyle.bigText,
                          ),
                          GestureDetector(
                            onTap: () {
                              shopC.isEdit.value = false;
                              shopC.isAddingShop.value =
                                  !shopC.isAddingShop.value;
                              shopC.image.value = null;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 2,
                                  color: AppColors.primary,
                                ),
                              ),
                              child: shopC.isAddingShop.value
                                  ? const Icon(
                                      Icons.keyboard_arrow_left_outlined)
                                  : const Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      shopC.isAddingShop.value
                          // ! ADD BLOG
                          ? SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  shortCutTextFormField(
                                    title: 'Judul',
                                    controller: shopC.judulController,
                                    hintLabel: 'Judul Produk',
                                  ),
                                  const SizedBox(
                                    height: 24.0,
                                  ),
                                  Text(
                                    "Gambar",
                                    style: CustomTextStyle.primaryText.copyWith(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 7.0,
                                  ),
                                  Obx(
                                    () => Row(
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.primary,
                                            fixedSize:
                                                const Size.fromWidth(150),
                                          ),
                                          onPressed: () =>
                                              shopC.selectedImage(),
                                          child: Text(
                                            'Upload Gambar',
                                            style: CustomTextStyle.smallerText,
                                          ),
                                        ),
                                        const SizedBox(width: 20.0),
                                        shopC.image.value != null
                                            ? const CircleAvatar(
                                                radius: 15,
                                                backgroundColor: Colors.green,
                                                child: Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                  size: 15,
                                                ),
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 24.0,
                                  ),
                                  shortCutMultiTextFrom(
                                    title: 'Deskripsi',
                                    controller: shopC.deskripsiController,
                                    hintLabel: 'Masukkan isi Deskripsi',
                                  ),
                                  const SizedBox(height: 24),
                                  shortCutMultiTextFrom(
                                    title: 'Bahan',
                                    controller: shopC.bahanController,
                                    hintLabel: 'Masukkan isi Bahan',
                                  ),
                                  const SizedBox(height: 24),
                                  shortCutTextFormField(
                                    title: 'Kategori',
                                    controller: shopC.kategoriController,
                                    hintLabel: 'Kategori Produk',
                                  ),
                                  const SizedBox(height: 24),
                                  shortCutTextFormField(
                                    title: 'Harga Asli',
                                    controller: shopC.hargaAsliController,
                                    hintLabel: 'Harga Asli',
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]'))
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  shortCutTextFormField(
                                    title: 'Harga Promo',
                                    controller: shopC.hargaPromoController,
                                    hintLabel: 'Harga Promo',
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]'))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 49.0,
                                  ),
                                  shopC.loading.value
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.primary,
                                            fixedSize:
                                                Size.fromWidth(Get.width),
                                          ),
                                          onPressed: () => shopC.editOrAdd(),
                                          child: Text(
                                            'GET STARTED',
                                            style: CustomTextStyle.primaryText
                                                .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            )
                          : StreamBuilder(
                              stream: shopC.getArticle(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.docs.isEmpty) {
                                  return SizedBox(
                                    height: 150,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Produk Belum Ada",
                                          style: CustomTextStyle.bigText,
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                var produkData = snapshot.data!.docs;

                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: produkData.length,
                                  itemBuilder: (context, index) {
                                    dynamic onTapEdits() {
                                      shopC.doc = produkData[index].id;
                                      shopC.judulController.text =
                                          produkData[index]['title'];
                                      shopC.deskripsiController.text =
                                          produkData[index]['deskripsi'];
                                      shopC.hargaAsliController.text =
                                          produkData[index]['harga_asli'];
                                      shopC.kategoriController.text =
                                          produkData[index]['kategori'];
                                      shopC.hargaPromoController.text =
                                          produkData[index]['harga_promo'];
                                      shopC.bahanController.text =
                                          produkData[index]['bahan'];
                                      shopC.isEdit.value = true;
                                      shopC.isAddingShop.value =
                                          !shopC.isAddingShop.value;
                                    }

                                    return produkData.length == 1
                                        ? SizedBox(
                                            height: 150,
                                            child: Column(
                                              children: [
                                                ListArticle(
                                                  photo: produkData[index]
                                                      ['photo'],
                                                  nameArticle: produkData[index]
                                                      ['title'],
                                                  onTapEdit: () => onTapEdits(),
                                                  onTapDelete: () =>
                                                      shopC.deleteArticle(
                                                    doc: produkData[index].id,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : ListArticle(
                                            photo: produkData[index]['photo'],
                                            nameArticle: produkData[index]
                                                ['title'],
                                            onTapEdit: () => onTapEdits(),
                                            onTapDelete: () =>
                                                shopC.deleteArticle(
                                              doc: produkData[index].id,
                                            ),
                                          );
                                  },
                                );
                              },
                            )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

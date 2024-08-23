import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mybidan/core.dart';

class EducationControlPage extends StatelessWidget {
  final educationC = Get.find<EducationControlController>();
  final authC = Get.find<LoginController>();
  EducationControlPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.primary,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: AppColors.primary,
    ));

    Widget shortCutTextFormField({
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
          CustomTextField(
            padding: 0,
            controller: controller,
            label: hintLabel,
            textStyle: CustomTextStyle.primaryText.copyWith(
              color: Colors.grey,
            ),
            keyboardType: TextInputType.text,
            inputColor: Colors.black,
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
              onTap: () => authC.logOut(),
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
                                      "New artikel",
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
                                      child: StreamBuilder(
                                        stream: educationC.getArticle(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else if (!snapshot.hasData ||
                                              snapshot.data!.docs.isEmpty) {
                                            return Text(
                                              "Artikel Belum Ada",
                                              style: CustomTextStyle.bigText
                                                  .copyWith(
                                                color: Colors.white,
                                              ),
                                            );
                                          }
                                          var articleData = snapshot.data!.docs;

                                          return ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            padding: const EdgeInsets.only(
                                                right: 40),
                                            itemCount: articleData.length,
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(width: 20),
                                            itemBuilder: (context, index) {
                                              return CardDataArticle(
                                                photo: articleData[index]
                                                    ['photo'],
                                                title: articleData[index]
                                                    ['title'],
                                                desc: articleData[index]
                                                    ['contentArticle'],
                                                author: articleData[index]
                                                    ['author'],
                                                onTap: () {},
                                              );
                                            },
                                          );
                                        },
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
                            "Manajement Artikel ",
                            style: CustomTextStyle.bigText,
                          ),
                          GestureDetector(
                            onTap: () {
                              educationC.isEdit.value = false;
                              educationC.isAdding.value =
                                  !educationC.isAdding.value;
                              educationC.image.value = null;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 2,
                                  color: AppColors.primary,
                                ),
                              ),
                              child: educationC.isAdding.value
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
                      educationC.isAdding.value
                          // ! ADD BLOG
                          ? SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  shortCutTextFormField(
                                    title: 'Judul',
                                    controller: educationC.judulController,
                                    hintLabel: 'Judul artikel',
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
                                              educationC.selectedImage(),
                                          child: Text(
                                            'Upload Gambar',
                                            style: CustomTextStyle.smallerText,
                                          ),
                                        ),
                                        const SizedBox(width: 20.0),
                                        educationC.image.value != null
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
                                  Text(
                                    "isi artikel",
                                    style: CustomTextStyle.primaryText.copyWith(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 7.0,
                                  ),
                                  TextFormField(
                                    controller:
                                        educationC.blogContentController,
                                    minLines: 5,
                                    maxLines: null,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      hintStyle:
                                          CustomTextStyle.primaryText.copyWith(
                                        color: Colors.grey,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                      ),
                                      hintText: 'Masukkan isi artikel',
                                      fillColor: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  shortCutTextFormField(
                                    title: 'Deskripsi Singkat',
                                    controller: educationC.shortDescController,
                                    hintLabel: 'Deskripsi singkat',
                                  ),
                                  const SizedBox(height: 24),
                                  shortCutTextFormField(
                                    title: 'Penulis',
                                    controller: educationC.authorController,
                                    hintLabel: 'Penulis',
                                  ),
                                  const SizedBox(height: 24),
                                  shortCutTextFormField(
                                    title: 'Sub Artikel',
                                    controller:
                                        educationC.tipeArticleController,
                                    hintLabel: 'Sub artikel',
                                  ),
                                  const SizedBox(height: 19),
                                  Text(
                                    'Kategori Artikel',
                                    style: CustomTextStyle.primaryText.copyWith(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 7),
                                  Container(
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                        width: 1.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    child: DropdownButton<String>(
                                      value: educationC.kategori.value,
                                      hint: const Text('Pilih Kategori'),
                                      isExpanded: true,
                                      items: educationC.dropdownItems,
                                      onChanged: (String? newValue) {
                                        educationC.kategori.value = newValue!;
                                      },
                                    ),
                                  ),
                                  // DropdownMenu(
                                  //     hintText: 'Kategori Artikel',
                                  //     inputDecorationTheme:
                                  //         InputDecorationTheme(
                                  //       enabledBorder: OutlineInputBorder(
                                  //         borderSide: const BorderSide(
                                  //           color: Colors.grey,
                                  //         ),
                                  //         borderRadius:
                                  //             BorderRadius.circular(10.0),
                                  //       ),
                                  //       contentPadding:
                                  //           const EdgeInsets.symmetric(
                                  //         vertical: 15.0,
                                  //         horizontal: 10.0,
                                  //       ),
                                  //       filled: true,
                                  //       fillColor: Colors.white,
                                  //     ),
                                  //     dropdownMenuEntries: dropdownItems,
                                  //     onSelected: (value) {
                                  //       educationC.kategori.value = value;
                                  //       print(educationC.kategori.value);
                                  //     }),
                                  const SizedBox(
                                    height: 49.0,
                                  ),
                                  educationC.loading.value
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.primary,
                                            fixedSize:
                                                Size.fromWidth(Get.width),
                                          ),
                                          onPressed: () =>
                                              educationC.editOrAdd(),
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
                              stream: educationC.getArticle(),
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
                                          "Artikel Belum Ada",
                                          style: CustomTextStyle.bigText,
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                var articleData = snapshot.data!.docs;

                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: articleData.length,
                                  itemBuilder: (context, index) {
                                    dynamic onTapEdits() {
                                      educationC.doc = articleData[index].id;
                                      educationC.judulController.text =
                                          articleData[index]['title'];
                                      educationC.blogContentController.text =
                                          articleData[index]['contentArticle'];
                                      educationC.tipeArticleController.text =
                                          articleData[index]['subject'];
                                      educationC.shortDescController.text =
                                          articleData[index]['shortDesc'];
                                      educationC.authorController.text =
                                          articleData[index]['author'];
                                      educationC.kategori.value =
                                          articleData[index]['kategori'];
                                      educationC.isEdit.value = true;
                                      educationC.isAdding.value =
                                          !educationC.isAdding.value;
                                    }

                                    return articleData.length == 1
                                        ? SizedBox(
                                            height: 150,
                                            child: Column(
                                              children: [
                                                ListArticle(
                                                  photo: articleData[index]
                                                      ['photo'],
                                                  nameArticle:
                                                      articleData[index]
                                                          ['title'],
                                                  onTapEdit: () => onTapEdits(),
                                                  onTapDelete: () =>
                                                      educationC.deleteArticle(
                                                    doc: articleData[index].id,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : ListArticle(
                                            photo: articleData[index]['photo'],
                                            nameArticle: articleData[index]
                                                ['title'],
                                            onTapEdit: () => onTapEdits(),
                                            onTapDelete: () =>
                                                educationC.deleteArticle(
                                              doc: articleData[index].id,
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

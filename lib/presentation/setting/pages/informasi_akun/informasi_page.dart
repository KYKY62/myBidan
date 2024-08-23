import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mybidan/core/constants/colors.dart';
import 'package:mybidan/core/constants/text_style.dart';
import 'package:mybidan/presentation/setting/controller/setting_controller.dart';

class InformasiPage extends StatelessWidget {
  final settingC = Get.find<SettingController>();
  InformasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Informasi Akun"),
        actions: const [],
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.primary,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarDividerColor: AppColors.primary,
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: settingC.getProfileUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              var dataUser = snapshot.data!.data();
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              top: 28.0,
                            ),
                            padding: const EdgeInsets.all(12.0),
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  8.0,
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  '${dataUser!['name']}'.capitalize!,
                                  style: CustomTextStyle.primaryText.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.email,
                                          color: Colors.white,
                                          size: 12.0,
                                        ),
                                        const SizedBox(
                                          width: 4.0,
                                        ),
                                        Text(
                                          dataUser['email'],
                                          style: CustomTextStyle.smallerText,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on_sharp,
                                          color: Colors.white,
                                          size: 12.0,
                                        ),
                                        const SizedBox(
                                          width: 4.0,
                                        ),
                                        Text(
                                          "Indonesia",
                                          style: CustomTextStyle.smallerText,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                StreamBuilder<
                                        DocumentSnapshot<Map<String, dynamic>>>(
                                    stream: dataUser['uidKlinik'] != ''
                                        ? settingC.getKlinikUser(
                                            dataUser['uidKlinik'])
                                        : null,
                                    builder: (context, snapshotKlinik) {
                                      if (snapshotKlinik.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }

                                      if (dataUser['uidKlinik'] == '') {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Rujukan Klinik Cepat",
                                                  style: CustomTextStyle
                                                      .smallerText,
                                                ),
                                                StreamBuilder<
                                                        QuerySnapshot<Object?>>(
                                                    stream:
                                                        settingC.getKlinik(),
                                                    builder: (context,
                                                        snapshotDropdown) {
                                                      if (snapshotDropdown
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return const Icon(
                                                          Icons.edit,
                                                          size: 14,
                                                          color: Colors.white,
                                                        );
                                                      }
                                                      var dataKlinik =
                                                          snapshotDropdown
                                                              .data!.docs;
                                                      // Dropdown
                                                      List<DropdownMenuEntry>
                                                          dropdownItems =
                                                          dataKlinik.map((doc) {
                                                        var data = doc.data()
                                                            as Map<String,
                                                                dynamic>;
                                                        return DropdownMenuEntry(
                                                          value: doc.id,
                                                          label: data[
                                                              'namaKlinik'],
                                                          labelWidget:
                                                              Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    bottom: 10),
                                                            child: SizedBox(
                                                              width: 170,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      'Nama Klinik : ${data['namaKlinik']}'),
                                                                  Text(
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      'Nama Bidan : ${data['namaBidan']}'),
                                                                  Text(
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      'Alamat : ${data['alamat']}'),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }).toList();

                                                      return GestureDetector(
                                                        onTap: () {
                                                          Get.defaultDialog(
                                                            title:
                                                                'Klinik Cepat',
                                                            middleText: '',
                                                            content: Column(
                                                              children: [
                                                                DropdownMenu(
                                                                  hintText:
                                                                      'Pilih Klinik',
                                                                  dropdownMenuEntries:
                                                                      dropdownItems,
                                                                  onSelected: (value) =>
                                                                      settingC
                                                                          .labelDropdown
                                                                          .value = value,
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                ElevatedButton(
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    backgroundColor:
                                                                        AppColors
                                                                            .primary,
                                                                    foregroundColor:
                                                                        Colors
                                                                            .white,
                                                                  ),
                                                                  onPressed: () =>
                                                                      settingC
                                                                          .updatePanicButton(),
                                                                  child:
                                                                      const Text(
                                                                    "Simpan",
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                        child: const Icon(
                                                          Icons.edit,
                                                          size: 14,
                                                          color: Colors.white,
                                                        ),
                                                      );
                                                    }),
                                              ],
                                            ),
                                            const SizedBox(height: 20),
                                            Text(
                                              "Belum ada Klinik Cepat yang dipilih",
                                              style: CustomTextStyle.primaryText
                                                  .copyWith(
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                          ],
                                        );
                                      }
                                      var dataKlinik =
                                          snapshotKlinik.data!.data();
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Rujukan Klinik Cepat",
                                                style:
                                                    CustomTextStyle.smallerText,
                                              ),
                                              StreamBuilder<
                                                      QuerySnapshot<Object?>>(
                                                  stream: settingC.getKlinik(),
                                                  builder: (context,
                                                      snapshotDropdown) {
                                                    if (snapshotDropdown
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const Icon(
                                                        Icons.edit,
                                                        size: 14,
                                                        color: Colors.white,
                                                      );
                                                    }
                                                    var dataKlinik =
                                                        snapshotDropdown
                                                            .data!.docs;
                                                    // Dropdown
                                                    List<DropdownMenuEntry>
                                                        dropdownItems =
                                                        dataKlinik.map((doc) {
                                                      var data = doc.data()
                                                          as Map<String,
                                                              dynamic>;
                                                      return DropdownMenuEntry(
                                                        value: doc.id,
                                                        label:
                                                            data['namaKlinik'],
                                                        labelWidget: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 10),
                                                          child: SizedBox(
                                                            width: 170,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    'Nama Klinik : ${data['namaKlinik']}'),
                                                                Text(
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    'Nama Bidan : ${data['namaBidan']}'),
                                                                Text(
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    'Alamat : ${data['alamat']}'),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }).toList();

                                                    return GestureDetector(
                                                      onTap: () {
                                                        Get.defaultDialog(
                                                          title: 'Klinik Cepat',
                                                          middleText: '',
                                                          content: Column(
                                                            children: [
                                                              DropdownMenu(
                                                                hintText:
                                                                    'Pilih Klinik',
                                                                dropdownMenuEntries:
                                                                    dropdownItems,
                                                                onSelected: (value) =>
                                                                    settingC
                                                                        .labelDropdown
                                                                        .value = value,
                                                              ),
                                                              const SizedBox(
                                                                  height: 10),
                                                              ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                      AppColors
                                                                          .primary,
                                                                  foregroundColor:
                                                                      Colors
                                                                          .white,
                                                                ),
                                                                onPressed: () =>
                                                                    settingC
                                                                        .updatePanicButton(),
                                                                child:
                                                                    const Text(
                                                                  "Simpan",
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                      child: const Icon(
                                                        Icons.edit,
                                                        size: 14,
                                                        color: Colors.white,
                                                      ),
                                                    );
                                                  }),
                                            ],
                                          ),
                                          const SizedBox(height: 30),
                                          widgetKlinik(
                                            title: 'Nama Klinik',
                                            dataKlinik:
                                                dataKlinik!['namaKlinik'],
                                          ),
                                          widgetKlinik(
                                            title: 'Nama Bidan',
                                            dataKlinik: dataKlinik['namaBidan'],
                                          ),
                                          widgetKlinik(
                                            title: 'Alamat',
                                            dataKlinik: dataKlinik['alamat'],
                                          ),
                                          widgetKlinik(
                                            title: 'Jam Praktik',
                                            dataKlinik:
                                                dataKlinik['jamPraktek'],
                                          ),
                                        ],
                                      );
                                    }),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                dataUser['photoUrl'],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget widgetKlinik({required String title, required String dataKlinik}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: CustomTextStyle.smallerText,
          ),
          SizedBox(
            width: 200,
            child: Text(
              dataKlinik,
              textAlign: TextAlign.end,
              style: CustomTextStyle.smallerText,
            ),
          ),
        ],
      ),
    );
  }

  void dialogEdit({
    required List<DropdownMenuEntry<dynamic>> dropdownMenuEntries,
    required String onSelected,
  }) {
    Get.defaultDialog(
      title: 'Klinik Cepat',
      middleText: '',
      content: Column(
        children: [
          DropdownMenu(
            hintText: 'Pilih Klinik',
            dropdownMenuEntries: dropdownMenuEntries,
            onSelected: (value) => onSelected,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            onPressed: () => settingC.updatePanicButton(),
            child: const Text(
              "Simpan",
            ),
          ),
        ],
      ),
    );
  }
}

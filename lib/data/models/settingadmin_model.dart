// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SettingadminModel {
  final String? doc;
  final String goals;
  final TextEditingController? rekeningBcaC;
  final TextEditingController? rekeningBniC;
  final TextEditingController? rekeningBriC;
  final TextEditingController? rekeningBsiC;
  final TextEditingController? rekeningMandiriC;
  final TextEditingController? rekeningPermataC;
  final TextEditingController? nomorTelepon;
  SettingadminModel({
    this.doc,
    required this.goals,
    this.rekeningBcaC,
    this.rekeningBniC,
    this.rekeningBriC,
    this.rekeningBsiC,
    this.rekeningMandiriC,
    this.rekeningPermataC,
    this.nomorTelepon,
  });
}

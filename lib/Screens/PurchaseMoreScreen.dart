import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/QuizColors.dart';
import 'QuizSettings.dart';

class PurchaseMoreScreen extends StatefulWidget {
  const PurchaseMoreScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PurchaseMoreScreenState createState() => _PurchaseMoreScreenState();
}

class _PurchaseMoreScreenState extends State<PurchaseMoreScreen > {
  
  @override
  Widget build(BuildContext context) {
     return SafeArea(
      child: Scaffold(
        backgroundColor: quiz_app_background,
        appBar: AppBar(
          leading: Container(),
          backgroundColor: quiz_app_background,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Container(color: quiz_app_background),
        ),
      ),
    );
  }
}

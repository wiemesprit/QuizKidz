import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../utils/QuizColors.dart';

class PurchaseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: 'Payer pour voir plus',
      color: quiz_colorPrimary,
      textStyle: boldTextStyle(color: Colors.white),
      shapeBorder: RoundedRectangleBorder(borderRadius: radius(10)),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controller/AuthController.dart';
import '../utils/AppWidget.dart';
import '../utils/QuizColors.dart';
import '../utils/QuizStrings.dart';
import 'QuizContact.dart';
import 'QuizHelp.dart';
import 'QuizPrivacy.dart';

class QuizSettings extends StatefulWidget {
  static String tag = '/QuizSetting';

  @override
  _QuizSettingsState createState() => _QuizSettingsState();
}

class _QuizSettingsState extends State<QuizSettings> {
  @override
  Widget build(BuildContext context) {
    changeStatusColor(quiz_app_background);
    return Scaffold(
      backgroundColor: quiz_app_background,
      appBar: AppBar(
        title: Text(
          quiz_lbl_setting,
          style: primaryTextStyle(size: 18, fontFamily: "Medium"),
        ),
        leading: Icon(
          Icons.arrow_back,
          color: quiz_colorPrimary,
          size: 30,
        ).onTap(() {
          Navigator.of(context).pop();
        }),
        centerTitle: true,
        backgroundColor: quiz_app_background,
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                          color: quiz_white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: defaultBoxShadow()),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: <Widget>[
                          quizSettingOptionPattern3(Icons.help, quiz_lbl_help)
                              .onTap(() {
                            setState(() {
                              QuizHelp().launch(context);
                            });
                          }),
                          quizSettingOptionPattern3(
                                  Icons.security, quiz_lbl_privacy)
                              .onTap(() {
                            setState(() {
                              QuizPrivacy().launch(context);
                            });
                          }),
                          quizSettingOptionPattern3(
                                  Icons.chat_bubble, quiz_lbl_contact_us)
                              .onTap(() {
                            setState(() {
                              QuizContact().launch(context);
                            });
                          }),
                        ],
                      ),
                    ),
                    Text(
                      quiz_lbl_logout,
                      style: boldTextStyle(color: quiz_colorPrimary, size: 18),
                    ).paddingAll(16).onTap(() {
                      setState(() {
                        AuthController.instance.logout();
                      });
                    })
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget quizSettingOptionPattern1(var settingIcon, var heading, var info) {
  return Padding(
    padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: quiz_color_setting),
              width: 45,
              height: 45,
              padding: EdgeInsets.all(4),
              child: Icon(
                settingIcon,
                color: quiz_white,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(heading),
                Text(
                  info,
                  style: primaryTextStyle(
                      color: quiz_textColorSecondary, size: 14),
                )
              ],
            ),
          ],
        ),
        Icon(
          Icons.keyboard_arrow_right,
          color: quiz_icon_color,
        )
      ],
    ),
  );
}

Widget quizSettingOptionPattern2(var icon, var heading) {
  bool isSwitched1 = false;

  return Padding(
    padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: quiz_color_setting),
              width: 45,
              height: 45,
              padding: EdgeInsets.all(4),
              child: Icon(
                icon,
                color: quiz_white,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Text(heading),
          ],
        ),
        Switch(
          value: isSwitched1,
          onChanged: (value) {
            // setState(() {
            isSwitched1 = value;
            //  });
          },
          activeTrackColor: quiz_colorPrimary,
          activeColor: quiz_view_color,
        )
      ],
    ),
  );
}

Widget quizSettingOptionPattern3(var icon, var heading) {
  return Padding(
    padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: quiz_color_setting),
              width: 45,
              height: 45,
              padding: EdgeInsets.all(4),
              child: Icon(
                icon,
                color: quiz_white,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Text(heading),
          ],
        ),
        Icon(
          Icons.keyboard_arrow_right,
          color: quiz_icon_color,
        )
      ],
    ),
  );
}

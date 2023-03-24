import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_application/data/models/User.dart';
import 'package:nb_utils/nb_utils.dart';
import '../controller/ProfileController.dart';
import '../model/QuizModels.dart';
import '../utils/AppWidget.dart';
import '../utils/Consts.dart';
import '../utils/QuizColors.dart';
import '../utils/QuizConstant.dart';
import '../utils/QuizStrings.dart';
import 'QuizSettings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizProfile extends StatefulWidget {
  static String tag = '/QuizProfile';
  UserBodyRes? user;
 late final String imageUrl;
 
  @override
  _QuizProfileState createState() => _QuizProfileState();
}

class _QuizProfileState extends State<QuizProfile> {
  
  List<BadgeBodyRes> mList = [];
  List<QuizScoresModel> mList1 = [];
  UserBodyRes? user;
  int selectedPos = 1;
   int _selectedImageIndex = 0 ;
 
  final List<String> _imagePaths = [ "images/quiz/0.png" ,"images/quiz/1.png",
   "images/quiz/2.png","images/quiz/3.png" ,"images/quiz/4.png" ,"images/quiz/5.png",
  "images/quiz/6.png","images/quiz/7.png","images/quiz/8.png", "images/quiz/9.png","images/quiz/10.png",
  "images/quiz/11.png" ,"images/quiz/12.png" ,"images/quiz/13.png","images/quiz/14.png","images/quiz/15.png"];
    @override
  void initState() {
    super.initState();
  loadIndex().then((int index) {
      setState(() {
        _selectedImageIndex = index;
      });
    });
    selectedPos = 1;
    ProfileController.instance.getMyProfile().then((value) {
      setState(() {
        user = value;
        ProfileController.instance.getBadges().then((value) {
          setState(() {
            mList = value?.map((e) {
                  if ((user?.badges ?? [])
                      .map((e) => e.id)
                      .toList()
                      .contains(e.id)) {
                    e.owned = true;
                  }
                  return e;
                }).toList() ??
                [];
          });
        });
      });
    });
  }
 
Future<void> saveIndex(int index) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('index', index);
}

Future<int> loadIndex() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('index') ?? 0;
}

 MyAlert(){
 showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Choisissez votre avatar", textAlign: TextAlign.center,),
                content:SizedBox(
    height: 400.0,
    width:10,
              
                  child:  ListView.builder(
      itemCount: _imagePaths.length,
      itemBuilder: (BuildContext context, int index) {
        return   RadioListTile(
           
                      title: Image.asset(_imagePaths[index]),
                      value: index,
                      groupValue: _selectedImageIndex,
                      onChanged: (int? Value) {
                        setState(() {
                        _selectedImageIndex = Value!;
                         


                        });
                      },  
                    );
                    
                  }),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text("Cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text("OK"),
                    onPressed: () async {
                   
                          saveIndex(_selectedImageIndex);
                int savedIndex = await loadIndex();
                   print('Saved index: $savedIndex');
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        
 }      
            
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
         saveIndex(_selectedImageIndex);
    final imgview = Container(
      color: quiz_app_background,
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
   

                               
                          CircleAvatar(
  radius: 60,
  backgroundImage: Image.asset(_imagePaths[_selectedImageIndex]).image,
  backgroundColor:transparentColor ,
),

      


              
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: quiz_white, width: 2),
                    color: quiz_white),
                child: const Icon(Icons.edit, size: 20).onTap(() {
              MyAlert();
          
         },),)
            ],
          ),
          text('${user?.firstname} ${user?.lastname}',
                  textColor: quiz_textColorPrimary,
                  fontSize: textSizeLargeMedium,
                  fontFamily: fontBold)
              .paddingOnly(top: 24),
          text('${user?.score} ',
                  textColor: quiz_textColorSecondary,
                  fontSize: textSizeMedium,
                  fontFamily: fontRegular)
              .paddingOnly(top: 8),
          const SizedBox(height: 30),
          Container(
            width: width,
            decoration: boxDecoration(
                radius: spacing_middle, bgColor: quiz_white, showShadow: false),
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPos = 1;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(spacing_middle),
                            bottomLeft: Radius.circular(spacing_middle)),
                        color:
                            selectedPos == 1 ? quiz_white : Colors.transparent,
                        border: Border.all(
                            color: selectedPos == 1
                                ? quiz_white
                                : Colors.transparent),
                      ),
                      child: text(
                        quiz_lbl_Badges,
                        fontSize: textSizeMedium,
                        fontFamily: fontSemibold,
                        isCentered: true,
                        textColor: selectedPos == 1
                            ? quiz_textColorPrimary
                            : quiz_textColorSecondary,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: 1,
                  color: quiz_light_gray,
                ).center(),
                
              ],
            ),
          ),
          selectedPos == 1
              ? Container(
                  decoration: boxDecoration(
                      bgColor: quiz_white, radius: 10, showShadow: true),
                  width: MediaQuery.of(context).size.width - 32,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: mList.length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) =>
                          Container(
                            color: (mList[index].owned ?? false)
                                ? Colors.white
                                : Colors.grey.withOpacity(0.2),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  commonCacheImageWidget(
                                    '${Consts.baseUrl}/uploads/${mList[index].image}',
                                    height: 50,
                                    width: 50,
                                  ).paddingOnly(right: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      text(mList[index].name,
                                          fontFamily: fontMedium,
                                          textColor: (mList[index].owned ??
                                                  false)
                                              ? quiz_textColorPrimary
                                              : Colors.grey.withOpacity(0.9)),
                                      text(
                                          '${mList[index].scoreCriteria ?? 0} necessaires pour ce badge',
                                          textColor: (mList[index].owned ??
                                                  false)
                                              ? quiz_textColorPrimary
                                              : Colors.grey.withOpacity(0.9),
                                          fontSize: 12.0)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ))).paddingOnly(bottom: 16)
              : Container(
                  decoration: boxDecoration(
                      bgColor: quiz_white, radius: 10, showShadow: true),
                  width: MediaQuery.of(context).size.width - 32,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: mList1.length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) =>
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  CachedNetworkImage(
                                    placeholder: placeholderWidgetFn() as Widget
                                        Function(BuildContext, String)?,
                                    imageUrl: mList1[index].img,
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.fill,
                                  )
                                      .cornerRadiusWithClipRRect(25)
                                      .paddingOnly(right: 16),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      text(mList1[index].title,
                                          fontFamily: fontMedium,
                                          textColor: quiz_textColorPrimary),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          text(mList1[index].totalQuiz,
                                              textColor:
                                                  quiz_textColorSecondary),
                                          text(mList1[index].scores,
                                              textColor:
                                                  quiz_textColorSecondary,
                                              fontSize: textSizeMedium,
                                              fontFamily: fontRegular)
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ).paddingAll(8),
                          ))).paddingOnly(bottom: 16)
        ],
      ),
    ).center();

    changeStatusColor(quiz_app_background);

    return SafeArea(
      child: Scaffold(
        backgroundColor: quiz_app_background,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.settings),
              color: blackColor,
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => QuizSettings())),
            ),
          ],
          leading: Container(),
          backgroundColor: quiz_app_background,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Container(color: quiz_app_background, child: imgview),
        ),
      ),
    );
  }
}

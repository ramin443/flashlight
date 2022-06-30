import 'dart:async';
import 'dart:async';

import 'package:feather_icons/feather_icons.dart';
import 'package:flashlight/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/font_constants.dart';
import '../constants/image_constants.dart';

class SettingsController extends GetxController {
  bool switchsoundstatus=true;
  bool turnonatstartupstatus=false;
  bool turnoffatstartupstatus=false;
  final InAppReview inAppReview = InAppReview.instance;

  void initializebools()async{
    final prefs= await SharedPreferences.getInstance();
    final switchsoundstat=prefs.getBool('switchsound');
    final turnonatstartupstat=prefs.getBool('turnonatstartup');
    final turnoffatstartupstat=prefs.getBool('turnoffatstartup');
    if(switchsoundstat==null){
      switchsoundstatus=true;
    }else{
      switchsoundstatus=switchsoundstat;

    }
    if(turnonatstartupstat==null){
      turnonatstartupstatus=false;
    }else{
      turnonatstartupstatus=turnonatstartupstat;
    }


    if(turnoffatstartupstat==null){
      turnoffatstartupstatus=false;
    }else{
      turnoffatstartupstatus=turnoffatstartupstat;
    }
    update();
  }

  Widget generaltypetitle(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
        margin: EdgeInsets.only(
            left: screenwidth * 0.0573,
            top: screenwidth*0.04184,
            bottom: screenwidth * 0.0513),
        child: Text(
          "G E N E R A L",
          style: TextStyle(
              fontFamily: intermedium, color: themeredcolor, fontSize:  screenwidth*0.0340),
        ),
      )
    ]);
  }

  Widget abouttypetitle(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
              left: screenwidth * 0.0613,
          bottom: screenwidth * 0.0213),
          child: Text(
            "A B O U T",
            style: TextStyle(
                fontFamily: intermedium, color: themeredcolor, fontSize:  screenwidth*0.0340),
          ),
        ),
      ],
    );
  }

  Future<bool> getswitchsound()async{
    initializebools();
    final prefs= await SharedPreferences.getInstance();
    final switchsound=prefs.getBool('switchsound');
    if(switchsound==null){
      return true;
    }
    return switchsound;
  }
  void changesoundstatus()async{
    switchsoundstatus=!switchsoundstatus;
    update();
  }
  void changeturnonstatus()async{
    turnonatstartupstatus=!turnonatstartupstatus;
    update();
  }
  void changeturnoffstatus()async{
    turnoffatstartupstatus=!turnoffatstartupstatus;
    update();
  }
  Future<void> setswitchsound()async{
    changesoundstatus();
    final prefs= await SharedPreferences.getInstance();
    final switchsound=prefs.getBool('switchsound');
    if(switchsound==null){
      prefs.setBool('switchsound',false);
    }else{
      prefs.setBool('switchsound',!switchsound);
    }
  }
  Future<bool> getturnonatstartup()async{
    final prefs= await SharedPreferences.getInstance();
    final turnon=prefs.getBool('turnonatstartup');
    if(turnon==null){
      return true;
    }
    initializebools();
    return turnon;
  }

  Future<void> setturnonatstartup()async{
    changeturnonstatus();
    final prefs= await SharedPreferences.getInstance();
    final turnon=prefs.getBool('turnonatstartup');
    if(turnon==null){
      prefs.setBool('turnonatstartup',false);
    }else{
      prefs.setBool('turnonatstartup',!turnon);

    }

  }

  Future<bool> getturnoffatstartup()async{
    initializebools();
    final prefs= await SharedPreferences.getInstance();
    final turnoff=prefs.getBool('turnoffatstartup');
    if(turnoff==null){
      initializebools();
      return true;
    }
    initializebools();
    return turnoff;
  }

  Future<void> setturnoffatstartup()async{
    changeturnoffstatus();
    final prefs= await SharedPreferences.getInstance();
    final turnoff=prefs.getBool('turnoffatstartup');
    if(turnoff==null){
      prefs.setBool('turnoffatstartup',false);
    }else{
      prefs.setBool('turnoffatstartup',!turnoff);

    }

  }

  Future<void> increment()async{
    final prefs= await SharedPreferences.getInstance();
    await prefs.setInt('startupnumber', 0);
  }

  Widget generalrow(BuildContext context, String title) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(
          left: screenwidth * 0.0643,
          right: screenwidth * 0.07,
          bottom: screenwidth * 0.048),
      width: screenwidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: screenwidth * 0.0213),
                  child: Text(
                    title,
                    style: TextStyle(
                        fontFamily: interregular,
                        color: Colors.white,
                        fontSize:  screenwidth*0.0340),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(),
                  child: Text(
                    title=="Switch Sound" && switchsoundstatus==true?
                    "Enabled":
                    title=="Switch Sound" && switchsoundstatus==false?
                  "Disabled":
                    title=="Turn on at startup" && turnonatstartupstatus==true?
                  "Enabled":
                    title=="Turn on at startup" && turnonatstartupstatus==false?
                  "Disabled":
                    title=="Turn off at exit" && turnoffatstartupstatus==true?
                    "Enabled":
                    title=="Turn off at exit" && turnoffatstartupstatus==false?
                  "Disabled":
                    "Disabled",
                    style: TextStyle(
                        fontFamily: interregular,
                        color: Color(0xffD6D6D6),
                        fontSize: screenwidth*0.0291),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () {
                switch(title){
                  case "Switch Sound":
                    setswitchsound();
                    break;
                  case "Turn on at startup":
                    setturnonatstartup();
                    break;
                  case "Turn off at exit":
                    setturnoffatstartup();
                    break;
                  default:
                    break;
                }
              },
              icon: Icon(
                title=="Switch Sound" && switchsoundstatus==true?
                    CupertinoIcons.checkmark_alt_circle_fill:
                title=="Switch Sound" && switchsoundstatus==false?
                CupertinoIcons.circle:
                title=="Turn on at startup" && turnonatstartupstatus==true?
                CupertinoIcons.checkmark_alt_circle_fill:
                title=="Turn on at startup" && turnonatstartupstatus==false?
                CupertinoIcons.circle:
                title=="Turn off at exit" && turnoffatstartupstatus==true?
                CupertinoIcons.checkmark_alt_circle_fill:
                title=="Turn off at exit" && turnoffatstartupstatus==false?
                CupertinoIcons.circle:
                CupertinoIcons.circle,
                size: screenwidth*0.0535,
                color:
                title=="Switch Sound" && switchsoundstatus==true?
                themegreencolor:
                title=="Switch Sound" && switchsoundstatus==false?
                Colors.white:
                title=="Turn on at startup" && turnonatstartupstatus==true?
                themegreencolor:
                title=="Turn on at startup" && turnonatstartupstatus==false?
                Colors.white:
                title=="Turn off at exit" && turnoffatstartupstatus==true?
                themegreencolor:
                title=="Turn off at exit" && turnoffatstartupstatus==false?
                Colors.white:
                Colors.white,
              ))
        ],
      ),
    );
  }

  Widget aboutrow(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(

      width: screenwidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              onreviewboxtapped();
            },
            child: Container(

              width: screenwidth,
              margin: EdgeInsets.only(bottom: screenwidth * 0.038,
                  left: screenwidth * 0.0643,
                  right: screenwidth * 0.07,
              top: screenwidth * 0.038 ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    rateusimg,
                    width: screenwidth * 0.0426,
                    color: Colors.white,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: screenwidth * 0.0533),
                    child: Text(
                      "Rate Us",
                      style: TextStyle(
                          fontFamily: interregular,
                          color: Colors.white,
                          fontSize: screenwidth*0.0340),
                    ),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              sendfeedback();
            },
            child: Container(
              width: screenwidth,
              margin: EdgeInsets.only(bottom: screenwidth * 0.038,
                  left: screenwidth * 0.0643,
                  right: screenwidth * 0.07,
                  top: screenwidth * 0.038 ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    FeatherIcons.edit3,
                    color: Colors.white,
                    size: screenwidth * 0.0426,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: screenwidth * 0.0533),
                    child: Text(
                      "Feedback",
                      style: TextStyle(
                          fontFamily: interregular,
                          color: Colors.white,
                          fontSize:  screenwidth*0.0340),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  void sendfeedback()async{
    final Email send_email = Email(
      body: 'Your Feedback',
      subject: 'Feedback- Flashlight',
      recipients: ['piperdownloader@gmail.com'],
      isHTML: false,
    );
    await FlutterEmailSender.send(send_email);
  }

  onreviewboxtapped()async{
    inAppReview.openStoreListing();
    update();
  }
  requestreview()async{
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }

}

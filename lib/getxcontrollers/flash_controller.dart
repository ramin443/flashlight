import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flashlight/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:intl/intl.dart';
import 'package:torch_controller/torch_controller.dart';

import '../constants/font_constants.dart';
class FlashController extends GetxController{
  bool isFlashActive=false;
  bool screenmode=false;
  bool showscreenflash=false;
  Battery battery=Battery();
  int batterypercentage=100;
  late StreamSubscription streamSubscription;
  BatteryState batteryState = BatteryState.full;
  bool hasFlashlight=true;
  final torchController = TorchController();
  final InAppReview inAppReview = InAppReview.instance;

  void screenmodetrue(){
    screenmode=true;
    update();
  }
  void screenmodefalse(){
    screenmode=false;
    update();
  }
  checkifflashlightexists()async{
   // bool flashstatus= await Flashlight.hasFlashlight;
   // hasFlashlight=flashstatus;
    update();
  }
  turnonflashlight()async{
    if(hasFlashlight){
       await torchController.toggle();
    }else{
      //display error msg
    }
  }
  turnoffflashlight()async{
    if(hasFlashlight){
      await torchController.toggle();
    }else{
      //display error msg
    }
  }


  void toggleflashlight()async{
    if(isFlashActive){
      isFlashActive=false;
      showscreenflash=false;
      if(!screenmode){
        turnoffflashlight();
      }
      update();
    }else if(isFlashActive==false && screenmode){
      isFlashActive=true;
      showscreenflash=true;
    update();
    }else if(!isFlashActive && !screenmode){
      isFlashActive=true;
      turnonflashlight();
//activate flash here
      update();
    }
  }
  void monitorbattery()async{
    streamSubscription=battery.onBatteryStateChanged.listen((event) async{
      batteryState=event;
      final level = await battery.batteryLevel;
      batterypercentage=level;
    });
    update();
  }

  Widget flashbutton(BuildContext context){
    double screenwidth=MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: 0),
      width: screenwidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (){
              if(!isFlashActive){
                logflashbuttontap();
              }
              toggleflashlight();
            },
            child: Container(
              width: screenwidth*0.32, height: screenwidth*0.32,
              decoration: BoxDecoration(
                color: themepurplecolor,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(
                    color:isFlashActive? Colors.white.withOpacity(0.56):Colors.transparent,
                blurRadius: 50,offset: Offset(0,0)
                ),
                ]
              ),
              child: Center(
                child: Container(
                  height: screenwidth*0.16,width: screenwidth*0.16,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.white,width: screenwidth*0.0097,),
                    shape: BoxShape.circle
                  ),
                  child: Center(
                    child: RotatedBox(
                      quarterTurns: isFlashActive?3:2,
                      child: Container(
                      width: screenwidth*0.0097,height: screenwidth*0.0609,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                    ),)
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: screenwidth*0.0827),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin:EdgeInsets.only(bottom:screenwidth*0.0226),
                  child:  Text(
                    isFlashActive?"Status: Turned On":
                    "Status: Turned Off",style: TextStyle(
                      fontFamily: intermedium,
                      color:  isFlashActive?themegreencolor:themeredcolor,
                      fontSize: screenwidth*0.0340
                  ),
                  textAlign: TextAlign.center,),
                ),
                Container(
                  child:  Text(
                    !hasFlashlight?"Flashlight not found on your device":
                    isFlashActive?
                    "Tap on the button above to\n"
                        "turn the flash off":
                    "Tap on the button above to\n"
                    "turn the flash on",style: TextStyle(
                      fontFamily: interregular,
                      color:
                      showscreenflash?
                      Colors.black.withOpacity(0.55):
                      Colors.white.withOpacity(0.55),
                      fontSize: screenwidth*0.0304
                  ),
                  textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget flashmodes(BuildContext context){
    double screenwidth=MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (){
              logtorchmode();
              screenmodefalse();
            },
            child: Container(
              margin: EdgeInsets.only(right: screenwidth*0.368),
              child: Icon(FeatherIcons.cloudLightning,
              color: screenmode?Color(0xffE7F4FF).withOpacity(0.63):
              themegreencolor,
              size: screenwidth*0.0973,
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              logscreenflashmode();
              screenmodetrue();
            },
            child: Container(
              child: Icon(FeatherIcons.smartphone,
                color: screenmode?
                themegreencolor:Color(0xffE7F4FF).withOpacity(0.63),
                size: screenwidth*0.0973,
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget emptyflashmodes(BuildContext context){
    double screenwidth=MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (){
            },
            child: Container(
              margin: EdgeInsets.only(right: screenwidth*0.368),
              child: Icon(FeatherIcons.cloudLightning,
                color: Colors.transparent,
                size: screenwidth*0.0973,
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              screenmodetrue();
            },
            child: Container(
              child: Icon(FeatherIcons.smartphone,
                color: Colors.transparent,
                size: screenwidth*0.0973,
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget emptyappbar(BuildContext context){
    double screenwidth=MediaQuery.of(context).size.width;
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Container(
        child: Icon(
          FeatherIcons.battery,
          size: screenwidth*0.0535,
          color: Colors.transparent,
        ),
      ),
      actions: [


      ],
      bottom: PreferredSize(
        preferredSize: Size(screenwidth, 2),
        child: Container(
          child: Text(
            "",
            style: TextStyle(
                fontFamily: interregular,
                color: Colors.transparent,
                fontSize:  screenwidth*0.0340),
          ),
        ),
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
  void logflashbuttontap()async{
    // Get reference to Firestore collection
    var collectionRef = FirebaseFirestore.instance.collection('Flashtaps');
    var doc = await collectionRef.doc(DateFormat.yMMMMd('en_US').format(DateTime.now())).get();
    if(doc.exists){
      await FirebaseFirestore.instance.collection("Flashtaps").doc(
          DateFormat.yMMMMd('en_US').format(DateTime.now())
      ).update({"numberoftaps":FieldValue.increment(1)});
    }else{
      await FirebaseFirestore.instance.collection("Flashtaps").doc(
          DateFormat.yMMMMd('en_US').format(DateTime.now())
      ).set({"numberoftaps":1});
    }  }


  void logtorchmode()async{
    // Get reference to Firestore collection
    var collectionRef = FirebaseFirestore.instance.collection('Torch Mode');
    var doc = await collectionRef.doc(DateFormat.yMMMMd('en_US').format(DateTime.now())).get();
    if(doc.exists){
      await FirebaseFirestore.instance.collection("Torch Mode").doc(
          DateFormat.yMMMMd('en_US').format(DateTime.now())
      ).update({"numberoftaps":FieldValue.increment(1)});
    }else{
      await FirebaseFirestore.instance.collection("Torch Mode").doc(
          DateFormat.yMMMMd('en_US').format(DateTime.now())
      ).set({"numberoftaps":1});
    }  }

  void logscreenflashmode()async{
    // Get reference to Firestore collection
    var collectionRef = FirebaseFirestore.instance.collection('Screen Mode');
    var doc = await collectionRef.doc(DateFormat.yMMMMd('en_US').format(DateTime.now())).get();
    if(doc.exists){
      await FirebaseFirestore.instance.collection("Screen Mode").doc(
          DateFormat.yMMMMd('en_US').format(DateTime.now())
      ).update({"numberoftaps":FieldValue.increment(1)});
    }else{
      await FirebaseFirestore.instance.collection("Screen Mode").doc(
          DateFormat.yMMMMd('en_US').format(DateTime.now())
      ).set({"numberoftaps":1});
    }  }

  void logsettingstap()async{
    // Get reference to Firestore collection
    var collectionRef = FirebaseFirestore.instance.collection('Settings Tap');
    var doc = await collectionRef.doc(DateFormat.yMMMMd('en_US').format(DateTime.now())).get();
    if(doc.exists){
      await FirebaseFirestore.instance.collection("Settings Tap").doc(
          DateFormat.yMMMMd('en_US').format(DateTime.now())
      ).update({"numberoftaps":FieldValue.increment(1)});
    }else{
      await FirebaseFirestore.instance.collection("Settings Tap").doc(
          DateFormat.yMMMMd('en_US').format(DateTime.now())
      ).set({"numberoftaps":1});
    }  }
}
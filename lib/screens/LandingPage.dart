import 'package:cloud_firestore/cloud_firestore.dart' as Firestore;
import 'package:feather_icons/feather_icons.dart';
import 'package:flashlight/constants/color_constants.dart';
import 'package:flashlight/constants/font_constants.dart';
import 'package:flashlight/constants/image_constants.dart';
import 'package:flashlight/getxcontrollers/flash_controller.dart';
import 'package:flashlight/getxcontrollers/settings_controller.dart';
import 'package:flashlight/screens/Settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class LandingPage extends StatelessWidget {
   LandingPage({Key? key}) : super(key: key);
  final FlashController flashController = Get.put(FlashController());
   final SettingsController settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return GetBuilder<FlashController>(
        init: FlashController(),
        initState: (v) {
          flashController.monitorbattery();
          flashController.checkifflashlightexists();
          settingsController.initializebools();
          if(settingsController.turnonatstartupstatus){
            flashController.toggleflashlight();
          }
          flashController.initializebanner();
          flashController.loadrewardedad();
          flashController.turnonatstartup();
        },
        dispose: (v){
          flashController.turnoffatstartup();
        },
        builder: (flashcontroller) {
          return Scaffold(
            backgroundColor: bgdarkcolor,
            body: Stack(
              children: [
                Scaffold(
                  backgroundColor: bgdarkcolor,
                  body: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      ],
                    ),
                  ),
                ),
                flashcontroller.showscreenflash && flashcontroller.isFlashActive?
                Scaffold(
                  backgroundColor: Colors.white,
                ): Scaffold(
                  backgroundColor: Colors.transparent,
                ),
                Scaffold(
                  appBar: flashcontroller.showscreenflash?
                  AppBar(
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
                  ):
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    centerTitle: true,
                    title: Container(
                        child: Icon(
                          FeatherIcons.battery,
                          size: screenwidth*0.0535,
                          color: Colors.white,
                        ),
                      ),
                    actions: [
                      PopupMenuButton(
                          color: Colors.white,
                          elevation: 40,
                          itemBuilder:(context) => [
                            PopupMenuItem(
                              onTap:(){
                                flashcontroller.onreviewboxtapped();
                              },
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(rateusimg,
                                    width: screenwidth*0.0426,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: screenwidth*0.0533),
                                      child: Text("Rate Us",style: TextStyle(
                                        fontFamily: interregular,
                                        color: Colors.black,
                                        fontSize:  screenwidth*0.0340
                                      ),),
                                    )
                                  ],
                                ),

                              value: 1,
                            ),
                            PopupMenuItem(
                              onTap: (){
                                flashcontroller.sendfeedback();
                              },
                              child: GestureDetector(
                                onTap: (){
                                  flashcontroller.sendfeedback();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(FeatherIcons.edit3,
                                    color: Color(0xff374957),
                                    size:screenwidth*0.0426,)
                                   ,
                                    Container(
                                      margin: EdgeInsets.only(left: screenwidth*0.0533),
                                      child: Text("Feedback",style: TextStyle(
                                          fontFamily: interregular,
                                          color: Colors.black,
                                          fontSize:  screenwidth*0.0340
                                      ),),
                                    )
                                  ],
                                ),
                              ),
                              value: 2,
                            ),
                            PopupMenuItem(
                              onTap: (){
                              //  flashcontroller.logsettingstap();
                                flashcontroller.sendAnalyticsEvent(eventName: "SettingsTap",
                                clickevent: "Tapped");
                                Navigator.push(context, MaterialPageRoute(builder: (context)
                                =>Settings()));
                              },

                              child: GestureDetector(
                                onTap: (){
//                                  flashcontroller.logsettingstap();
                                  flashcontroller.sendAnalyticsEvent(eventName: "SettingsTap",
                                      clickevent: "Tapped");                                Navigator.push(context, MaterialPageRoute(builder: (context)
                                  =>Settings()));
                              },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(settingsimg,
                                      width: screenwidth*0.0426,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: screenwidth*0.0533),
                                      child: Text("Settings",style: TextStyle(
                                          fontFamily: interregular,
                                          color: Colors.black,
                                          fontSize:  screenwidth*0.0340
                                      ),),
                                    )
                                  ],
                                ),
                              ),
                              value: 3,
                            ),
                          ]
                      ),


                    ],
                    bottom: PreferredSize(
                      preferredSize: Size(screenwidth, 2),
                      child: Container(
                        child: Text(
                          "Battery Level: "+ flashcontroller.batterypercentage.toString()+"%",
                          style: TextStyle(
                              fontFamily: interregular,
                              color: Colors.white,
                              fontSize:  screenwidth*0.0340),
                        ),
                      ),
                    ),
                  ),
                  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                  floatingActionButton:
                  flashcontroller.showscreenflash?
                      flashcontroller.emptyflashmodes(context):
                  flashcontroller.flashmodes(context),
                  bottomNavigationBar: flashcontroller.isbanneradloaded?
                  Container(
                    width: screenwidth,
                    height: screenwidth*0.2433,
                    child: Container(
                      height: flashcontroller.bannerAd.size.height.toDouble(),
                      width: flashcontroller.bannerAd.size.width.toDouble(),
                      child: AdWidget(ad: flashcontroller.bannerAd,),
                    ),
                  ):
                  Container(
                    width: screenwidth,
                    height: screenwidth*0.2433,
                    color: Colors.transparent,
                  ),
                  backgroundColor: Colors.transparent,
                  body: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        flashcontroller.flashbutton(context),

                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

}

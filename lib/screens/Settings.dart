import 'package:flashlight/constants/color_constants.dart';
import 'package:flashlight/constants/font_constants.dart';
import 'package:flashlight/getxcontrollers/settings_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenwidth=MediaQuery.of(context).size.width;
    return
      GetBuilder<SettingsController>(
          initState: (v){

          },
          init: SettingsController(),
          builder: (settingscontroller){
      return Scaffold(
      backgroundColor: bgdarkcolor,
      appBar: AppBar(
          elevation:0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(CupertinoIcons.arrow_left,
          color: Colors.white,
          size: screenwidth*0.0583,),
        ),
        title: Container(
          child: Text("Settings",style: TextStyle(
            fontFamily: intermedium,
            color: Colors.white,
            fontSize: screenwidth*0.0486
          ),),
        ),
      ),
      body: Container(
        width: screenwidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            settingscontroller.generaltypetitle(context),
            settingscontroller.generalrow(context, "Switch Sound"),
            settingscontroller.generalrow(context, "Turn on at startup"),
            settingscontroller.generalrow(context, "Turn off at startup"),
            settingscontroller.generalrow(context, "Show battery status"),
            settingscontroller.abouttypetitle(context),
            settingscontroller.aboutrow(context)
          ],
        ),
      ),
    );});
  }
}

import 'package:feather_icons/feather_icons.dart';
import 'package:flashlight/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/font_constants.dart';
import '../constants/image_constants.dart';

class SettingsController extends GetxController {
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
              left: screenwidth * 0.0613, bottom: screenwidth * 0.0613),
          child: Text(
            "A B O U T",
            style: TextStyle(
                fontFamily: intermedium, color: themeredcolor, fontSize:  screenwidth*0.0340),
          ),
        ),
      ],
    );
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
                    "Enabled",
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
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.circle,
                size: screenwidth*0.0535,
                color: Colors.white,
              ))
        ],
      ),
    );
  }

  Widget aboutrow(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(
        left: screenwidth * 0.0643,
        right: screenwidth * 0.07,
      ),
      width: screenwidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              print(screenwidth);
            },
            child: Container(
              width: screenwidth,
              margin: EdgeInsets.only(bottom: screenwidth * 0.068),
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
            onTap: () {},
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
          )
        ],
      ),
    );
  }
}

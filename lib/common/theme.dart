import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ThemesData {
  static double width = double.infinity;
  static double height = double.infinity;
  static double currentWidth = double.infinity;
  static double widthRatio = double.infinity;
  static double heightRatio = double.infinity;
  static double currentHeight = double.infinity;
  static double screenRatio = double.infinity;
  static double currentScreenRatio = double.infinity;

//FontsSize
  static cardsLeadingStyle() {
    return TextStyle(
        fontFamily: 'GilroySemi',
        color: Color(0xffD9E2FF),
        fontSize: 15 * widthRatio);
  }

  static searchItemsStyle() {
    return TextStyle(
        fontFamily: 'GilroySemi',
        color: Color(0xffD9E2FF),
        fontSize: 16 * heightRatio);
  }

  static cardsNumbersStyle() {
    return TextStyle(
        fontFamily: 'Gilroy',
        color: Color(0xffD9E2FF),
        fontSize: 15 * widthRatio);
  }
  // static cardsStyle

  static genericFontStyle() {
    return TextStyle(
        fontFamily: 'Gilroy',
        color: Color(0xffD9E2FF),
        fontSize: 14 * heightRatio);
  }

  static alertStyle() {
    return TextStyle(
        fontFamily: 'Gilroy',
        color: Color(0xffD9E2FF),
        fontSize: 12 * heightRatio);
  }

  static alertStateStyle() {
    return TextStyle(
        fontFamily: 'Gilroy',
        color: Color(0xff3A7BD5),
        fontSize: 12 * heightRatio);
  }

  static moaIntroStyle() {
    return TextStyle(
        fontFamily: 'Gilroy',
        color: Color(0xffD9E2FF).withOpacity(0.8),
        fontSize: 14 * heightRatio);
  }

  static dealersEmailStyle() {
    return TextStyle(
        fontFamily: 'GilroyRegular',
        color: Color(0xff6BB9F0),
        fontSize: 14 * heightRatio);
  }

  static emergencyDescriptionStyle() {
    return TextStyle(
        fontFamily: 'GilroyRegular',
        color: Color(0xffD9E2FF).withOpacity(0.8),
        fontSize: 12 * heightRatio);
  }

  static moaFooterTextStyle() {
    return TextStyle(
        fontFamily: 'Gilroy',
        color: Color(0xffD9E2FF).withAlpha(60),
        fontSize: 9 * heightRatio);
  }

  static moaInfoStyle() {
    return TextStyle(
        fontFamily: 'GilroySemi',
        color: Color(0xffD9E2FF),
        fontSize: 14 * heightRatio);
  }

  static signUpStyle() {
    return TextStyle(
        fontFamily: 'Gilroy',
        color: Color(0xff3A7BD5),
        fontSize: 14 * heightRatio);
  }

  static setButtonFontStyle() {
    return TextStyle(
        fontFamily: 'Gilroy',
        color: Color(0xffD9E2FF),
        fontSize: 16 * widthRatio);
  }

  static setHeadingSize() {
    return TextStyle(
        fontFamily: 'GilroySemi',
        color: Color(0xffD9E2FF),
        fontSize: 16 * widthRatio);
  }

  static getCardHeading() {
    return TextStyle(
        fontFamily: "GilroyRegular",
        fontSize: 14,
        color: Color(0xFF7A86AA),
        fontWeight: FontWeight.w500);
  }

  static userNameStyle() {
    return TextStyle(
        fontFamily: 'GilroySemi',
        color: Color(0xffD9E2FF),
        fontSize: 16 * widthRatio);
  }

  static userInfoStyle() {
    return TextStyle(
        fontFamily: 'GilroyLight',
        color: Color(0xffD9E2FF),
        fontSize: 14 * widthRatio);
  }

  static membersNameStyle() {
    return TextStyle(
        color: Color(0xffD9E2FF).withOpacity(0.9),
        fontSize: 14 * widthRatio,
        fontFamily: 'Gilroy');
  }

  static membersDesignationStyle() {
    return TextStyle(
        color: Color(0xffD9E2FF).withOpacity(0.6),
        fontSize: 14 * widthRatio,
        fontFamily: 'GilroyRegular');
  }

  static membersDetailsStyle() {
    return TextStyle(
        color: Color(0xff6BB9F0),
        fontSize: 14 * widthRatio,
        fontFamily: 'Gilroy');
  }

  static appBarSize() {
    return TextStyle(
        fontFamily: 'GilroyBold',
        color: Color(0xffD9E2FF),
        fontSize: 16 * widthRatio);
  }

  static selectedStateStyle() {
    return TextStyle(
        color: Color(0xffD9E2FF),
        fontFamily: 'GilroyRegular',
        fontSize: 16 * widthRatio);
  }

  static emergencyHelpSystemHeadingStyle() {
    return TextStyle(
        color: Color(0xffD9E2FF),
        fontFamily: 'GilroyBold',
        fontSize: 15 * widthRatio);
  }

  static selectedStateContainerStyle() {
    return TextStyle(
        color: Color(0xff6BB9F0),
        fontFamily: 'Gilroy',
        fontSize: 14 * widthRatio);
  }

  static codeStyle() {
    return TextStyle(
        color: Colors.white, fontFamily: 'Gilroy', fontSize: 18 * widthRatio);
  }

  static setScreenRatio(double height, double width) {
    currentHeight = height;
    currentWidth = width;
    widthRatio = width / 375;
    heightRatio = height / 667;

    print('%%%%%%%%%%%%%');
  }
//COLORS

  static const Color BACKGROUND_COLOR = Color(0xff19202C);
  static const Color CARD_COLOR = Color(0xff303644);
  static const Color CUSTOM_CONTAINER_COLOR = Color(0xff303644);
  // static const Color CARD_COLOR = Color(0xff303644);
}

import 'package:flutter/material.dart';
import 'package:noviindus_test/core/color_pallette/color_pallete.dart';

class AppTheme {
  static TextStyle lightBodyTextStyle(
          {FontWeight? fontWeight, Color? color, double? size}) =>
      TextStyle(
          fontFamily: 'Poppins',
          fontWeight: fontWeight ?? FontWeight.w500,
          color: color ?? ColorPallete.blackColor,
          fontSize: size ?? 18,
          decoration: TextDecoration.none);

  static _border({Color color = ColorPallete.borderColor}) =>
      OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: color, width: 2));

  static TextStyle lightTitleTextStyle(
          {FontWeight? fontWeight, Color? color, double? size}) =>
      TextStyle(
          fontFamily: 'Poppins',
          fontWeight: fontWeight ?? FontWeight.w600,
          color: color ?? ColorPallete.blackColor,
          fontSize: size ?? 16,
          decoration: TextDecoration.none);

  static final ElevatedButtonThemeData lightButtonThemeData =
      ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: ColorPallete.themeColor,
              fixedSize: const Size(500, 50),
              textStyle: lightTitleTextStyle(
                  fontWeight: FontWeight.w600,
                  size: 17,
                  color: ColorPallete.whiteColor),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))));

  static InputDecorationTheme lightInputDecoration = InputDecorationTheme(
      contentPadding: const EdgeInsets.all(15),
      enabledBorder: _border(),
      filled: true,
      fillColor: ColorPallete.lightGrey,
      errorBorder: _border(color: ColorPallete.errorColor),
      focusedErrorBorder: _border(color: ColorPallete.errorColor),
      focusedBorder: _border(
        color: ColorPallete.themeColor,
      ),
      errorStyle: lightBodyTextStyle(
          fontWeight: FontWeight.w300,
          size: 14,
          color: ColorPallete.errorColor),
      hintStyle: lightBodyTextStyle(
          fontWeight: FontWeight.w300,
          size: 14,
          color: ColorPallete.borderColor));

  static TextTheme lightTextTheme = TextTheme(
      titleLarge: lightTitleTextStyle(
          fontWeight: FontWeight.w600,
          size: 24,
          color: ColorPallete.blackColor),
      titleMedium: lightTitleTextStyle(
          fontWeight: FontWeight.w500,
          size: 18,
          color: ColorPallete.blackColor),
      titleSmall: lightTitleTextStyle(
        fontWeight: FontWeight.w500,
        size: 16,
        color: ColorPallete.blackColor,
      ),
      bodyLarge: lightBodyTextStyle(
          fontWeight: FontWeight.w300,
          size: 16,
          color: ColorPallete.blackColor),
      bodyMedium: lightBodyTextStyle(
          fontWeight: FontWeight.w400, size: 15, color: Colors.black),
      bodySmall: lightBodyTextStyle(
          fontWeight: FontWeight.w300,
          size: 12,
          color: ColorPallete.blackColor));

  static dynamic lightTheme = ThemeData().copyWith(
      textTheme: lightTextTheme,
      inputDecorationTheme: lightInputDecoration,
      elevatedButtonTheme: lightButtonThemeData);
}

import 'package:flutter/material.dart';
import 'package:mspr/core/values/dimens.dart';

const Color primaryColor = Color(0xffF07721);
const Color primaryLightColor = Color(0xffF07721);
const Color backgroundColor = Colors.white;
const Color inactiveLightGreyColor = Color(0xFFB3B3B3);
const Color greyColor = Color(0xFF666666);
const Color greyDarkColor = Color(0xFF333333);
const Color redColor = Color(0xFFDF382B);
const Color redBackgroundColor = Color(0xFFFEEDEE);
const Color orangeColor = Color(0xFFFC961E);
const Color orangeBackgroundColor = Color(0xFFFFF5EB);
const Color greyLightTextColor = Color(0xff6F676C);
const Color greyLightColor = Color(0xffBAB6BC);
final Color greyLowOpacityColor = greyColor.withOpacity(0.2);
const Color warningColor = Color(0xffF9C88E);
const Color warningRedColor = Color(0xffC61112);
const Color paleGreenColor = Color(0xFFEBF5DE);
const Color paleRedColor = Color(0xFFFDEAEA);
const Color greyListBackgroundColor = Color(0xFFEEEFF1);

class AppTheme {
  static ThemeData getDefault(BuildContext context) => ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: ThemeData().colorScheme.copyWith(primary: primaryColor, secondary: primaryLightColor),
        primaryColor: primaryColor,
        backgroundColor: Colors.white,
        appBarTheme: AppBarTheme.of(context).copyWith(
          backgroundColor: primaryColor,
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: primaryColor, width: buttonBorderWidth),
            backgroundColor: Colors.white,
          ),
        ),
      );
}

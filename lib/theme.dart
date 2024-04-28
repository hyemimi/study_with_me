import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// 폰트, 글씨 크기 및 색깔
TextTheme textTheme() {
  return TextTheme(
    displayLarge: GoogleFonts.openSans(fontSize: 18.0, color: Colors.black),
    displayMedium: GoogleFonts.openSans(
        fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold),
    bodyLarge: GoogleFonts.openSans(fontSize: 16.0, color: Colors.black),
    bodyMedium: GoogleFonts.openSans(fontSize: 14.0, color: Colors.black),
    titleMedium: GoogleFonts.openSans(fontSize: 15.0, color: Colors.black),
  );
}

// 아이콘
IconThemeData iconThem() {
  return const IconThemeData(
    color: Colors.black,
  );
}

// appBar (위쪽)
AppBarTheme appBarTheme() {
  return AppBarTheme(
      centerTitle: false,
      color: Colors.green,
      elevation: 0.0,
      iconTheme: iconThem(),
      titleTextStyle: GoogleFonts.nanumGothic(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ));
}

BottomNavigationBarThemeData bottomNavigatorTheme() {
  return const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.lime,
    unselectedItemColor: Colors.black54,
    showUnselectedLabels: true,
  );
}

ElevatedButtonThemeData elevatedButtonTheme() {
  return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))));
}

// 테마 적용
ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    textTheme: textTheme(),
    appBarTheme: appBarTheme(),
    bottomNavigationBarTheme: bottomNavigatorTheme(),
    elevatedButtonTheme: elevatedButtonTheme(),
    primarySwatch: Colors.lime,
  );
}

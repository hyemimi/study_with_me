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
      color: Color(0xff81C77F),
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
    selectedItemColor: Color(0xff81C77F),
    unselectedItemColor: Colors.black54,
    showUnselectedLabels: true,
  );
}

ElevatedButtonThemeData elevatedButtonTheme() {
  return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Color(0xFFECFFE4),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))));
}

ThemeData theme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(0xFFECFFE4),
      brightness: Brightness.light, //다크/라이트 모드 선택
    ),
    scaffoldBackgroundColor: Colors.white,
    //textTheme: textTheme(),
    //appBarTheme: appBarTheme(),
    //bottomNavigationBarTheme: bottomNavigatorTheme(),
    //elevatedButtonTheme: elevatedButtonTheme(),
    //primarySwatch: Colors.lime,
  );
}

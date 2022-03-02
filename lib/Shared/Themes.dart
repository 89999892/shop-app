import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData LightTheme = ThemeData(
    backgroundColor: Colors.white,

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
            elevation: 0,
        unselectedItemColor: Colors.grey,
        selectedItemColor:  Colors.blue,
        backgroundColor: Colors.grey,

       // showSelectedLabels: true,
       // showUnselectedLabels: true,
        selectedLabelStyle:TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold) ,
        unselectedLabelStyle: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)

        //selectedIconTheme: IconThemeData(color: Colors.blue,),
        //unselectedIconTheme: IconThemeData(color: Colors.grey),


    ),

    accentColor: Colors.lightBlueAccent,
    primaryColor: Colors.lightBlueAccent,
    canvasColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
    textTheme: TextTheme(
        button: GoogleFonts.lato(
            color: Colors.lightBlueAccent,
            fontWeight: FontWeight.bold,
            fontSize: 18),
        body1: GoogleFonts.lato(
            color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        title: GoogleFonts.lato(
          color: Colors.black,
          fontSize: 20,
        )),
    appBarTheme: AppBarTheme(
        color: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        actionsIconTheme: IconThemeData(color: Colors.black),
        textTheme: TextTheme(
            button:
                GoogleFonts.lato(color: Colors.lightBlueAccent, fontSize: 16),
            body1: GoogleFonts.lato(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
            title: TextStyle(
                color: Colors.lightBlueAccent,
                fontSize: 25,
                fontWeight: FontWeight.bold)),
        elevation: 0));
ThemeData DarkTheme = ThemeData(
  primaryColor: Colors.lightBlueAccent,
  iconTheme: IconThemeData(color: Colors.grey),
  backgroundColor: Colors.black,
  accentColor: Colors.lightBlueAccent,
  canvasColor: HexColor('4A4743'),
  appBarTheme: AppBarTheme(
      color: HexColor('4A4743'),
      textTheme: TextTheme(
          title: TextStyle(
              color: Colors.deepOrange,
              fontSize: 25,
              fontWeight: FontWeight.bold)),
      elevation: 0),
  textTheme: TextTheme(
      button: GoogleFonts.lato(color: Colors.lightBlueAccent, fontSize: 16),
      body1: GoogleFonts.lato(
          color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
      title: GoogleFonts.lato(
        color: Colors.white,
        fontSize: 20,
      )),
);

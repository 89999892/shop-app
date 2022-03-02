import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cache_Helper.dart';
import 'package:shop_app/Data&network/remote/shop_DioHelper.dart';
import 'package:shop_app/Shared/Themes.dart';
import 'package:shop_app/ShopAppBloc/shop_app_cubit.dart';
import 'package:shop_app/layout_Screens/layout/shop_layoutSreen.dart';
import 'package:shop_app/layout_Screens/onboarding.dart';
import 'package:shop_app/layout_Screens/shop_login/login_cubit.dart';
import 'package:shop_app/layout_Screens/shop_login/login_screen.dart';

import 'Data&network/remote/constants.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new DevHttpOverrides();
   DioHelper.init();
   await CacheHelper.init();
  // bool isDark=CacheHelper.getDate(key: 'isDark');
Widget widget;
   bool onBoarding=CacheHelper.getDate(key: 'onBoarding');

   token=CacheHelper.getDate(key: 'token');
 if(onBoarding!=null){
   print('on boooooording=$onBoarding');
   if(token!=null){
     print('tooooken=$token');
     widget=ShopLayout();
   }else{
     widget=LoginScreen();
   }
 }else{
   widget=Onboarding();
 }

  runApp(MyApp(StartScreen: widget,));
}

class MyApp extends StatelessWidget {
 final Widget StartScreen;

   MyApp({ this.StartScreen}) ;



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context)=>ShopAppCubit()..getHomeData()..getCategoriesData()..getFavouratesData()..getProfileData()),
      BlocProvider(create: (context)=>LoginCubit()),

    ], child: MaterialApp(
      title: 'Flutter Demo',
      theme: LightTheme,
      debugShowCheckedModeBanner: false,
      home: StartScreen,
    ));
  }
}



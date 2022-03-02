import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cache_Helper.dart';
import 'package:shop_app/Shared/components&widgets/functions.dart';
import 'package:shop_app/ShopAppBloc/shop_app_cubit.dart';
import 'package:shop_app/layout_Screens/shop_login/login_screen.dart';
import 'package:shop_app/layout_Screens/shop_search/Search_Screen.dart';
class ShopLayout extends StatelessWidget {
  bool showsnake;
  ShopLayout({this.showsnake}) ;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppState>(builder: (context,state){
      var Cubit=BlocProvider.of<ShopAppCubit>(context);
      return Scaffold(
        appBar: AppBar(
          title: Text('Shop',style: TextStyle(color: Colors.black),),
          actions: [
            IconButton(icon: Icon(Icons.search), onPressed:(){navigateTo(context, SearchScreen());})
          ],
        ),
        body: Cubit.bottomScreens[Cubit.currentindex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index)=>Cubit.ChangeBottIndex(index),
          currentIndex: Cubit.currentindex,

          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: 'home',),
            BottomNavigationBarItem(icon: Icon(Icons.grid_view),label: 'categories'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'favorites'),
            BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'settings'),
          ],
        ),
      );;
    }, listener: (context,state){});
  }
}

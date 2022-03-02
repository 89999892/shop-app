import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/Data&network/remote/constants.dart';
import 'package:shop_app/Data&network/remote/endPoints.dart';
import 'package:shop_app/Data&network/remote/shop_DioHelper.dart';
import 'package:shop_app/layout_Screens/category_screen.dart';
import 'package:shop_app/layout_Screens/favourates_screen.dart';
import 'package:shop_app/layout_Screens/product_screen.dart';
import 'package:shop_app/layout_Screens/settings_screen.dart';
import 'package:shop_app/models/Category_model.dart';
import 'package:shop_app/models/HomeModel.dart';
import 'package:shop_app/models/Login_Model.dart';
import 'package:shop_app/models/change_favourates_model.dart';
import 'package:shop_app/models/favourate_model.dart';

part 'shop_app_state.dart';

class ShopAppCubit extends Cubit<ShopAppState> {
  ShopAppCubit() : super(ShopAppInitial());
  int currentindex=0;
  List<Widget> bottomScreens=[ProductScreen(),CategoryScreen(),FavouratesScreen(),SettingsScreen()];
void ChangeBottIndex(index){
  currentindex=index;
  emit(ShopBottomNavState());
}
  HomeModel homeModel;
  Map<int ,bool> favourates={};
void getHomeData(){
  emit(ShopHomeLoadingState());
  DioHelper.getData(path: HOME,authorization: token).then((value){
    //print('hoooooome moooodel hereee'+value.data.toString());
    print('hoooomeDataaaa was called And its fisrt banner =${value.data}');

    homeModel=HomeModel.fromJson(value.data);
    homeModel.data.products.forEach((element){
      favourates.addAll({element.id:element.inFavorite});
    });
 //   print('hoooooome moooodel hereee'+value.data.toString());
    emit(ShopHomeSuccessState(homeModel));
  }).catchError((error){
    print('$error');
    emit(ShopHomeErrorState());
  });
}
  CategoryModel categoriesModel;
  void getCategoriesData(){
    DioHelper.getData(path: GET_CATEGORIES).then((value){
      categoriesModel=CategoryModel.fromJson(value.data);
      //   print('hoooooome moooodel hereee'+value.data.toString());
      emit(ShopCategoriesSuccessState(categoriesModel));
    }).catchError((error){
      print('$error');
      emit(ShopCategoriesErrorState());
    });
  }
  FavouratesModel favouratesModel;
  void getFavouratesData(){
    emit(GetFavouratesLoadingState());
    DioHelper.getData(path: FAVOURATES,authorization: token).then((value){
      favouratesModel=FavouratesModel.fromJson(value.data);
      //   print('hoooooome moooodel hereee'+value.data.toString());
      emit(GetFavouratesSuccessState());
    }).catchError((error){
      print('$error');
      emit(GetFavouratesErrorState());
    });
  }
  loginModel profilemodel;

  void getProfileData(){
    emit(GetProfileLoadingState());
    DioHelper.getData(path: PROFILE,authorization: token).then((value){
      profilemodel=loginModel.fromJson(value.data);
      //   print('hoooooome moooodel hereee'+value.data.toString());
      emit(GetProfileSuccessState(profilemodel));
    }).catchError((error){
      print('$error');
      emit(GetProfileErrorState());
    });
  }
  void UpdateProfileData({
    @required String name,
    @required String phone,
    @required String email,}){
    emit(UpdateProfileLoadingState());
    DioHelper.putData(path: UPDATE_PROFILE, data: {
      'name': name,
      'phone': phone,
      'email': email,
    },authorization: token).then((value){
      profilemodel =loginModel.fromJson(value.data);
     print('updaaaaate =${profilemodel.data}');
      emit(UpdateProfileSuccessState(profilemodel));
    }).catchError((error){
      print('$error');
      emit(UpdateProfileErrorState());
    });
  }
ChangeFavourateModel changeFavourateModel;
  void Changefavourates(int ModelId ){
    favourates[ModelId]=!favourates[ModelId];
    emit(ChangeFavouratesState());
DioHelper.postData(path:FAVOURATES, data: {
  'product_id':ModelId
},authorization: token).then((value){
  changeFavourateModel=ChangeFavourateModel.fromjson(value.data);
  print(changeFavourateModel.message);
  if(!changeFavourateModel.status){
    favourates[ModelId]=!favourates[ModelId];
  }else{
    getFavouratesData();
  }
  emit(ChangeFavouratesSuccessState(changeFavourateModel));
}).catchError((error){
  print('errrr$error');
  emit(ChangeFavouratesErrorState());
});
  }
}

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/Data&network/remote/endPoints.dart';
import 'package:shop_app/Data&network/remote/shop_DioHelper.dart';
import 'package:shop_app/models/Login_Model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitial());
  bool passSecure=true;
  void changepassvisibility(){
    passSecure=!passSecure;
    print(passSecure.toString());
    emit(ChangeVisibilityState(passSecure));
  }
  loginModel userData;
void userLogin({@required String email,@required String password}){
  emit(LoginLoadingState());
  print('EMAIL=$email');
  print('PASSWORD=$password');
  //print(DioHelper.dio.options.baseUrl);
  DioHelper.postData(path: 'login', data: {
 'email':email,
 'password':password}
 ).then((value){
   userData=loginModel.fromJson(value.data);
   print('PostData was called $value');
   emit(LoginSuccessState());
 }).catchError((error){
   print('this is the API error=>$error');
   emit(LoginErrorState());
 });
 
}
}

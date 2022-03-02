import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Cache_Helper.dart';
import 'package:shop_app/Data&network/remote/constants.dart';
import 'package:shop_app/layout_Screens/shop_login/login_screen.dart';
import 'package:shop_app/models/Login_Model.dart';
void navigateTo(context,widget){
  Navigator.push(context, MaterialPageRoute(builder: (_)=>widget));
}
void navigateAndRemove(context,widget){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>widget));
}
void ShowToast({@required String message,@required stateColor state}){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: ChangeColorState(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}
void ShowSnakeBar(BuildContext context,loginModel user, stateColor state) {
  var snacke=SnackBar(content:Text('${user.message}'),backgroundColor:ChangeColorState(state) , );
  Scaffold.of(context).showSnackBar(snacke);
}
enum stateColor{Success,Error,Warning}
void SignOut(BuildContext context){
  CacheHelper.removeDate(key:'token' ).then((value){
    if(value){
      navigateAndRemove(context, LoginScreen());
    }
  });

}
Color ChangeColorState(stateColor color){
  switch(color){
    case stateColor.Success:
      return Colors.green;
      break;
    case stateColor.Error:
      return Colors.red;
      break;
    case stateColor.Warning:
      return Colors.yellow;
      break;

  }
}
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/Data&network/remote/endPoints.dart';
import 'package:shop_app/Data&network/remote/shop_DioHelper.dart';
import 'package:shop_app/models/Login_Model.dart';


part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  bool passRegisSecure=true;
  void changepassvisibility(){
    passRegisSecure=!passRegisSecure;
    print(passRegisSecure.toString());
    emit(ChangeRegisVisibilityState(passRegisSecure));
  }
  loginModel userData;
  void userRegister({@required String email,@required String password,@required String name,@required String phone}){
    emit(RegisterLoadingState());
    DioHelper.postData(path: REGISTER, data: {
      'name': name,
      'phone':phone,
      'email':email,
      'password':password,
    }
    ).then((value){
      userData=loginModel.fromJson(value.data);
      emit(RegisterSuccessState(userData));
    }).catchError((error){
      print('this is the API error=>$error');
      emit(RegisterErrorState());
    });

  }

}

part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}
class ChangeRegisVisibilityState extends RegisterState {
  bool passRegisSecure;
  ChangeRegisVisibilityState(this.passRegisSecure);
}
class RegisterSuccessState extends RegisterState{
  loginModel userDataModel;

  RegisterSuccessState(this.userDataModel);
}
class RegisterErrorState extends RegisterState{

}
class RegisterLoadingState extends RegisterState{

}
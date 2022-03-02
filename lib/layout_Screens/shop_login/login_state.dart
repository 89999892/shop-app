part of 'login_cubit.dart';

@immutable
abstract class LoginStates {}

class LoginInitial extends LoginStates {}
class ChangeVisibilityState extends LoginStates {
  bool passSecure;
  ChangeVisibilityState(this.passSecure);
}
class LoginSuccessState extends LoginStates{

}
class LoginErrorState extends LoginStates{

}
class LoginLoadingState extends LoginStates{

}
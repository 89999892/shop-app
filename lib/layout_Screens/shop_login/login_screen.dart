import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cache_Helper.dart';
import 'package:shop_app/Data&network/remote/constants.dart';
import 'package:shop_app/Data&network/remote/shop_DioHelper.dart';
import 'package:shop_app/Shared/components&widgets/functions.dart';
import 'package:shop_app/ShopAppBloc/shop_app_cubit.dart';
import 'package:shop_app/layout_Screens/layout/shop_layoutSreen.dart';
import 'package:shop_app/layout_Screens/shop_login/login_cubit.dart';
import 'package:shop_app/layout_Screens/shop_register/register_Screen.dart';
import 'package:shop_app/models/Login_Model.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  //var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => LoginCubit(),
        child: Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.headline3.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'login to see our hot offers!',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.black45),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Text(
                    'Email:',
                    style: TextStyle(fontSize: 18),
                  ),
                  _emailField(),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Password:',
                    style: TextStyle(fontSize: 18),
                  ),
                  _passwordField(context),
                  SizedBox(
                    height: 25,
                  ),
                  BlocConsumer<LoginCubit, LoginStates>(
                      builder: (context, state) {
                    var Cubit = BlocProvider.of<LoginCubit>(context);
                    return Column(
                      children: [
                        Center(
                            child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          child: state is LoginLoadingState
                              ? Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                                  onPressed: () {
                                    Cubit.userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  },
                                  child: Text('login')),
                        )),
                        Center(
                          child: Row(
                            children: [
                              Text('Don\'t have an account?',
                                  style: Theme.of(context).textTheme.headline6),
                              TextButton(
                                  onPressed: () {
                                    navigateTo(context, RegisterScreen());
                                  },
                                  child: Text(
                                    'Register',
                                    style: Theme.of(context).textTheme.button,
                                  ))
                            ],
                          ),
                        )
                      ],
                    );
                  }, listener: (context, state) {
                    var Cubit = BlocProvider.of<LoginCubit>(context);
                    if (state is LoginSuccessState) {
                      if (Cubit.userData.status) {
                        ShowToast(message:Cubit.userData.message , state:stateColor.Success );

                        token=Cubit.userData.data.token;
                        CacheHelper.SaveDate(
                                key: 'token', value: Cubit.userData.data.token)
                            .then((value) {
                          BlocProvider.of<ShopAppCubit>(context).getHomeData();
                          navigateAndRemove(context, ShopLayout(showsnake: true,));
                        });

                      } else {
                        ShowToast(message:Cubit.userData.message , state:stateColor.Error);
                        //ShowSnakeBar(context, Cubit.userData, stateColor.Error);
                      }
                    }
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  customInputFieldDecoration(
      {@required String hint, IconButton suffixButton, Icon prefix}) {
    return InputDecoration(
        hintText: hint,
        suffixIcon: suffixButton,
        prefix: prefix,
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(10)));
  }

  Widget _emailField() {
    return TextFormField(
      controller: emailController,
      validator: (value) {
        if (value.isEmpty) {
          return 'please enter your email';
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.text,
      decoration: customInputFieldDecoration(
          hint: 'Enter your email here...', prefix: Icon(Icons.email)),
    );
  }

  Widget _passwordField(context) {
    return BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var Cubit = BlocProvider.of<LoginCubit>(context);
          return TextFormField(
            controller: passwordController,
            keyboardType: TextInputType.visiblePassword,
            validator: (value) {
              if (value.isEmpty) {
                return 'please enter your email';
              } else {
                return null;
              }
            },
            obscureText: Cubit.passSecure,
            decoration: customInputFieldDecoration(
                hint: 'Enter your password...',
                prefix: Icon(Icons.lock),
                suffixButton: IconButton(
                    icon: Icon(Cubit.passSecure
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () => Cubit.changepassvisibility())),
          );
        });
  }
}

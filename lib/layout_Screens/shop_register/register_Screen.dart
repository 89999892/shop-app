import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Data&network/remote/constants.dart';
import 'package:shop_app/Shared/components&widgets/functions.dart';
import 'package:shop_app/ShopAppBloc/shop_app_cubit.dart';
import 'package:shop_app/layout_Screens/layout/shop_layoutSreen.dart';
import 'package:shop_app/layout_Screens/shop_register/registerBloc/register_cubit.dart';

import '../../Cache_Helper.dart';
class RegisterScreen extends StatelessWidget {
 RegisterScreen();
 var formKey=GlobalKey<FormState>();
 var emailController = TextEditingController();
 var passwordController = TextEditingController();
 var nameController = TextEditingController();
 var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterState>(builder: (context,state){
        var Cubit=BlocProvider.of<RegisterCubit>(context);
        return Scaffold(
            body:SingleChildScrollView(
              child:Form(
                key:formKey ,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Register',
                        style: Theme.of(context).textTheme.headline3.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Register to see our hot offers!',
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: Colors.black45),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'User Name:',
                        style: TextStyle(fontSize: 18),
                      ),
                      _nameField(),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Phone Number:',
                        style: TextStyle(fontSize: 18),
                      ),
                      _phoneField(),
                      SizedBox(
                        height: 20,
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
                        height: 20,
                      ),
                      Column(
                        children: [
                          Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                child: state is RegisterLoadingState
                                    ? Center(child: CircularProgressIndicator())
                                    : ElevatedButton(
                                    onPressed: () {
                                      if(formKey.currentState.validate()){
                                        Cubit.userRegister(email: emailController.text, password: passwordController.text, name: nameController.text, phone: phoneController.text);
                                      }

                                    },
                                    child: Text('Register')),
                              )),
                          Center(
                            child: Row(
                              children: [
                                Text('Already have an account?',
                                    style: Theme.of(context).textTheme.headline6),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'Login',
                                      style: Theme.of(context).textTheme.button,
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),


                    ],
                  ),
                ),),
            )
        );
      }, listener:  (context, state) {
        var Cubit = BlocProvider.of<RegisterCubit>(context);
        if (state is RegisterSuccessState) {
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
      }),
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
 Widget _nameField() {
   return TextFormField(
     controller: nameController,
     validator: (value) {
       if (value.isEmpty) {
         return 'please enter your name';
       } else {
         return null;
       }
     },
     keyboardType: TextInputType.name,
     decoration: customInputFieldDecoration(
         hint: 'Enter your name here...', prefix: Icon(Icons.person)),
   );
 }
 Widget _phoneField() {
   return TextFormField(
     controller: phoneController,

     validator: (value) {
       if (value.isEmpty) {
         return 'please enter your phone number';
       } else {
         return null;
       }
     },
     keyboardType: TextInputType.phone,
     decoration: customInputFieldDecoration(
         hint: 'Enter your Phone Number here...', prefix: Icon(Icons.phone)),
   );
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
   return BlocConsumer<RegisterCubit, RegisterState>(
       listener: (context, state) {},
       builder: (context, state) {
         var Cubit = BlocProvider.of<RegisterCubit>(context);
         return TextFormField(
           controller: passwordController,

           keyboardType: TextInputType.visiblePassword,
           validator: (value) {
             if (value.isEmpty) {
               return 'please enter your password';
             } else {
               return null;
             }
           },
           obscureText: Cubit.passRegisSecure,
           decoration: customInputFieldDecoration(
               hint: 'Enter your password...',
               prefix: Icon(Icons.lock),
               suffixButton: IconButton(
                   icon: Icon(Cubit.passRegisSecure
                       ? Icons.visibility
                       : Icons.visibility_off),
                   onPressed: () {
                     Cubit.changepassvisibility();
                   })),
         );
       });
 }
}


import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Shared/components&widgets/functions.dart';
import 'package:shop_app/ShopAppBloc/shop_app_cubit.dart';
import 'package:shop_app/layout_Screens/shop_login/login_cubit.dart';
class SettingsScreen extends StatelessWidget {
  SettingsScreen() ;
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppState>(builder:(context,state){
      var Cubit=BlocProvider.of<ShopAppCubit>(context);
      emailController.text=Cubit.profilemodel.data.email;
      nameController.text=Cubit.profilemodel.data.name;
      phoneController.text=Cubit.profilemodel.data.phone;

      return Scaffold(
        body: Center(
            child: ConditionalBuilder(
              condition: (state is! GetProfileLoadingState),
              builder: (context)=>Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if(state is UpdateProfileLoadingState)
                      LinearProgressIndicator(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: _nameField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: _emailField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: _phoneField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        height: 40,
                        child: ElevatedButton(
                            onPressed: () {
                              Cubit.UpdateProfileData(name: nameController.text, phone: phoneController.text, email: emailController.text);

                            },
                            child: Text('Update',style: TextStyle(fontSize: 20),)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        height: 40,
                        child: ElevatedButton(



                            onPressed: () {
                              Cubit.currentindex=0;
                              SignOut(context);
                            },
                            child: Text('Log Out',style: TextStyle(fontSize: 20),)),
                      ),
                    ),
                  ],),
              ),
              fallback: (context)=>CircularProgressIndicator(),
            )
        ),
      );
    }, listener:(context,state){
      if(state is UpdateProfileSuccessState)
        ShowToast(message: 'you have updated your profile', state:stateColor.Warning);

    } );
  }
  customInputFieldDecoration(
      {String hint,String lable, IconButton suffixButton, Icon prefix}) {
    return InputDecoration(
        hintText: hint,
        labelText: lable,
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
          lable: 'Email', prefix: Icon(Icons.email)),
    );
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
      keyboardType: TextInputType.text,
      decoration: customInputFieldDecoration(
         lable: 'User Name', prefix: Icon(Icons.person)),
    );
  }
  Widget _phoneField() {
    return TextFormField(
      controller: phoneController,
      validator: (value) {
        if (value.isEmpty) {
          return 'please enter yourphone';
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.text,
      decoration: customInputFieldDecoration(
          lable: 'Phone', prefix: Icon(Icons.phone)),
    );
  }

}

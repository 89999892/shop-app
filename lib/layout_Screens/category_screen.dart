import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/ShopAppBloc/shop_app_cubit.dart';
import 'package:shop_app/models/Category_model.dart';
class CategoryScreen extends StatelessWidget {
  CategoryScreen() ;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppState>(builder: (context,state){
      var cubit=BlocProvider.of<ShopAppCubit>(context);
      return Scaffold(
        backgroundColor: Colors.white,
        body: ListView.separated(itemBuilder: (context,index)=>_builCategoryitem(cubit.categoriesModel.data.data[index]), separatorBuilder:(context,index)=>Divider(color: Colors.grey,), itemCount:cubit.categoriesModel.data.data.length),
      );
    }, listener: (context,state){});

  }

 Widget _builCategoryitem(DataModel data) {
    return Container(
     // color: Colors.grey,
      height: 150,
      child: Center(
        child:Row(children: [
          Container(
            width: 100,height: 100,
            margin: EdgeInsets.symmetric(horizontal: 10),
            color: Colors.white,child: Image(image: NetworkImage(data.image),fit: BoxFit.fill,),),
        Text('${data.name}'),
          Spacer(),
          Icon(Icons.arrow_forward_ios),
          SizedBox(width: 20,)
        ],) /*ListTile(

          leading: Container(
          width: 100,height: 200,
              color: Colors.white,child: Image(image: NetworkImage(data.image),fit: BoxFit.fill,),),
          title: Text('${data.name}'),
          trailing: Icon(Icons.arrow_forward_ios),
        )*/,
      ),
    );
 }


}

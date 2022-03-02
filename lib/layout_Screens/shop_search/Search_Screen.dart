import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/ShopAppBloc/shop_app_cubit.dart';
import 'package:shop_app/layout_Screens/shop_search/search_cubit.dart';
import 'package:shop_app/models/search_model.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen();
var searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
    child: BlocConsumer<SearchCubit,SearchState>(
      builder: (context,state){
        var cubit=BlocProvider.of<SearchCubit>(context);
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                TextFormField(
                  controller: searchController,
                  decoration: InputDecoration(

                      suffixIcon: Icon(Icons.search),

                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                          borderRadius: BorderRadius.circular(10))),
                 onChanged: (String value){
                    cubit.UserSearch(searchController.text);
                 },
                  validator:(value) {
                    if (value.isEmpty) {
                      return 'please enter something to search about';
                    } else {
                      return null;
                    }}
                ),
                SizedBox(height: 20,),
                if(cubit.searchModel!=null)
                 ConditionalBuilder(
                  condition: state is! SearchLoadingState ,
                  builder: (context)=> Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) => _buildSearchItem(context,cubit.searchModel.data.data[index]),
                        separatorBuilder: (context, index) =>
                            Divider(color: Colors.white),
                        itemCount:cubit.searchModel.data.data.length ),
                  ),
                  fallback:(context)=> Center(child: CircularProgressIndicator(),),
                ),

              ],
            ),
          ),
        );
      },
      listener: (context,state){

      },
    ),
    );
  }
  Widget _buildSearchItem(BuildContext context,ProductData productData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Card(
        elevation: 5,
        child: Container(
          color: Colors.white,
          height: 160,
          //width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Image(
                    image: NetworkImage(
                      productData.image,
                    ),
                    width: 170,
                    height: 170,
                    // fit: BoxFit.fill
                  ),

                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8.0, top: 15, bottom: 4),
                        child: Text(
                          productData.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              height: 1.1,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                '\$9000',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                    color: Colors.blue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Center(
                                      child: IconButton(
                                          icon:
                                          BlocProvider.of<ShopAppCubit>(context).favourates[productData.id]
                                              ? Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          )
                                              : Icon(
                                            Icons
                                                .favorite_border_outlined,
                                          ),
                                          onPressed: () {
                                            BlocProvider.of<ShopAppCubit>(context).Changefavourates(productData.id);
                                          }))),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

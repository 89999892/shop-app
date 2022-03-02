import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Shared/components&widgets/functions.dart';
import 'package:shop_app/ShopAppBloc/shop_app_cubit.dart';
import 'package:shop_app/layout_Screens/product_details_screen.dart';
import 'package:shop_app/models/Category_model.dart';
import 'package:shop_app/models/HomeModel.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppState>(builder: (context, state) {
      var Cubit = BlocProvider.of<ShopAppCubit>(context);
      return Scaffold(
        body: ConditionalBuilder(
          condition: Cubit.homeModel != null && Cubit.categoriesModel != null,
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) => Center(
              child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                    items: Cubit.homeModel.data.banners
                        .map((e) => Container(
                      color: Colors.grey[200],
                          child: Image(

                            image: NetworkImage(e.image),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 250,
                          ),
                        ))
                        .toList(),
                    options: CarouselOptions(
                      viewportFraction: 1,
                      initialPage: 0,
                      autoPlay: true,
                      reverse: false,
                      autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                      autoPlayInterval: Duration(seconds: 4),
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 10, bottom: 20),
                  child: Text(
                    'Categories',
                    style: TextStyle(fontSize: 33),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 15),
                    padding: EdgeInsets.only(bottom: 25),
                    width: double.infinity,
                    color: Colors.grey[200],
                    height: 150,
                    alignment: Alignment.center,
                    child:
                        _buildcategoriesList(Cubit.categoriesModel.data.data)),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 10,bottom: 20),
                  child: Text(
                    'Products',
                    style: TextStyle(fontSize: 33),
                  ),
                ),
                Container(
                  color: Colors.grey[200],
                  padding: EdgeInsets.only(top: 2),
                  child: GridView.count(
                    crossAxisCount: 2,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    childAspectRatio: 1 / 1.5,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    children: List.generate(
                        Cubit.homeModel.data.products.length,
                        (index) => _buildProductItem(
                            context, Cubit.homeModel.data.products[index])),
                  ),
                )
              ],
            ),
          )),
        ),
      );
    }, listener: (context, state) {
      if (state is ChangeFavouratesSuccessState) {
        if (!state.changeFavourateModel.status) {
          Fluttertoast.showToast(
            msg: '${state.changeFavourateModel.message}',
            backgroundColor: Colors.red,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
      }
    });
  }

  Widget _buildProductItem(BuildContext context, ProductModel product) {
    return Container(
      color: Colors.white,
      // margin: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: ()=>navigateTo(context, ProductDetails(product: product)),
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Hero(tag: product.id, child: Image(
                  image: NetworkImage(
                    product.image,
                  ),
                  width: 200,
                  height: 220,
                  // fit: BoxFit.fill
                ),),
                if (product.discount != 0)
                  Container(
                    margin: EdgeInsets.only(left: 8.0),
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      'DISCOUNT',
                      style: Theme.of(context).textTheme.headline6.copyWith(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold),
                    ),
                  )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0, top: 4, bottom: 4),
            child: Text(
              product.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                  height: 1.1, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    '\$' + product.price.toString(),
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                if (product.discount != 0)
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      '\$' + product.oldPrice.toString(),
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough),
                    ),
                  ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: SizedBox(
                      height: 30,
                      width: 30,
                      child: Center(
                          child: IconButton(
                              icon: BlocProvider.of<ShopAppCubit>(context)
                                      .favourates[product.id]
                                  ? Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  : Icon(
                                      Icons.favorite_border_outlined,
                                    ),
                              onPressed: () {
                                BlocProvider.of<ShopAppCubit>(context)
                                    .Changefavourates(product.id);
                              }))),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildcategoriesList(List<DataModel> Categories) {
    return ListView.separated(
      itemBuilder: (context, index) => _buildCategoryitem(Categories, index),
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      separatorBuilder: (context, index) => SizedBox(
        width: 10,
      ),
      itemCount: Categories.length,
    );
  }

  Widget _buildCategoryitem(List<DataModel> Categories, int index) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: Colors.white,
            child: Image(
                //   color: Colors.white,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
                image: NetworkImage(
                  Categories[index].image,
                )),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          child: Container(
            height: 23,
            color: Colors.black.withOpacity(.6),
            width: 100,
            child: Text(
              '${Categories[index].name}',
              style: TextStyle(fontSize: 16, color: Colors.grey[200]),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}

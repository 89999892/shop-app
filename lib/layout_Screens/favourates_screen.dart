import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/ShopAppBloc/shop_app_cubit.dart';
import 'package:shop_app/models/favourate_model.dart';

class FavouratesScreen extends StatelessWidget {
  FavouratesScreen();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppState>(
        builder: (context, state) {
          var cubit = BlocProvider.of<ShopAppCubit>(context);
          return Scaffold(
            body:ConditionalBuilder(
              condition: state is!GetFavouratesLoadingState,
              builder: (context)=> ListView.separated(
                  itemBuilder: (context, index) => _buildFavItem(context,cubit.favouratesModel.data.data[index].product),
                  separatorBuilder: (context, index) =>
                      Divider(color: Colors.white),
                  itemCount:cubit.favouratesModel.data.data.length ),
              fallback:(context)=> Center(child: CircularProgressIndicator(),),
            )
          );
        },
        listener: (context, state) {});
  }

  Widget _buildFavItem(BuildContext context,FavourateProduct productdata) {
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
                      productdata.image.toString(),
                    ),
                    width: 170,
                    height: 170,
                    // fit: BoxFit.fill
                  ),
                  if (productdata.discount!= 0)
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8.0, top: 15, bottom: 4),
                        child: Text(
                          productdata.name,
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
                            if (productdata.discount!= 0)
                              Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text(
                                  '\$8700',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
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
                                          icon:
                                              BlocProvider.of<ShopAppCubit>(context).favourates[productdata.id]
                                                  ? Icon(
                                                      Icons.favorite,
                                                      color: Colors.red,
                                                    )
                                                  : Icon(
                                                      Icons
                                                          .favorite_border_outlined,
                                                    ),
                                          onPressed: () {
                                             BlocProvider.of<ShopAppCubit>(context).Changefavourates(productdata.id);
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

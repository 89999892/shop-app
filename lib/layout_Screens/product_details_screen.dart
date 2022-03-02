import 'package:flutter/material.dart';
import 'package:shop_app/models/HomeModel.dart';
class ProductDetails extends StatelessWidget {
  ProductModel product;

  ProductDetails({@required this.product }) ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Text('Product Details',
                  style: TextStyle(fontSize: 30, color:  Colors.black,fontWeight: FontWeight.w400),),
              ),

            ),
            Container(
              width: double.infinity,
              height: 400,
              child:Hero(
                tag:product.id,
                child:Image(image: NetworkImage(product.image),),
              ),

            ),
            SizedBox(height: 20,),
            SizedBox(height: 30),
            Center(child: Text('Name :',style: TextStyle(fontSize: 25,color: Colors.black),),),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Center(child: Text(product.name,style: TextStyle(fontSize: 20),),),
            ),
            Divider(
              color: Colors.grey,
              thickness: 2,
              indent: 40,
              endIndent: 40,

            ),
            Center(child: Text('Price :',style: TextStyle(fontSize: 25,color: Colors.black),),),
            Center(child: Text(product.price.toString()+'\$',style: TextStyle(fontSize: 20),),),
            Divider(
              color: Colors.grey,
              thickness: 2,
              indent: 40,
              endIndent: 40,

            ),
            Center(child: Text('Discription :',style: TextStyle(fontSize: 25,color: Colors.black),),),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Center(child: Text(product.description,style: TextStyle(fontSize: 17, height: 2),),),
            ),




           // _buildCardDetails(product),
          ],
        ),
      ),
    );
  }

  Widget _buildCardDetails(ProductModel Product) {
    return Padding(padding: EdgeInsets.all(8),
      child:SizedBox(
        width: double.infinity,
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [


          ],
        ),
      ),);
  }
}
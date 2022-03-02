import 'package:dio/dio.dart';
import 'dart:io';

//import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_app/Data&network/remote/constants.dart';
//import 'package:http/http.dart'as http;
//import 'package:http/http.dart';

class DevHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

/*class ApiServices{
  static ApiServices _apiServices;

  ApiServices._instance();

  factory ApiServices() {
    if (_apiServices == null) {
      _apiServices = ApiServices._instance();
    }
    return _apiServices;
  }
  static Future  postData(
      {
        @required String path ,
        Map <String,dynamic> data,
        String authorization ,
      }
      )async{
    String url='${'https://student.valuxapps.com/api/'}login';
   return await http.post(Uri.parse(url),body: data);
   /* if(response.statusCode==200) {
      String body = response.body;
      print(body);
      return WeatherResponse.fromJson(jsonDecode(body));
    }else{
      throw BaseException.statusCod(response.statusCode);
    }*/

  }

  /*Future<Response> getWeather(String City)async{
    String url='${Constants.BASE_URL}/current?access_key=${Constants.API_KEY}&query=$City';
    Response response= await http.get(Uri.parse(url));
    if(response.statusCode==200) {
      String body = response.body;
      print(body);
      return WeatherResponse.fromJson(jsonDecode(body));
    }else{
      throw BaseException.statusCod(response.statusCode);
    }
  }*/


}*/
class DioHelper
{
  static Dio dio ;
  static void init()
  {
    dio = Dio(
        BaseOptions(
            baseUrl:'https://student.valuxapps.com/api/',
        )
    ) ;
    print('Dio heeeeereee=>'+dio.toString());
  }

  static Future<Response> getData(
      {
        @required String path ,
        Map <String,dynamic> query ,
        String authorization ,
      }
      )
  async {
    dio.options.headers={
      'Authorization':authorization ,
      'Content-Type':'application/json' ,
      'lang':'en' ,
    } ;
    return  await dio.get(path,queryParameters:query ) ;
  }

  static Future <Response> postData(
      {
        @required String path ,
        @required Map <String , dynamic> data ,
        Map <String ,dynamic> query ,
        String authorization  ,
      }
      ) async
  {
    dio.options.headers={
      'Authorization':authorization??'' ,
      'Content-Type':'application/json' ,
      'lang':'en' ,
    } ;

    return await dio.post(path,data: data ,queryParameters: query ) ;
  }



  static Future <Response> putData(
      {
        @required String path ,
        @required Map <String , dynamic> data ,
        Map <String ,dynamic> query ,
        String authorization  ,
      }
      ) async
  {
    dio.options.headers={
      'Authorization':authorization ,
      'Content-Type':'application/json' ,
      'lang':'en' ,
    } ;
    return await dio.put(path,queryParameters: query??null ,data: data ) ;
  }


}

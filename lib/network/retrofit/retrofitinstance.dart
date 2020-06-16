//import 'package:pretty_dio_logger/pretty_dio_logger.dart';
//import 'package:retrofit/retrofit.dart';
//import 'package:json_annotation/json_annotation.dart';
//import 'package:dio/dio.dart';
//
//part 'retrofitinstance.g.dart';
//
//@RestApi(baseUrl: "https://rcapp.utech.dev/api/")
//abstract class RestClient {
//
//  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;
//
//  static RestClient create() {
//
//    final dio = Dio();
//    return RestClient(dio);
//  }
//
//  @POST("auth/login")
//  @Header("application/json")
//  Future<HttpResponse<String>> loginUser(@Body() Map<String, dynamic> map);
//}
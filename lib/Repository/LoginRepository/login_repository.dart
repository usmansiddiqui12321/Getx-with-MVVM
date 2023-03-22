import 'dart:ui';
  
import 'package:getxwithmvvm/Data/Network/Network_API_Services.dart';

import '../../res/app_Url/app_Urls.dart';

class LoginRepository{
  final _apiservices=NetworkApiServices();
  Future<dynamic> loginApi(var data )async{
    dynamic response = await _apiservices.postApi(data, AppUrl.loginUrl);
    return response;
  }
}
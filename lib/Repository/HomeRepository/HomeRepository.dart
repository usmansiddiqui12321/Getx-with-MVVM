
import 'package:getxwithmvvm/Data/Network/Network_API_Services.dart';
import 'package:getxwithmvvm/model/HomeModel/UserListModel.dart';

import '../../res/app_Url/app_Urls.dart';

class HomeRepository{
  final _apiservices=NetworkApiServices();
  // ignore: non_constant_identifier_names
  Future<UserListModel> userListApi()async{
    dynamic response = await _apiservices.getApi(AppUrl.userList);
    return UserListModel.fromJson(response);
  }
}

import 'package:get/get.dart';

import '../../../Data/Response/status.dart';
import '../../../Repository/HomeRepository/HomeRepository.dart';
import '../../../model/HomeModel/UserListModel.dart';

class HomeConntroller extends GetxController {
  final api = HomeRepository();

  final rxRequestStatus = Status.LOADING.obs;
  final userList = UserListModel().obs;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) {
    rxRequestStatus.value = value;
  }

  void setUserlist(UserListModel value) {
    userList.value = value;
  }

  void setError(String value) => error.value = value;

  void userListAPi() {
    api.userListApi().then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setUserlist(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  Future<void> refreshapi() async{
    setRxRequestStatus(Status.LOADING);
   await api.userListApi().then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setUserlist(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }
}

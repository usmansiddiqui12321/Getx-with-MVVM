import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:getxwithmvvm/Data/Response/status.dart';
import 'package:getxwithmvvm/res/Colors/AppColors.dart';
import 'package:getxwithmvvm/res/Components/Genral_Exception_Widget.dart';
import 'package:getxwithmvvm/res/Components/Internet_Exception_Widget.dart';
import 'package:getxwithmvvm/view/UserDetail.dart';
import 'package:getxwithmvvm/view_model/Controller/UserPreference/user_preference_View_Model.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../res/Routes/Routes_name.dart';
import '../../view_model/Controller/home/home_View_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DateTime currentBackPressTime;

  Future<bool> _onWillPop() async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Press again to exit',
        backgroundColor: Colors.black54,
        textColor: Colors.white,
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  final GlobalKey<RefreshIndicatorState> refreshkey =
      GlobalKey<RefreshIndicatorState>();
  final homeController = Get.put(HomeConntroller());
  UserPreference userPreference = UserPreference();
  @override
  void initState() {
    super.initState();
    homeController.userListAPi();
  }

  Future<void> _refreshPage() async {
    return await homeController.refreshapi();
  }

  @override
  Widget build(BuildContext context) {
    UserPreference userPreference = UserPreference();
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("HomePage", textScaleFactor: 1.4),
          centerTitle: true,
          actions: [
            InkWell(
              onTap: () {
                userPreference.removeUser().then(
                  (value) {
                    Get.toNamed(RoutesName.loginView);
                  },
                );
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 18.0),
                child: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        body: Obx(
          () {
            switch (homeController.rxRequestStatus.value) {
              case Status.LOADING:
                return const Center(child: SizedBox());
              case Status.ERROR:
                if (homeController.error == 'No Internet') {
                  return Center(
                    child: InternetExceptionWidget(
                      onpress: () {
                        homeController.refreshapi();
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: GenralExceptionWidget(
                      onpress: () {
                        homeController.refreshapi().then((_) => null);
                      },
                    ),
                  );
                }

              case Status.COMPLETED:
                return LiquidPullToRefresh(
                  height: 200,
                  key: refreshkey,
                  showChildOpacityTransition: false,
                  animSpeedFactor: 2,
                  backgroundColor: AppColors.whiteColor,
                  color: AppColors.primaryColor,
                  onRefresh: _refreshPage,
                  child: ListView.builder(
                    itemCount: homeController.userList.value.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: InkWell(
                          onTap: () {
                            Get.to(
                                UserDetails(
                                    id: homeController
                                        .userList.value.data![index].id
                                        .toString(),
                                    email: homeController
                                        .userList.value.data![index].email
                                        .toString(),
                                    firstName: homeController
                                        .userList.value.data![index].firstName
                                        .toString(),
                                    lastName: homeController
                                        .userList.value.data![index].lastName
                                        .toString(),
                                    avatar: homeController
                                        .userList.value.data![index].avatar
                                        .toString()),
                                transition: Transition.noTransition);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    width: 2, color: AppColors.primaryColor)),
                            child: ListTile(
                              title: Text(homeController
                                  .userList.value.data![index].firstName
                                  .toString()),
                              subtitle: Text(homeController
                                  .userList.value.data![index].email
                                  .toString()),
                              trailing: const Icon(Icons.navigate_next_sharp),
                              leading: Hero(
                                tag: "userImageTag",
                                child: CircleAvatar(
                                  radius: 35,
                                  backgroundImage: NetworkImage(
                                    homeController
                                        .userList.value.data![index].avatar
                                        .toString(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}

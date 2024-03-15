import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/user/aplication/main_user_bloc/main_user_bloc.dart';
import 'package:share/user/aplication/main_user_bloc/main_user_event.dart';
import 'package:share/user/aplication/main_user_bloc/main_user_state.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_bloc.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_state.dart';
import 'package:share/user/presentation/alerts/snack_bars.dart';
import 'package:share/user/presentation/const/const_color.dart';
import 'package:share/user/presentation/pages/user_pages/main_pages/user_booking.dart';
import 'package:share/user/presentation/pages/user_pages/main_pages/user_current_property_page.dart';
import 'package:share/user/presentation/pages/user_pages/main_pages/user_home.dart';
import 'package:share/user/presentation/pages/user_pages/main_pages/user_map.dart';
import 'package:share/user/presentation/pages/user_pages/main_pages/user_message.dart';
import 'package:share/user/presentation/widgets/common_widget.dart';
import 'package:share/user/presentation/widgets/notification_widget.dart';

class MainPage extends StatelessWidget {
  List<Widget> userPages = [
    UserHome(),
    UserBookingPage(),
    UserCurrentPropertyPage(),
    UserMapPage(),
    UserMessagePage()
  ];
  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    var key = GlobalKey<ScaffoldState>();
    return BlocProvider(
      create: (context) => MainUserBloc(),
      child: BlocConsumer<MainUserBloc, MainUserState>(
        builder: (context, state) {
          return BlocConsumer<UserLoginBloc, UserLoginState>(
            listener: (context, state) {
              if (state is UserFavRemoveState) {
                SnackBars()
                    .errorSnackBar('Room removed from favorite', context);
              } else if (state is UserFavAddedState) {
                SnackBars().successSnackBar('Room added to favorite', context);
              } else if (state is UserDeatailsUpdatedState) {
                SnackBars().successSnackBar(
                    'user deatails updated successfully', context);
              }
            },
            builder: (context, state) {
              return SafeArea(
                child: Scaffold(
                  key: key,
                  appBar: AppBar(
                    leading: IconButton(
                        onPressed: () {
                          key.currentState!.openDrawer();
                        },
                        icon: const Icon(
                          Icons.menu_outlined,
                          size: 30,
                        )),
                    actions: [
                      NotificationWidget().notificationButton(context: context)
                    ],
                  ),
                  body: userPages[context.watch<MainUserBloc>().index],
                  drawer: CommonWidget().drawerReturnFunction(context),
                  // drawer:CommonWidget().drawerReturnFunction(context),
                  // bottomNavigationBar: MotionTabBar(
                  //   initialSelectedTab: 'Home',
                  //   tabBarColor: MediaQuery.of(context).platformBrightness ==
                  //           Brightness.light
                  //       ? Colors.white
                  //       : Colors.black,
                  //   labels: const ["Home", "Booking", 'Property',"Message"],
                  //   textStyle: Theme.of(context).textTheme.displaySmall,
                  //   icons: const [
                  //     Icons.window_rounded,
                  //     Icons.calendar_month,
                  //     Icons.maps_home_work_rounded,
                  //     Icons.message_rounded,

                  //   ],
                  //   onTabItemSelected: (value) {
                  //     BlocProvider.of<MainUserBloc>(context)
                  //         .add(OnNavBarClickedEvent(index: value));
                  //   },
                  //   tabIconColor: MediaQuery.of(context).platformBrightness ==
                  //           Brightness.light
                  //       ? Colors.black
                  //       : Colors.white,
                  //   tabSelectedColor: MediaQuery.of(context).platformBrightness ==
                  //           Brightness.light
                  //       ? Colors.black
                  //       : Colors.white,
                  //   tabIconSize: 30,
                  //   tabIconSelectedColor:
                  //       MediaQuery.of(context).platformBrightness ==
                  //               Brightness.light
                  //           ? const Color.fromARGB(255, 255, 255, 255)
                  //           : const Color.fromARGB(255, 0, 0, 0),
                  // ),
                  bottomNavigationBar: FlashyTabBar(
                    showElevation: false,
                    height: 55,
                    iconSize: 30,
                    animationDuration: const Duration(milliseconds: 500),
                    selectedIndex: BlocProvider.of<MainUserBloc>(context).index,
                    items: [
                      FlashyTabBarItem(
                          activeColor: ConstColor().mainColorblue,
                          inactiveColor: ConstColor().bottomNavIconColor,
                          icon: const Icon(Icons.dashboard),
                          title: Text('Home',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      fontSize: 15,
                                      color: ConstColor().mainColorblue))),
                      FlashyTabBarItem(
                          activeColor: ConstColor().mainColorblue,
                          inactiveColor: ConstColor().bottomNavIconColor,
                          icon: const Icon(Icons.calendar_month),
                          title: Text('Booking',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      fontSize: 15,
                                      color: ConstColor().mainColorblue))),
                      FlashyTabBarItem(
                          activeColor: ConstColor().mainColorblue,
                          inactiveColor: ConstColor().bottomNavIconColor,
                          icon: const Icon(Icons.maps_home_work_rounded),
                          title: Text('Property',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      fontSize: 15,
                                      color: ConstColor().mainColorblue))),
                      FlashyTabBarItem(
                          activeColor: ConstColor().mainColorblue,
                          inactiveColor: ConstColor().bottomNavIconColor,
                          icon: const Icon(Icons.location_on_sharp),
                          title: Text('Map',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      fontSize: 15,
                                      color: ConstColor().mainColorblue))),
                      // FlashyTabBarItem(
                      //     activeColor: ConstColor().mainColorblue,
                      //     inactiveColor: ConstColor().bottomNavIconColor,
                      //     icon: const Icon(Icons.message),
                      //     title: Text('message',
                      //         style: Theme.of(context)
                      //             .textTheme
                      //             .titleSmall!
                      //             .copyWith(
                      //                 fontSize: 15,
                      //                 color: ConstColor().mainColorblue))),
                    ],
                    onItemSelected: (value) {
                      BlocProvider.of<MainUserBloc>(context)
                          .add(OnNavBarClickedEvent(index: value));
                    },
                  ),
                ),
              );
            },
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}

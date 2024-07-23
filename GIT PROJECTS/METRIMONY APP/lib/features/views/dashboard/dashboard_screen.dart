import 'dart:io';
import 'package:bureau_couple/controllers/auth_controller.dart';
import 'package:bureau_couple/controllers/profile_controller.dart';
import 'package:bureau_couple/features/views/proflle/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:bureau_couple/utils/assets.dart';
import 'package:bureau_couple/utils/dimensions.dart';
import 'package:bureau_couple/utils/styles.dart';
import 'package:bureau_couple/features/views/home/home_screen.dart';
import 'package:get/get.dart';
import '../home/matches_screen.dart';

bool isClick = false;
class DashboardScreen extends StatefulWidget {

  const DashboardScreen({super.key,});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {


  Future<bool> onBackMove(BuildContext context) {
    if (isClick == true) {
      setState(() {
        isClick = false;
      });
      return Future.value(false);
    } else {
      return onBackPressed(context);
    }
  }
  onBackPressed(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title:  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(Icons.exit_to_app_sharp, color: Theme.of(context).primaryColor),
              SizedBox(width: 10),
              Text('Close Application?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ]),
            content: const Text('Are you sure you want to exit the Application?'),
            actions: <Widget>[
              TextButton(
                child:  Text('No', style: TextStyle(fontSize: 15, color: Theme.of(context).primaryColor)),
                onPressed: () {
                  Navigator.of(context).pop(false); //Will not exit the App
                },
              ),
              TextButton(
                child:  Text(
                  'Yes',
                  style: TextStyle(fontSize: 15, color: Theme.of(context).primaryColor),
                ),
                onPressed: () {
                  exit(0);
                },
              )
            ],
          );
        });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ProfileController>().getUserDetailsApi();
    });
    super.initState();

  }
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () => onBackMove(context),
      child: Scaffold(
        body: [
          HomeScreen(),
          MatchesScreen(appbar: false,),
          // ConnectionScreen(),
          ProfileScreen()
        ][index],
        bottomNavigationBar: bottomBar(),

      ),
    );
  }

  SingleChildScrollView bottomBar() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      index = 0;
                    });
                  },
                  child: Column(
                    children: [
                      Image.asset(icHome,
                        height: 24,
                        width: 24,
                        color: index ==0 ? Theme.of(context).primaryColor : Theme.of(context).primaryColorDark.withOpacity(0.60),),
                      const SizedBox(height: 5,),
                      Text("Home",style: satoshiMedium.copyWith(fontSize: Dimensions.fontSize14,
                        color: index ==0 ? Theme.of(context).primaryColor : Theme.of(context).primaryColorDark.withOpacity(0.60),),)
                    ],
                  ),
                )),
            Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      index = 1;
                    });
                  },
                  child: Column(
                    children: [
                      Image.asset(icHomeHeart,
                        height: 24,
                        width: 24,
                        color: index ==1 ? Theme.of(context).primaryColor : Theme.of(context).primaryColorDark.withOpacity(0.60),),
                      const SizedBox(height: 5,),
                      Text("Matches",style: satoshiMedium.copyWith(fontSize: 12,
                        color: index ==1 ? Theme.of(context).primaryColor : Theme.of(context).primaryColorDark.withOpacity(0.60),),)
                    ],
                  ),
                )),

            Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      index = 2;
                    });
                  },
                  child: Column(
                    children: [
                      Image.asset(icConnect,
                        height: 24,
                        width: 24,
                        color: index ==2 ? Theme.of(context).primaryColor : Theme.of(context).primaryColorDark.withOpacity(0.60),),
                      const SizedBox(height: 5,),
                      Text("Connected",style:  satoshiMedium.copyWith(
                        fontSize: Dimensions.fontSize12,
                        color:index ==2 ? Theme.of(context).primaryColor : Theme.of(context).primaryColorDark.withOpacity(0.60),),)
                    ],
                  ),
                )),
            Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      index = 3;
                    });
                  },
                  child: Column(
                    children: [
                      Image.asset(icProfilePlaceHolder,
                        height: 24,
                        width: 24,
                        /* color: index ==3 ? primaryColor : color353839,*/),
                      const SizedBox(height: 5,),
                      Text("Profile",style: satoshiMedium.copyWith(fontSize: Dimensions.fontSize12,
                        color: index ==3 ? Theme.of(context).primaryColor : Theme.of(context).primaryColorDark.withOpacity(0.60),)
                        ,)
                    ],
                  ),
                )),


          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iclinix/app/screens/home/components/book_appointment_component.dart';
import 'package:iclinix/app/screens/home/components/need_for_help_component.dart';
import 'package:iclinix/app/screens/home/components/verticle_banner_components.dart';
import 'package:iclinix/utils/dimensions.dart';
import 'package:iclinix/utils/images.dart';
import 'package:iclinix/utils/sizeboxes.dart';
import 'package:iclinix/utils/styles.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController filter = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body:CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                expandedHeight: 110.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration:  BoxDecoration(
                      color: Theme.of(context).cardColor,

                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                      child: Column(
                        children: [
                         sizedBox30(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(behavior: HitTestBehavior.translucent,
                                    onTap: () {

                                    },
                                    child: Image.asset(
                                      Images.icMenu,
                                      height: Dimensions.paddingSize30,
                                      width: Dimensions.paddingSize30,
                                    ),
                                  ),
                                  sizedBoxW7(),
                                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Good Morning",
                                        style: openSansRegular.copyWith(
                                            color: Theme.of(context).disabledColor.withOpacity(0.40),
                                            fontSize: Dimensions.fontSize12),
                                      ),
                                      Text(
                                        "Hello Username",
                                        style: openSansBold.copyWith(
                                            color: Theme.of(context).disabledColor,
                                            fontSize: Dimensions.fontSizeDefault),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset(Images.icWhatsapp,height: Dimensions.fontSize24,),
                                  sizedBoxW15(),
                                  Image.asset(Images.icNotification,height: Dimensions.fontSize24,),

                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(40.0),
                  child: Padding(
                    padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault,
                    right:  Dimensions.paddingSizeDefault,
                    bottom: Dimensions.paddingSizeDefault),
                    child: Column(children: [
                      InkWell(onTap: () {
                      },
                        child: Container(
                          height: 45,
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSize5),
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.5,
                            color: Theme.of(context).disabledColor.withOpacity(0.10)),
                            color: Theme.of(context).cardColor,
                            borderRadius:
                            BorderRadius.circular(Dimensions.paddingSize5),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search,
                                color: Theme.of(context).hintColor,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Search",
                                      style: openSansSemiBold.copyWith(
                                          fontSize: Dimensions.fontSize13,
                                          color: Theme.of(context)
                                              .hintColor), // Different color for "resend"
                                    ),

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
              ),
              SliverToBoxAdapter(
                child:
                Column(
                  children: [
                    BookAppointmentComponent(),
                    NeedForHelpComponent(),
                    VerticalBannerComponents(),
                    sizedBox100(),
                  ],
                ),
              )
            ],

    ),);
  }
}



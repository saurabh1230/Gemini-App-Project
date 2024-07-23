import 'package:bureau_couple/controllers/auth_controller.dart';
import 'package:bureau_couple/controllers/matches_controller.dart';
import 'package:bureau_couple/controllers/profile_controller.dart';
import 'package:bureau_couple/data/response/Matches_model.dart';
import 'package:bureau_couple/features/views/proflle/basic_info_screen.dart';
import 'package:bureau_couple/features/widgets/custom_image_widget.dart';
import 'package:bureau_couple/src/constants/string.dart';
import 'package:bureau_couple/src/constants/textstyles.dart';
import 'package:bureau_couple/src/utils/urls.dart';
import 'package:bureau_couple/src/utils/widgets/common_widgets.dart';
import 'package:bureau_couple/src/utils/widgets/custom_image_widget.dart';
import 'package:bureau_couple/utils/app_constants.dart';
import 'package:bureau_couple/utils/assets.dart';
import 'package:bureau_couple/utils/colors.dart';
import 'package:bureau_couple/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../../../src/constants/sizedboxe.dart';
import '../proflle/user_profile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  // final LoginResponse response;

  const HomeScreen({super.key, /*required this.response,*/});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   bool loading =false;
   @override
   void initState() {
     super.initState();
     // getMatches();
     // getPreferredMatch();
     // profileDetail();

   }










  @override
  Widget build(BuildContext context) {
    Get.find<MatchesController>().getMatchesList("1");
    return Scaffold(
      appBar: buildAppBar(),
      body: GetBuilder<MatchesController>(builder: (matchesControl) {
        return SingleChildScrollView(
          child:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${matchesControl.matchesList!.length} Members for you",style: styleSatoshiBold(size: 18, color: color1C1C1c),),
                      SizedBox(
                        height: 140,
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount:matchesControl.matchesList!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_,i) {
                            return GestureDetector(
                              onTap: () {
                                //
                                Navigator.push(
                                    context, MaterialPageRoute(
                                    builder: (builder) =>  UserProfileScreen(userId:matchesControl.matchesList![i].id.toString(),)));

                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex:2,
                                    child: Container(
                                      height: 65,
                                      width: 65,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: '$baseProfilePhotoUrl${matchesControl.matchesList![i].image ?? ''}',
                                        fit: BoxFit.fill,
                                        errorWidget: (context, url, error) =>
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Image.asset(icLogo,
                                                height: 40,
                                                width: 40,),
                                            ),
                                        progressIndicatorBuilder: (a, b, c) =>
                                            customShimmer(height: 170,),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${StringUtils.capitalize(matchesControl.matchesList![i].firstname ?? '')}\n${StringUtils.capitalize(matchesControl.matchesList![i].lastname ?? 'User')}',
                                      maxLines: 2,
                                      textAlign:TextAlign.center,
                                      style: styleSatoshiBlack(size: 14, color: Colors.black.withOpacity(0.60)),),
                                  ),
                                ],
                              ),
                            );
                          }, separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 16,),),
                      ),
                      const SizedBox(height: 20,),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text('Category By Filter',
                      style: styleSatoshiBold(size: 16, color: Colors.black),),
                      sizedBox16(),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: GestureDetector(onTap :() {
                              // Navigator.push(
                              //     context, MaterialPageRoute(
                              //     builder: (builder) =>  FilterMatchesScreen(response: widget.response, filter: widget.response.data!.user!.religion!.toString(), motherTongue: '', minHeight: '', maxHeight: '', maxWeight: '', based: 'Religion',))
                              // );

                            },
                              child: Column(
                                children: [
                                  Image.asset(fReligion,height: 55,),
                                  sizedBox6(),
                                  Text("Religion",style: styleSatoshiLight(size: 12, color: colorDA4F7A),)
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(onTap :() {
                              // Navigator.push(
                              //     context, MaterialPageRoute(
                              //     builder: (builder) =>  FilterMatchesScreen(response: widget.response, filter: '', motherTongue:widget.response.data!.user!.motherTongue!.toString(), minHeight: '', maxHeight: '', maxWeight: profile.data!.user!.partnerExpectation!.maxWeight!.toString(), based: 'State',))
                              // );

                            },
                              child: Column(
                                children: [
                                  Image.asset(fCommunity,height: 55,),
                                  sizedBox6(),
                                  Text("State",style: styleSatoshiLight(size: 12, color: colorF27047),)
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(onTap :() {
                              // Navigator.push(
                              //     context, MaterialPageRoute(
                              //     builder: (builder) =>  FilterMatchesScreen(response: widget.response, filter: '', motherTongue:'', minHeight: '', maxHeight: '', maxWeight:  profile.data!.user!.partnerExpectation!.maxWeight.toString(), based: 'Weight',))
                              // );
                            },
                              child: Column(
                                children: [
                                  Image.asset(fAge,height: 55,),
                                  sizedBox6(),
                                  Text("Weight",style: styleSatoshiLight(size: 12, color: color7859BC),)
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(onTap: () {
                              // Navigator.push(
                              //     context, MaterialPageRoute(
                              //     builder: (builder) =>  FilterMatchesScreen(response: widget.response, filter: '', motherTongue:widget.response.data!.user!.motherTongue!.toString(), minHeight: '', maxHeight: '', maxWeight: '', based: 'Language',))
                              // );
                            },
                              child: Column(
                                children: [
                                  Image.asset(flanguage,height: 55,),
                                  sizedBox6(),
                                  Text("Language",style: styleSatoshiLight(size: 12, color: colorF2AB47),)
                                ],
                              ),
                            ),
                          ),

                        ],),],),
                ),
                sizedBox16(),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (builder) =>
                    //     AllMatchesScreen(response: widget.response, religionFilter: '', )));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('New Matches',
                          style: styleSatoshiBold(size: 18, color: Colors.black),),
                        Text('See All',
                          style: styleSatoshiBold(size: 12, color: Colors.black),),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text("All New Members ",
                    style: styleSatoshiMedium(size: 14,
                      color: color1C1C1c.withOpacity(0.60),
                    ),
                  ),
                ),
                sizedBox14(),
                /*if (isLoading) Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: primaryColor,
                    size: 60,
                  )) else*/ SizedBox(height: 200,
                  child: ListView.separated(
                    padding: const EdgeInsets.only(left: 16),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: matchesControl.matchesList!.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (_, i) {
                      DateTime? birthDate =  matchesControl.matchesList![i].basicInfo != null ? DateFormat('yyyy-MM-dd').parse( matchesControl.matchesList![i].basicInfo!.birthDate!) : null;
                      int age = birthDate != null ? DateTime.now().difference(birthDate).inDays ~/ 365 : 0;
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context, MaterialPageRoute(
                              builder: (builder) =>  UserProfileScreen(userId: matchesControl.matchesList![i].id.toString(),))
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: 200,width: 160,
                              clipBehavior: Clip.hardEdge,
                              decoration: const  BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10.0),),
                              ),
                              child: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.3),
                                  BlendMode.srcOver,
                                ),
                                child: CachedNetworkImage(
                                  imageUrl:  matchesControl.matchesList![i].image != null ? '$baseProfilePhotoUrl${ matchesControl.matchesList![i].image}' : '',
                                  fit: BoxFit.fill,
                                  errorWidget: (context, url, error) =>
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(icLogo,
                                          height: 40,
                                          width: 40,),
                                      ),
                                  progressIndicatorBuilder: (a, b, c) =>
                                      customShimmer(height: 0, /*width: 0,*/),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom:0,
                              left:20,
                              right:20,
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${StringUtils.capitalize( matchesControl.matchesList![i].firstname ?? '')} ${StringUtils.capitalize( matchesControl.matchesList![i].lastname ?? 'User')}',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: styleSatoshiBold(size: 14, color: Colors.white),),
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '$age yrs',
                                                  style: styleSatoshiRegular(size: 10, color: Colors.white),
                                                ),
                                                const SizedBox(width: 6,),
                                                Container(
                                                  height: 4,
                                                  width: 4,
                                                  decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white,
                                                  ),),
                                                const SizedBox(width: 6,),
                                                Text(
                                                  "${ matchesControl.matchesList![i].physicalAttributes!.height ?? ''} ft",
                                                  style: styleSatoshiRegular(size: 10, color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  matchesControl.matchesList![i].basicInfo?.religion ?? '',
                                                  style: styleSatoshiRegular(size: 13, color: Colors.white),
                                                ),
                                                Text(overflow: TextOverflow.ellipsis,maxLines: 1,
                                                  matchesControl.matchesList![i].basicInfo?.presentAddress?.state ?? '',

                                                  style: styleSatoshiRegular(size: 13, color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            // like[i] ||  matchesControl.matchesList![i].interestStatus == 2  ?
                                            // TickButton(tap: () {  },):
                                            AddButton(tap: () {
                                              setState(() {
                                                // like[i] = !like[i];
                                              });
                                              // sendRequestApi(
                                              //     memberId:  matchesControl.matchesList![i]
                                              //         .id
                                              //         .toString())
                                              //     .then((value) {
                                              //   if (value['status'] == true) {
                                              //     setState(() {
                                              //       isLoadingList[i] = false;
                                              //     });
                                              //     ToastUtil.showToast(
                                              //         "Connection Request Sent");
                                              //   } else {
                                              //     setState(() {
                                              //       isLoadingList[i] = false;
                                              //     });
                                              //
                                              //     List<dynamic> errors =
                                              //     value['message']['error'];
                                              //     String errorMessage = errors
                                              //         .isNotEmpty
                                              //         ? errors[0]
                                              //         : "An unknown error occurred.";
                                              //     Fluttertoast.showToast(
                                              //         msg: errorMessage);
                                              //   }
                                              // });
                                            },)
                                          ],
                                        ),

                                        sizedBox18(),
                                      ],
                                    ),
                                  ),


                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }, separatorBuilder: (BuildContext context, int index) => SizedBox(width: 16,),
                  ),
                ),
                sizedBox16(),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (builder) =>
                    //     AllMatchesScreen(response: widget.response, religionFilter: widget.response.data!.user!.religion!.toString(),)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Preferred Matches',
                          style: styleSatoshiBold(size: 18, color: Colors.black),),
                        Text('See All',
                          style: styleSatoshiBold(size: 12, color: Colors.black),),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text("Members Based On your Preference",
                    style: styleSatoshiMedium(size: 14,
                      color: color1C1C1c.withOpacity(0.60),
                    ),
                  ),
                ),
                sizedBox14(),
                /*if (isLoading) Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: primaryColor,
                    size: 60,
                  )) else*/ SizedBox(height: 200,
                  child: ListView.separated(
                    padding: const EdgeInsets.only(left: 16),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount:  matchesControl.matchesList!.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (_, i) {
                      DateTime? birthDate =  matchesControl.matchesList![i].basicInfo != null ? DateFormat('yyyy-MM-dd').parse( matchesControl.matchesList![i].basicInfo!.birthDate!) : null;
                      int age = birthDate != null ? DateTime.now().difference(birthDate).inDays ~/ 365 : 0;
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context, MaterialPageRoute(
                              builder: (builder) =>  UserProfileScreen(userId: matchesControl.matchesList![i].id.toString(),))
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: 200,width: 160,
                              clipBehavior: Clip.hardEdge,
                              decoration: const  BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10.0),),
                              ),
                              child: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.3),
                                  BlendMode.srcOver,
                                ),
                                child: CachedNetworkImage(
                                  imageUrl:  matchesControl.matchesList![i].image != null ? '$baseProfilePhotoUrl${ matchesControl.matchesList![i].image}' : '',
                                  fit: BoxFit.fill,
                                  errorWidget: (context, url, error) =>
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(icLogo,
                                          height: 40,
                                          width: 40,),
                                      ),
                                  progressIndicatorBuilder: (a, b, c) =>
                                      customShimmer(height: 0, /*width: 0,*/),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom:0,
                              left:20,
                              right:20,
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${StringUtils.capitalize( matchesControl.matchesList![i].firstname ?? '')} ${StringUtils.capitalize( matchesControl.matchesList![i].lastname ?? 'User')}',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: styleSatoshiBold(size: 14, color: Colors.white),),
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '$age yrs',
                                                  style: styleSatoshiRegular(size: 10, color: Colors.white),
                                                ),
                                                const SizedBox(width: 6,),
                                                Container(
                                                  height: 4,
                                                  width: 4,
                                                  decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white,
                                                  ),),
                                                const SizedBox(width: 6,),
                                                Text(
                                                  "${ matchesControl.matchesList![i].physicalAttributes!.height ?? ''} ft",
                                                  style: styleSatoshiRegular(size: 10, color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  matchesControl.matchesList![i].basicInfo?.religion ?? '',
                                                  style: styleSatoshiRegular(size: 13, color: Colors.white),
                                                ),
                                                Text(overflow: TextOverflow.ellipsis,maxLines: 1,
                                                  matchesControl.matchesList![i].basicInfo?.presentAddress?.state ?? '',

                                                  style: styleSatoshiRegular(size: 13, color: Colors.white),
                                                ),
                                              ],
                                            ),

                                            // like[i] ||  matchesControl.matchesList![i].interestStatus == 2  ?
                                            // TickButton(tap: () {  },):
                                            AddButton(tap: () {
                                              // setState(() {
                                              //   like[i] = !like[i];
                                              // });
                                              // sendRequestApi(
                                              //     memberId: preferredMatches[i]
                                              //         .id
                                              //         .toString())
                                              //     .then((value) {
                                              //   if (value['status'] == true) {
                                              //     setState(() {
                                              //       isLoadingList[i] = false;
                                              //     });
                                              //     ToastUtil.showToast(
                                              //         "Connection Request Sent");
                                              //   } else {
                                              //     setState(() {
                                              //       isLoadingList[i] = false;
                                              //     });
                                              //
                                              //     List<dynamic> errors =
                                              //     value['message']['error'];
                                              //     String errorMessage = errors
                                              //         .isNotEmpty
                                              //         ? errors[0]
                                              //         : "An unknown error occurred.";
                                              //     Fluttertoast.showToast(
                                              //         msg: errorMessage);
                                              //   }
                                              // });
                                            },)
                                          ],
                                        ),

                                        sizedBox18(),
                                      ],
                                    ),
                                  ),


                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }, separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 16,),
                  ),
                ),
                sizedBox16(),
                const SizedBox(height: 50,),


              ],
            ),
          ),
        );
      }),

    );
  }



  AppBar buildAppBar() {
    return AppBar(backgroundColor: primaryColor,

      shape: const  RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(0),
        ),
      ),
      centerTitle: false,
      title: Padding(
        padding: const EdgeInsets.only(left: 6.0),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (builder) => const EditBasicInfoScreen()));
              },
              child: ClipOval(child: CustomImageWidget(image: '$baseProfilePhotoUrl${Get.find<ProfileController>().userDetails!.data!.user!.image}',height: 40,width: 40,)),

            ),
            const SizedBox(width: 10,),
            Text(StringUtils.capitalize(Get.find<ProfileController>().userDetails!.data!.user!.firstname!),
              style: styleSatoshiBold(size: 18, color: Colors.white),
            ),
          ],
        ),
      ),
      actions: [
        GestureDetector(behavior: HitTestBehavior.translucent,
          onTap: () {
            // Navigator.push(context, MaterialPageRoute(builder: (builder) => const ConnectScreen()));
          },
            child: 
             Padding(
              padding: const EdgeInsets.all(14.0),
              child: Image.asset(icBell,height: Dimensions.fontSize24,color: Colors.white,)
            )),

      ],
      automaticallyImplyLeading: false,

    );
  }
}



class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomShimmerEffect(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // buildStack(),
            Text("Members looking for you",
              style: styleSatoshiBold(size: 18, color: color1C1C1c),),
            sizedBox10(),
            SizedBox(
              height: 140,
              child: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_,i) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(fReligion,height: 65,),
                      Text(
                        'User',
                        maxLines: 2,
                        textAlign:TextAlign.center,
                        style: styleSatoshiBlack(size: 14, color: Colors.black.withOpacity(0.60)),),
                    ],
                  );
                }, separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 16,),),
            ),
            // const SizedBox(height: 20,),

            Text('Category By Filter',
              style: styleSatoshiBold(size: 16, color: Colors.black),),
            sizedBox16(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Image.asset(fReligion,height: 55,),
                      sizedBox6(),
                      Text("Religion",style: styleSatoshiLight(size: 12, color: colorDA4F7A),)
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Image.asset(fCommunity,height: 55,),
                      sizedBox6(),
                      Text("State",style: styleSatoshiLight(size: 12, color: color7BB972),)
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Image.asset(fAge,height: 55,),
                      sizedBox6(),
                      Text("Weight",style: styleSatoshiLight(size: 12, color: color7859BC),)
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Image.asset(flanguage,height: 55,),
                      sizedBox6(),
                      Text("Language",style: styleSatoshiLight(size: 12, color: colorF2AB47),)
                    ],
                  ),
                ),

              ],),
            sizedBox16(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Preferred Matches',
                  style: styleSatoshiBold(size: 18, color: Colors.black),),
                Text('See All',
                  style: styleSatoshiBold(size: 12, color: Colors.black),),
              ],
            ),
            Text("Members Based On your Preference",
              style: styleSatoshiMedium(size: 14,
                color: color1C1C1c.withOpacity(0.60),
              ),
            ),
            sizedBox14(),
            GridView.builder(
              shrinkWrap: true,
              itemCount :2,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (_, i) {
                return Stack(
                  children: [
                    Container(
                      height: 400,
                      clipBehavior: Clip.hardEdge,
                      decoration: const  BoxDecoration(color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(10.0),),
                      ),

                    ),

                  ],
                );
              },
            ),
            sizedBox16(),
          ],
        ),
      ),
    );
  }
}

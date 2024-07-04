// import 'package:bureau_couple/controllers/profile_controller.dart';
// import 'package:bureau_couple/src/constants/colors.dart';
// import 'package:bureau_couple/src/constants/sizedboxe.dart';
// import 'package:bureau_couple/src/utils/widgets/buttons.dart';
// import 'package:bureau_couple/src/utils/widgets/customAppbar.dart';
// import 'package:get/get.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/widgets.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import '../../../apis/profile_apis/basic_info_api.dart';
// import '../../../apis/profile_apis/get_profile_api.dart';
// import '../../../constants/assets.dart';
// import '../../../constants/string.dart';
// import '../../../constants/textstyles.dart';
// import '../../../models/basic_info_model.dart';
// import '../../../models/info_model.dart';
// import '../../../utils/widgets/common_widgets.dart';
// import '../../../utils/widgets/name_edit_dialog.dart';
// import '../../../utils/widgets/textfield_decoration.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shimmer/shimmer.dart';
//
// import 'edit_preferred_matches.dart';
// class EditBasicInfoScreen extends StatefulWidget {
//   const EditBasicInfoScreen({super.key});
//
//   @override
//   State<EditBasicInfoScreen> createState() => _EditBasicInfoScreenState();
// }
//
// class _EditBasicInfoScreenState extends State<EditBasicInfoScreen> {
//   final firstNameController = TextEditingController();
//   final lastNameController = TextEditingController();
//   final userNameController = TextEditingController();
//   final emailController = TextEditingController();
//   final professionController = TextEditingController();
//   final genderController = TextEditingController();
//   final religionController = TextEditingController();
//   final smokingController = TextEditingController();
//   final drinkingController = TextEditingController();
//   final birthDateController = TextEditingController();
//   final communityController = TextEditingController();
//   final motherTongueController = TextEditingController();
//   final marriedStatusController = TextEditingController();
//   final stateController = TextEditingController();
//   final zipController = TextEditingController();
//   final countryController = TextEditingController();
//   final cityController = TextEditingController();
//   final financialCondition = TextEditingController();
//   final aboutUs = TextEditingController();
//   bool load = false;
//   bool loading = false;
//   bool isLoading = false;
//
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Get.find<ProfileController>().getBasicInfoApi();
//       // fields();
//     });
//
//     super.initState();
//   }
//
//   File pickedImage = File("");
//   final ImagePicker _imgPicker = ImagePicker();
//
//   // BasicInfoModel basicInfo = BasicInfoModel();
//   // InfoModel mainInfo = InfoModel();
//
//   // careerInfo() {
//   //   isLoading = true;
//   //   var resp = getProfileApi();
//   //   resp.then((value) {
//   //     // physicalData.clear();
//   //     if (value['status'] == true) {
//   //       setState(() {
//   //         var physicalAttributesData = value['data']['user']['basic_info'];
//   //         if (physicalAttributesData != null) {
//   //           setState(() {
//   //             basicInfo = BasicInfoModel.fromJson(physicalAttributesData);
//   //             fields();
//   //           });
//   //         }
//   //         var info = value['data']['user'];
//   //         if (info != null) {
//   //           setState(() {
//   //             mainInfo = InfoModel.fromJson(info);
//   //             fields();
//   //           });
//   //         }
//   //         isLoading = false;
//   //       });
//   //     } else {
//   //       setState(() {
//   //         isLoading = false;
//   //       });
//   //     }
//   //   });
//   // }
//
//   void fields() {
//     firstNameController.text = Get.find<ProfileController>().userDetails?.data?.user?.firstname.toString() ?? '';
//     lastNameController.text = Get.find<ProfileController>().userDetails?.data?.user?.lastname.toString()  ?? '';
//     userNameController.text = Get.find<ProfileController>().userDetails?.data?.user?.username.toString()  ?? '';
//     emailController.text = Get.find<ProfileController>().userDetails?.data?.user?.email.toString()  ?? '';
//     professionController.text = Get.find<ProfileController>().basicInfo?.profession ?? '';
//     genderController.text = Get.find<ProfileController>().basicInfo?.gender ?? '';
//     religionController.text = Get.find<ProfileController>().basicInfo?.religion ?? '';
//     smokingController.text = Get.find<ProfileController>().basicInfo?.smokingStatus.toString() ?? '';
//     drinkingController.text = Get.find<ProfileController>().basicInfo?.drinkingStatus.toString() ?? '';
//     birthDateController.text = Get.find<ProfileController>().basicInfo?.birthDate! ?? '';
//     communityController.text = Get.find<ProfileController>().basicInfo?.community! ?? '';
//     motherTongueController.text = Get.find<ProfileController>().basicInfo?.motherTongue! ?? '';
//     marriedStatusController.text = Get.find<ProfileController>().basicInfo?.maritalStatus! ?? '';
//     stateController.text = Get.find<ProfileController>().basicInfo?.presentAddress?.state ?? '';
//     zipController.text = Get.find<ProfileController>().basicInfo?.presentAddress?.zip ?? '';
//     countryController.text =
//         Get.find<ProfileController>().basicInfo?.presentAddress?.country ?? '';
//     cityController.text = Get.find<ProfileController>().basicInfo?.presentAddress?.city ?? '';
//     financialCondition.text = Get.find<ProfileController>().basicInfo?.financialCondition ?? '';
//     aboutUs.text = Get.find<ProfileController>().basicInfo?.aboutUs ?? '';
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomAppBar(title: "Basic Info",),
//       bottomNavigationBar: buildBottombarPadding(context),
//       body: GetBuilder<ProfileController>(builder: (basicInfoControl) {
//         return basicInfoControl.isLoading
//             ? const BasicInfoShimmerWidget()
//             : SingleChildScrollView(
//           child: Padding(
//             padding:
//             const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
//             child: Column(
//               children: [
//                 Align(alignment: Alignment.centerLeft,
//                     child: Text("Basic Info",style:styleSatoshiMedium(size: 16, color: primaryColor))),
//                 sizedBox16(),
//                 GestureDetector(
//                   // onTap: _pickImage
//                   onTap: () async {
//                     XFile? v = await _imgPicker.pickImage(
//                         source: ImageSource.gallery);
//                     if (v != null) {
//                       setState(
//                             () {
//                           pickedImage = File(v.path);
//                         },
//                       );
//                     }
//                   },
//                   child: Container(
//                     height: 104,
//                     width: 104,
//                     clipBehavior: Clip.hardEdge,
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                     ),
//                     child: pickedImage.path.isEmpty
//                         ? Image.asset(
//                       icProfilePlaceHolder,
//                     )
//                         : Image.file(
//                       pickedImage,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 sizedBox16(),
//                 elevatedButton(
//                     color: Colors.green,
//                     height: 30,
//                     style: styleSatoshiLight(
//                         size: 10, color: Colors.white),
//                     width: 80,
//                     context: context,
//                     onTap: () {
//                       print(basicInfoControl.basicInfo!.motherTongue);
//                       // if (pickedImage.path.isEmpty) {
//                       //   Fluttertoast.showToast(
//                       //       msg: "Please Pick Image First");
//                       // } else {
//                       //   setState(() {
//                       //     load = true;
//                       //   });
//                       //   addProfileImageAPi(photo: pickedImage.path
//                       //           // id: career[0].id.toString(),
//                       //           )
//                       //       .then((value) {
//                       //     if (value['status'] == true) {
//                       //       setState(() {
//                       //         load = false;
//                       //       });
//                       //       ToastUtil.showToast(
//                       //           "Image Updated Successfully");
//                       //     } else {
//                       //       setState(() {
//                       //         loading = false;
//                       //       });
//                       //
//                       //       List<dynamic> errors =
//                       //           value['message']['error'];
//                       //       String errorMessage = errors.isNotEmpty
//                       //           ? errors[0]
//                       //           : "An unknown error occurred.";
//                       //       Fluttertoast.showToast(msg: errorMessage);
//                       //     }
//                       //   });
//                       // }
//                     },
//                     title: "Add"),
//                 GestureDetector(
//                   onTap: () {
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return NameEditDialogWidget(
//                           title: 'Introduction',
//                           addTextField: TextFormField(
//                             maxLength: 500,
//                             onChanged: (v) {
//                               setState(() {});
//                             },
//                             onEditingComplete: () {
//                               Navigator.pop(context); // Close the dialog
//                             },
//                             controller: aboutUs,
//                             decoration: AppTFDecoration(hint: 'Introduction')
//                                 .decoration(),
//                             //keyboardType: TextInputType.phone,
//                           ),
//                         );
//                       },
//                     );
//
//                   },
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Text(
//                             "Introduction",style: styleSatoshiRegular(size: 14, color: color5E5E5E),
//                           ),
//                           SizedBox(width: 3,),
//                           Icon(
//                             Icons.edit,
//                             size: 12,
//                           ),
//                         ],
//                       ),
//                       aboutUs.text.isEmpty?
//                       SizedBox() :
//                       Column(
//                         children: [
//                           sizedBox16(),
//
//                           Text(
//                             aboutUs.text.isEmpty
//                                 ? (basicInfoControl.basicInfo!.id == null ||
//                                 basicInfoControl.basicInfo!.aboutUs == null ||
//                                 basicInfoControl.basicInfo!.aboutUs!.isEmpty
//                                 ? ''
//                                 : basicInfoControl.basicInfo!.aboutUs!)
//                                 : aboutUs.text,
//                             maxLines: 4,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//
//                         ],
//                       )
//
//
//                     ],
//                   ),
//                 ),
//                 sizedBox16(),
//                 GestureDetector(
//                   behavior: HitTestBehavior.translucent,
//                   onTap: () {
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return NameEditDialogWidget(
//                           title: 'First Name',
//                           addTextField: TextFormField(
//                             maxLength: 40,
//                             onChanged: (v) {
//                               setState(() {});
//                             },
//                             onEditingComplete: () {
//                               Navigator.pop(context); // Close the dialog
//                             },
//                             controller: firstNameController,
//                             decoration: AppTFDecoration(hint: 'First Name')
//                                 .decoration(),
//                             //keyboardType: TextInputType.phone,
//                           ),
//                         );
//                       },
//                     );
//                   },
//                   child: buildDataAddRow(
//                     widget: const Icon(
//                       Icons.edit,
//                       size: 12,
//                     ),
//                     title: 'First Name',
//                     data1: firstNameController.text.isEmpty
//                         ? (Get.find<ProfileController>().userDetails == null ||
//                         Get.find<ProfileController>().userDetails!.data!.user!.firstname == null ||
//                         Get.find<ProfileController>().userDetails!.data!.user!.firstname!.isEmpty
//                         ? 'Not Added'
//                         : StringUtils.capitalize(Get.find<ProfileController>().userDetails!.data!.user!.firstname!))
//                         : firstNameController.text,
//                     data2: StringUtils.capitalize(firstNameController.text),
//                     isControllerTextEmpty: firstNameController.text.isEmpty,
//                   ),
//                 ),
//                 sizedBox16(),
//                 GestureDetector(
//                   behavior: HitTestBehavior.translucent,
//                   onTap: () {
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return NameEditDialogWidget(
//                           title: 'Last Name',
//                           addTextField: TextFormField(
//                             maxLength: 40,
//                             onChanged: (v) {
//                               setState(() {});
//                             },
//                             onEditingComplete: () {
//                               Navigator.pop(context);
//                             },
//                             controller: lastNameController,
//                             decoration: AppTFDecoration(hint: 'Last Name')
//                                 .decoration(),
//                             //keyboardType: TextInputType.phone,
//                           ),
//                         );
//                       },
//                     );
//                   },
//                   child: buildDataAddRow(
//                     widget: const Icon(
//                       Icons.edit,
//                       size: 12,
//                     ),
//                     title: 'Last Name',
//                     data1: lastNameController.text.isEmpty
//                         ? (Get.find<ProfileController>().userDetails == null ||
//                         Get.find<ProfileController>().userDetails!.data!.user!.lastname == null ||
//                         Get.find<ProfileController>().userDetails!.data!.user!.lastname!.isEmpty
//                         ? 'Not Added'
//                         : StringUtils.capitalize(Get.find<ProfileController>().userDetails!.data!.user!.lastname!!))
//                         : StringUtils.capitalize(lastNameController.text),
//                     data2: StringUtils.capitalize(lastNameController.text),
//                     isControllerTextEmpty: lastNameController.text.isEmpty,
//                   ),
//                 ),
//                 sizedBox16(),
//                 GestureDetector(
//                   behavior: HitTestBehavior.translucent,
//                   onTap: () {
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return NameEditDialogWidget(
//                           title: 'User Name',
//                           addTextField: TextFormField(
//                             maxLength: 40,
//                             onChanged: (v) {
//                               setState(() {});
//                             },
//                             onEditingComplete: () {
//                               Navigator.pop(context); // Close the dialog
//                             },
//                             controller: userNameController,
//                             decoration: AppTFDecoration(hint: 'User Name')
//                                 .decoration(),
//                             //keyboardType: TextInputType.phone,
//                           ),
//                         );
//                       },
//                     );
//                   },
//                   child: buildDataAddRow(
//                     widget: const Icon(
//                       Icons.edit,
//                       size: 12,
//                     ),
//                     title: 'User Name',
//                     data1: userNameController.text.isEmpty
//                         ? (Get.find<ProfileController>().userDetails == null ||
//                         Get.find<ProfileController>().userDetails!.data!.user!.username == null ||
//                         Get.find<ProfileController>().userDetails!.data!.user!.username!.isEmpty
//                         ? 'User Name'
//                         :  Get.find<ProfileController>().userDetails!.data!.user!.username!)
//                         : userNameController.text,
//                     data2: userNameController.text,
//                     isControllerTextEmpty: userNameController.text.isEmpty,
//                   ),
//                 ),
//                 sizedBox16(),
//                 GestureDetector(
//                   behavior: HitTestBehavior.translucent,
//                   onTap: () {},
//                   child: buildDataAddRow(
//                     widget: const SizedBox(),
//                     title: 'Email',
//                     data1: emailController.text.isEmpty
//                         ? (Get.find<ProfileController>().userDetails == null ||
//                         Get.find<ProfileController>().userDetails!.data!.user!.email == null ||
//                         Get.find<ProfileController>().userDetails!.data!.user!.email!.isEmpty
//                         ? 'Email'
//                         : Get.find<ProfileController>().userDetails!.data!.user!.email!)
//                         : emailController.text,
//                     data2: emailController.text,
//                     isControllerTextEmpty: emailController.text.isEmpty,
//                   ),
//                 ),
//                 sizedBox16(),
//                 GestureDetector(
//                   behavior: HitTestBehavior.translucent,
//                   onTap: () {
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return NameEditDialogWidget(
//                           title: 'Profession',
//                           addTextField: TextFormField(
//                             maxLength: 40,
//                             onChanged: (v) {
//                               setState(() {});
//                             },
//                             onEditingComplete: () {
//                               Navigator.pop(context); // Close the dialog
//                             },
//                             controller: professionController,
//                             decoration: AppTFDecoration(hint: 'Profession')
//                                 .decoration(),
//                             //keyboardType: TextInputType.phone,
//                           ),
//                         );
//                       },
//                     );
//                   },
//                   child: buildDataAddRow(
//                     widget: const Icon(
//                       Icons.edit,
//                       size: 12,
//                     ),
//                     title: 'Profession',
//                     data1: professionController.text.isEmpty
//                         ? (basicInfoControl.basicInfo?.id == null ||
//                         basicInfoControl.basicInfo?.profession == null ||
//                         basicInfoControl.basicInfo!.profession!.isEmpty
//                         ? 'Not Added'
//                         : basicInfoControl.basicInfo!.profession!)
//                         : professionController.text,
//                     data2:
//                     StringUtils.capitalize(professionController.text),
//                     isControllerTextEmpty:
//                     professionController.text.isEmpty,
//                   ),
//                   // child: CarRowWidget(favourites: favourites!,)
//                 ),
//                 sizedBox16(),
//                 GestureDetector(
//                   behavior: HitTestBehavior.translucent,
//                   onTap: () {},
//                   child: buildDataAddRow(
//                     widget: const SizedBox(),
//                     title: 'Gender',
//                     data1: genderController.text.isEmpty
//                         ? (basicInfoControl.basicInfo?.id == null ||
//                         basicInfoControl.basicInfo?.gender == null ||
//                         basicInfoControl.basicInfo!.gender!.isEmpty
//                         ? 'Not Added'
//                         : basicInfoControl.basicInfo!.gender.toString())
//                         : genderController.text,
//                     data2: StringUtils.capitalize(genderController.text.contains("F") ? "Female" :"Male"),
//                     isControllerTextEmpty: genderController.text.isEmpty,
//                   ),
//                   // child: CarRowWidget(favourites: favourites!,)
//                 ),
//                 sizedBox16(),
//                 GestureDetector(
//                   behavior: HitTestBehavior.translucent,
//                   onTap: () {},
//                   child: buildDataAddRow(
//                     widget: const SizedBox(),
//                     title: 'Religion',
//                     data1: religionController.text.isEmpty
//                         ? (basicInfoControl.basicInfo?.id == null ||
//                         basicInfoControl.basicInfo?.religion == null ||
//                         basicInfoControl.basicInfo!.religion!.isEmpty
//                         ? 'Not Added'
//                         : basicInfoControl.basicInfo!.religion.toString())
//                         : religionController.text,
//                     data2: religionController.text,
//                     isControllerTextEmpty: religionController.text.isEmpty,
//                   ),
//                   // child: CarRowWidget(favourites: favourites!,)
//                 ),
//                 sizedBox16(),
//                 GestureDetector(
//                   behavior: HitTestBehavior.translucent,
//                   onTap: () {},
//                   child: buildDataAddRow(
//                     widget: const SizedBox(),
//                     title: 'Married Status',
//                     data1: marriedStatusController.text.isEmpty
//                         ? (basicInfoControl.basicInfo?.id == null ||
//                         basicInfoControl.basicInfo?.maritalStatus == null ||
//                         basicInfoControl.basicInfo!.maritalStatus!.isEmpty
//                         ? 'Not Added'
//                         : basicInfoControl.basicInfo!.maritalStatus.toString())
//                         : marriedStatusController.text,
//                     data2: StringUtils.capitalize(
//                         marriedStatusController.text),
//                     isControllerTextEmpty:
//                     marriedStatusController.text.isEmpty,
//                   ),
//                 ),
//                 sizedBox16(),
//                 GestureDetector(
//                   behavior: HitTestBehavior.translucent,
//                   onTap: () {
//                     showModalBottomSheet(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return PrivacyStatusBottomSheet(
//                           privacyStatus: '',
//                           onPop: (val) {
//                             smokingController.text = val;
//                             print(smokingController.text);
//                           },
//                         );
//                       },
//                     );
//                   },
//                   child: buildDataAddRow(
//                     title: 'Smoking status',
//                     widget: const Icon(
//                       Icons.edit,
//                       size: 12,
//                     ),
//                     data1: smokingController.text.isEmpty
//                         ? (basicInfoControl.basicInfo?.id == null ||
//                         basicInfoControl.basicInfo?.smokingStatus == null
//                         ? 'Not Added'
//                         : basicInfoControl.basicInfo!.smokingStatus.toString())
//                         : smokingController.text,
//                     data2: smokingController.text.contains('1') ? "Yes" :"No",
//                     isControllerTextEmpty: smokingController.text.isEmpty,
//                   ),
//                 ),
//                 sizedBox16(),
//                 GestureDetector(
//                   behavior: HitTestBehavior.translucent,
//                   onTap: () {
//                     showModalBottomSheet(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return DrinkingStatusBottomSheet(
//                           privacyStatus: '',
//                           onPop: (val) {
//                             drinkingController.text = val;
//                             // print(smokingController.text);
//                           },
//                         );
//                       },
//                     );
//                   },
//                   child: buildDataAddRow(
//                     title: 'Drinking status',
//                     widget: const Icon(
//                       Icons.edit,
//                       size: 12,
//                     ),
//                     data1: drinkingController.text.isEmpty
//                         ? (basicInfoControl.basicInfo?.id == null ||
//                         basicInfoControl.basicInfo?.drinkingStatus == null
//                         ? 'Not Added'
//                         : basicInfoControl.basicInfo!.drinkingStatus.toString())
//                         : drinkingController.text,
//                     data2: drinkingController.text.contains("1") ? "Yes" :"No",
//                     isControllerTextEmpty: drinkingController.text.isEmpty,
//                   ),
//                   // child: CarRowWidget(drinkingController)
//                 ),
//                 sizedBox16(),
//                 GestureDetector(
//                   behavior: HitTestBehavior.translucent,
//                   onTap: () {},
//                   child: buildDataAddRow(
//                     widget: const SizedBox(),
//                     title: 'Birth date',
//                     data1: birthDateController.text.isEmpty
//                         ? (basicInfoControl.basicInfo?.id == null ||
//                         basicInfoControl.basicInfo?.birthDate == null
//                         ? 'Not Added'
//                         : basicInfoControl.basicInfo!.birthDate.toString())
//                         : birthDateController.text,
//                     data2: birthDateController.text,
//                     isControllerTextEmpty: birthDateController.text.isEmpty,
//                   ),
//                 ),
//                 sizedBox16(),
//                 GestureDetector(
//                   behavior: HitTestBehavior.translucent,
//                   onTap: () {
//                     showModalBottomSheet(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return CommuitySheet(
//                           privacyStatus: '',
//                           onPop: (val) {
//                             communityController.text = val;
//                             print(communityController.text);
//                           },
//                         );
//                       },
//                     );
//                   },
//                   child: buildDataAddRow(
//                     title: 'Community',
//                     widget: const Icon(
//                       Icons.edit,
//                       size: 12,
//                     ),
//                     data1: communityController.text.isEmpty
//                         ? (basicInfoControl.basicInfo?.id == null ||
//                         basicInfoControl.basicInfo?.community == null
//                         ? 'Not Added'
//                         : basicInfoControl.basicInfo!.community.toString())
//                         : communityController.text,
//                     data2: communityController.text,
//                     isControllerTextEmpty: communityController.text.isEmpty,
//                   ),
//                 ),
//
//                 sizedBox16(),
//                 GestureDetector(
//                   behavior: HitTestBehavior.translucent,
//                   onTap: () {
//                     showModalBottomSheet(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return FinancialBottomSheet(
//                           privacyStatus: '',
//                           onPop: (val) {
//                             financialCondition.text = val;
//                             print(financialCondition.text);
//                           },
//                         );
//                       },
//                     );
//                   },
//                   child: buildDataAddRow(
//                     title: 'Financial Condition',
//                     widget: const Icon(
//                       Icons.edit,
//                       size: 12,
//                     ),
//                     data1: financialCondition.text.isEmpty
//                         ? (basicInfoControl.basicInfo?.id == null ||
//                         basicInfoControl.basicInfo?.financialCondition == null
//                         ? 'Not Added'
//                         : basicInfoControl.basicInfo!.financialCondition.toString())
//                         : financialCondition.text,
//                     data2: financialCondition.text,
//                     isControllerTextEmpty: financialCondition.text.isEmpty,
//                   ),
//                 ),
//
//                 sizedBox16(),
//                 GestureDetector(
//                   behavior: HitTestBehavior.translucent,
//                   onTap: () {},
//                   child: buildDataAddRow(
//                     title: 'Mother Tongue',
//                     widget: SizedBox(),
//                     data1: motherTongueController.text.isEmpty
//                         ? (basicInfoControl.basicInfo?.id == null ||
//                         basicInfoControl.basicInfo?.motherTongue == null ||
//                         basicInfoControl.basicInfo!.motherTongue!.isEmpty
//                         ? 'Not Added'
//                         : basicInfoControl.basicInfo!.motherTongue.toString())
//                         : motherTongueController.text,
//                     data2:
//                     StringUtils.capitalize(motherTongueController.text),
//                     isControllerTextEmpty:
//                     motherTongueController.text.isEmpty,
//                   ),
//                 ),
//                 sizedBox16(),
//                 GestureDetector(
//                   behavior: HitTestBehavior.translucent,
//                   onTap: () {
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return NameEditDialogWidget(
//                           title: 'City',
//                           addTextField: TextFormField(
//                             maxLength: 40,
//                             onChanged: (v) {
//                               setState(() {});
//                             },
//                             onEditingComplete: () {
//                               Navigator.pop(context); // Close the dialog
//                             },
//                             controller: cityController,
//                             decoration:
//                             AppTFDecoration(hint: 'City').decoration(),
//                             //keyboardType: TextInputType.phone,
//                           ),
//                         );
//                       },
//                     );
//                   },
//                   child: buildDataAddRow(
//                     widget: Icon(
//                       Icons.edit,
//                       size: 12,
//                     ),
//                     title: 'City',
//                     data1: cityController.text.isEmpty
//                         ? (basicInfoControl.basicInfo?.presentAddress?.city == null
//                         ? 'City'
//                         : basicInfoControl.basicInfo!.presentAddress!.city!)
//                         : cityController.text,
//                     data2: StringUtils.capitalize(cityController.text),
//                     isControllerTextEmpty: cityController.text.isEmpty,
//                   ),
//                   // child: CarRowWidget(favourites: favourites!,)
//                 ),
//                 sizedBox16(),
//                 GestureDetector(
//                   behavior: HitTestBehavior.translucent,
//                   onTap: () {
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return NameEditDialogWidget(
//                           title: 'State',
//                           addTextField: TextFormField(
//                             maxLength: 40,
//                             onChanged: (v) {
//                               setState(() {});
//                             },
//                             onEditingComplete: () {
//                               Navigator.pop(context); // Close the dialog
//                             },
//                             controller: stateController,
//                             decoration:
//                             AppTFDecoration(hint: 'State').decoration(),
//                             //keyboardType: TextInputType.phone,
//                           ),
//                         );
//                       },
//                     );
//                   },
//                   child: buildDataAddRow(
//                     widget: Icon(
//                       Icons.edit,
//                       size: 12,
//                     ),
//                     title: 'State',
//                     data1: stateController.text.isEmpty
//                         ? (basicInfoControl.basicInfo?.presentAddress == null ||
//                         basicInfoControl.basicInfo?.presentAddress?.state == null
//                         ? 'State'
//                         : basicInfoControl.basicInfo!.presentAddress!.state!)
//                         : stateController.text,
//                     data2: StringUtils.capitalize(stateController.text),
//                     isControllerTextEmpty: stateController.text.isEmpty,
//                   ),
//                   // child: CarRowWidget(favourites: favourites!,)
//                 ),
//                 sizedBox16(),
//                 GestureDetector(
//                   behavior: HitTestBehavior.translucent,
//                   onTap: () {
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return NameEditDialogWidget(
//                           title: 'Zip Code',
//                           addTextField: TextFormField(
//                             keyboardType: TextInputType.number,
//                             maxLength: 40,
//                             onChanged: (v) {
//                               setState(() {});
//                             },
//                             onEditingComplete: () {
//                               Navigator.pop(context); // Close the dialog
//                             },
//                             controller: zipController,
//                             decoration: AppTFDecoration(hint: 'Zip Code')
//                                 .decoration(),
//                             //keyboardType: TextInputType.phone,
//                           ),
//                         );
//                       },
//                     );
//                   },
//                   child: buildDataAddRow(
//                     widget: Icon(
//                       Icons.edit,
//                       size: 12,
//                     ),
//                     title: 'Zip Code',
//                     data1: zipController.text.isEmpty
//                         ? (basicInfoControl.basicInfo?.presentAddress == null ||
//                         basicInfoControl.basicInfo?.presentAddress!.zip == null
//                         ? 'Zip Code'
//                         : basicInfoControl.basicInfo!.presentAddress!.zip!)
//                         : zipController.text,
//                     data2: zipController.text,
//                     isControllerTextEmpty: zipController.text.isEmpty,
//                   ),
//
//                   // chil
//                   // d: CarRowWidget(favourites: favourites!,)
//                 ),
//                 sizedBox16(),
//                 GestureDetector(
//                   behavior: HitTestBehavior.translucent,
//                   onTap: () {
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return NameEditDialogWidget(
//                           title: 'Country',
//                           addTextField: TextFormField(
//                             maxLength: 40,
//                             onChanged: (v) {
//                               setState(() {});
//                             },
//                             onEditingComplete: () {
//                               Navigator.pop(context); // Close the dialog
//                             },
//                             controller: countryController,
//                             decoration: AppTFDecoration(hint: 'Country')
//                                 .decoration(),
//                             //keyboardType: TextInputType.phone,
//                           ),
//                         );
//                       },
//                     );
//                   },
//                   child: buildDataAddRow(
//                     widget: Icon(
//                       Icons.edit,
//                       size: 12,
//                     ),
//                     title: 'Country',
//                     data1: countryController.text.isEmpty
//                         ? (basicInfoControl.basicInfo?.presentAddress == null ||
//                         basicInfoControl.basicInfo?.presentAddress?.country == null
//                         ? 'Country'
//                         : basicInfoControl.basicInfo!.presentAddress!.country!)
//                         : countryController.text,
//                     data2: countryController.text,
//                     isControllerTextEmpty: countryController.text.isEmpty,
//                   ),
//                   // child: CarRowWidget(favourites: favourites!,)
//                 ),
//               ],
//             ),
//           ),
//         );
//       }),
//
//
//     );
//   }
//
//   Padding buildBottombarPadding(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: SingleChildScrollView(
//         child: loading
//             ? loadingButton(context: context)
//             : button(
//                 context: context,
//                 onTap: () {
//                   setState(() {
//                     loading = true;
//                   });
//                   updateBasicInfo(
//                           profession: professionController.text,
//                           religion: religionController.text,
//                           motherTongue: motherTongueController.text,
//                           community: communityController.text,
//                           smokingStatus: smokingController.text,
//                           drinkingStatus: drinkingController.text,
//                           maritalStatus: marriedStatusController.text,
//                           birthDate: birthDateController.text,
//                           state: stateController.text,
//                           zip: zipController.text,
//                           city: cityController.text,
//                           country: countryController.text,
//                           gender: genderController.text,
//                           financialCondition: financialCondition.text,
//                           firstName: firstNameController.text,
//                           lastName: lastNameController.text,
//                       aboutUs: aboutUs.text)
//                       .then((value) {
//                     setState(() {});
//                     if (value['status'] == true) {
//                       setState(() {
//                         loading = false;
//                       });
//                       Navigator.pop(context);
//                       dynamic message = value['message']['original']['message'];
//                       List<String> errors = [];
//
//                       if (message != null && message is Map) {
//                         message.forEach((key, value) {
//                           errors.addAll(value);
//                         });
//                       }
//
//                       String errorMessage = errors.isNotEmpty
//                           ? errors.join(", ")
//                           : "Update succesfully.";
//                       Fluttertoast.showToast(msg: errorMessage);
//                     } else {
//                       setState(() {
//                         loading = false;
//                       });
//                       List<dynamic> errors =
//                           value['message']['original']['message'];
//                       String errorMessage = errors.isNotEmpty
//                           ? errors[0]
//                           : "An unknown error occurred.";
//                       Fluttertoast.showToast(msg: errorMessage);
//                     }
//                   });
//                 },
//                 title: "Save"),
//       ),
//     );
//   }
//
//   Row buildDataAddRow({
//     required String title,
//     required String data1,
//     required String data2,
//     required bool isControllerTextEmpty,
//     required Widget widget,
//   }) {
//     return Row(
//       children: [
//         Expanded(
//           child: Row(
//             children: [
//               Text(
//                 title, style: styleSatoshiRegular(size: 14, color: color5E5E5E),
//               ),
//               const SizedBox(
//                 width: 3,
//               ),
//               widget,
//             ],
//           ),
//         ),
//         isControllerTextEmpty
//             ? Expanded(
//                 // flex: 3,
//                 child: SizedBox(
//                   width: 180,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Text(
//                             data1,
//                             maxLines: 4,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           const SizedBox(
//                             width: 2,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             : Expanded(
//                 child: SizedBox(
//                   width: 180,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         data2,
//                         maxLines: 4,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//       ],
//     );
//   }
//
// }
//
// class PrivacyStatusBottomSheet extends StatefulWidget {
//   final String privacyStatus;
//   final Function(String) onPop;
//
//   const PrivacyStatusBottomSheet(
//       {Key? key, required this.privacyStatus, required this.onPop})
//       : super(key: key);
//
//   @override
//   State<PrivacyStatusBottomSheet> createState() => _PrivacyStatusBottomSheet();
// }
//
// class _PrivacyStatusBottomSheet extends State<PrivacyStatusBottomSheet> {
//   int _gIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Material(
//         child: Container(
//           width: double.infinity,
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   "Select Smoking Status",
//                   style: styleSatoshiMedium(size: 16, color: Colors.black),
//                 ),
//                 sizedBox16(),
//                 GestureDetector(
//                   onTap: () => setState(() {
//                     _gIndex = 0;
//                     Navigator.of(context).pop();
//                     widget.onPop("1");
//                   }),
//                   child: Container(
//                     height: 44,
//                     width: 78,
//                     decoration: BoxDecoration(
//                       borderRadius: const BorderRadius.all(Radius.circular(5)),
//                       color: _gIndex == 0 ? primaryColor : Colors.transparent,
//                     ),
//                     child: Center(
//                         child: Text(
//                       'Yes',
//                       style: styleSatoshiLight(
//                           size: 14,
//                           color: _gIndex == 0 ? Colors.white : Colors.black),
//                       // style: _gIndex == 0
//                       //     ? textColorF7E64114w400
//                       //     : ColorSelect.colorF7E641
//                     )),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 8,
//                 ),
//                 GestureDetector(
//                   onTap: () => setState(() {
//                     _gIndex = 1;
//                     Navigator.of(context).pop();
//                     widget.onPop("0");
//                   }),
//                   child: Container(
//                     height: 44,
//                     width: 78,
//                     decoration: BoxDecoration(
//                       borderRadius: const BorderRadius.all(Radius.circular(5)),
//                       color: _gIndex == 1 ? primaryColor : Colors.transparent,
//                     ),
//                     child: Center(
//                         child: Text(
//                       'No',
//                       style: styleSatoshiLight(
//                           size: 14,
//                           color: _gIndex == 1 ? Colors.white : Colors.black),
//                       // style
//                       // : _gIndex == 1
//                       //     ? kManRope_500_16_white
//                       //     : kManRope_500_16_626A6A,
//                     )),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     if (widget.privacyStatus == "1") {
//       _gIndex = 0;
//     } else if (widget.privacyStatus == "0") {
//       _gIndex = 1;
//     }
//     super.initState();
//   }
// }
//
// class DrinkingStatusBottomSheet extends StatefulWidget {
//   final String privacyStatus;
//   final Function(String) onPop;
//
//   const DrinkingStatusBottomSheet(
//       {Key? key, required this.privacyStatus, required this.onPop})
//       : super(key: key);
//
//   @override
//   State<DrinkingStatusBottomSheet> createState() =>
//       _DrinkingStatusBottomSheet();
// }
//
// class _DrinkingStatusBottomSheet extends State<DrinkingStatusBottomSheet> {
//   int _gIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Material(
//         child: Container(
//           width: double.infinity,
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   "Select Drinking Status",
//                   style: styleSatoshiMedium(size: 16, color: Colors.black),
//                 ),
//                 sizedBox16(),
//                 GestureDetector(
//                   onTap: () => setState(() {
//                     _gIndex = 0;
//                     Navigator.of(context).pop();
//                     widget.onPop("1");
//                   }),
//                   child: Container(
//                     height: 44,
//                     width: 78,
//                     decoration: BoxDecoration(
//                       borderRadius: const BorderRadius.all(Radius.circular(5)),
//                       color: _gIndex == 0 ? primaryColor : Colors.transparent,
//                     ),
//                     child: Center(
//                         child: Text(
//                       'Yes',
//                       style: styleSatoshiLight(
//                           size: 14,
//                           color: _gIndex == 0 ? Colors.white : Colors.black),
//                       // style: _gIndex == 0
//                       //     ? textColorF7E64114w400
//                       //     : ColorSelect.colorF7E641
//                     )),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 8,
//                 ),
//                 GestureDetector(
//                   onTap: () => setState(() {
//                     _gIndex = 1;
//                     Navigator.of(context).pop();
//                     widget.onPop("0");
//                   }),
//                   child: Container(
//                     height: 44,
//                     width: 78,
//                     decoration: BoxDecoration(
//                       borderRadius: const BorderRadius.all(Radius.circular(5)),
//                       color: _gIndex == 1 ? primaryColor : Colors.transparent,
//                     ),
//                     child: Center(
//                         child: Text(
//                       'No',
//                       style: styleSatoshiLight(
//                           size: 14,
//                           color: _gIndex == 1 ? Colors.white : Colors.black),
//                       // style
//                       // : _gIndex == 1
//                       //     ? kManRope_500_16_white
//                       //     : kManRope_500_16_626A6A,
//                     )),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     if (widget.privacyStatus == "1") {
//       _gIndex = 0;
//     } else if (widget.privacyStatus == "0") {
//       _gIndex = 1;
//     }
//     super.initState();
//   }
// }
//
//
//
// class BasicInfoShimmerWidget extends StatelessWidget {
//   const BasicInfoShimmerWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding:
//       const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
//       child: Shimmer.fromColors(
//         baseColor: Colors.grey.shade300,
//         highlightColor: Colors.grey.shade100,
//         enabled: true,
//         child: Column(
//           children: [
//             Container(
//               height: 104,
//               width: 104,
//               clipBehavior: Clip.hardEdge,
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//
//                 shape: BoxShape.circle,
//               ),
//
//             ),
//             sizedBox16(),
//             Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     height: 15,
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16)
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 120,),
//
//                 Expanded(
//                   child: Container(
//                     height: 15,
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16)
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             sizedBox16(),
//
//             sizedBox16(),
//             Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     height: 15,
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16)
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 120,),
//
//                 Expanded(
//                   child: Container(
//                     height: 15,
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16)
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             sizedBox16(),
//
//             sizedBox16(),
//             Container(
//               height: 20,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16)
//               ),
//             ),
//             sizedBox16(),
//
//             sizedBox16(),
//             Container(
//               height: 20,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16)
//               ),
//             ),
//             sizedBox16(),
//
//             sizedBox16(),
//             Container(
//               height: 20,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16)
//               ),
//             ),
//             sizedBox16(),
//
//             sizedBox16(),
//             Container(
//               height: 20,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16)
//               ),
//             ),
//             sizedBox16(),
//
//             sizedBox16(),
//             Container(
//               height: 20,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16)
//               ),
//             ),
//             sizedBox16(),
//
//             sizedBox16(),
//             Container(
//               height: 20,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16)
//               ),
//             ),
//             sizedBox16(),
//
//             sizedBox16(),
//             Container(
//               height: 20,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16)
//               ),
//             ),
//             sizedBox16(),
//
//             sizedBox16(),
//             Container(
//               height: 20,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16)
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

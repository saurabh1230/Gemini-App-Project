import 'package:bureau_couple/controllers/profile_controller.dart';
import 'package:bureau_couple/features/views/proflle/basic_info_screen.dart';
import 'package:bureau_couple/src/constants/sizedboxe.dart';
import 'package:bureau_couple/src/utils/widgets/buttons.dart';
import 'package:bureau_couple/src/utils/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';
import '../../../src/apis/partner_expectation_api.dart';
import '../../../src/apis/profile_apis/get_profile_api.dart';
import '../../../src/apis/profile_apis/physical_attributes_api.dart';
import '../../../src/constants/assets.dart';
import '../../../src/constants/colors.dart';
import '../../../src/constants/string.dart';
import '../../../src/constants/textstyles.dart';
import '../../../src/models/attributes_model.dart';
import '../../../src/models/preference_model.dart';
import '../../../src/utils/widgets/common_widgets.dart';
import '../../../src/utils/widgets/customAppbar.dart';
import '../../../src/utils/widgets/name_edit_dialog.dart';
import '../../../src/utils/widgets/textfield_decoration.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../src/views/home/profile/edit_basic_info.dart';
class EditPreferenceScreen extends StatefulWidget {
  const EditPreferenceScreen({super.key});

  @override
  State<EditPreferenceScreen> createState() => _EditPreferenceScreenState();
}

class _EditPreferenceScreenState extends State<EditPreferenceScreen> {
  final generalInfo = TextEditingController();
  final countryController = TextEditingController();
  final heightController = TextEditingController();
  final maxHeightController = TextEditingController();
  final weightController = TextEditingController();
  final preferredReligionController = TextEditingController();
  final minAgeController = TextEditingController();
  final maxAgeController = TextEditingController();
  final preferredProfession = TextEditingController();
  final financialCondition = TextEditingController();
  final motherTongueController = TextEditingController();
  final communityController = TextEditingController();
  final minimumDegreeController = TextEditingController();
  final smokingController = TextEditingController();
  final drinkingController = TextEditingController();
  final languageController = TextEditingController();

  bool loading = false;
  bool isLoading = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ProfileController>().getPreferenceInfoApi();
      // fields();
    });
    super.initState();
  }


  // PreferenceModel preferenceModel = PreferenceModel();
  //
  // careerInfo() {
  //   isLoading = true;
  //   var resp = getProfileApi();
  //   resp.then((value) {
  //     // physicalData.clear();
  //     if (value['status'] == true) {
  //       setState(() {
  //         var physicalAttributesData = value['data']['user']['partner_expectation'];
  //         if (physicalAttributesData != null) {
  //           setState(() {
  //             preferenceModel = PreferenceModel.fromJson(physicalAttributesData);
  //             fields();
  //           });
  //         }
  //         // print(career.length);
  //         isLoading = false;
  //       });
  //     } else {
  //       setState(() {
  //         isLoading = false;
  //       });
  //     }
  //   });
  // }

  void fields() {
   generalInfo.text = Get.find<ProfileController>().preferenceModel!.generalRequirement.toString() ?? '';
   countryController.text= Get.find<ProfileController>().preferenceModel!.country.toString() ?? '';
    minAgeController.text= Get.find<ProfileController>().preferenceModel!.minAge.toString() ?? '';
     maxAgeController.text= Get.find<ProfileController>().preferenceModel!.maxAge.toString() ?? '';
     heightController.text= Get.find<ProfileController>().preferenceModel!.minHeight.toString() ?? '';
   maxHeightController.text= Get.find<ProfileController>().preferenceModel!.max_height.toString() ?? '';
   weightController.text= Get.find<ProfileController>().preferenceModel!.maxWeight.toString() ?? '';
    preferredReligionController.text= Get.find<ProfileController>().preferenceModel!.religion.toString() ?? '';
    communityController.text= Get.find<ProfileController>().preferenceModel!.community.toString() ?? '';
    smokingController.text= Get.find<ProfileController>().preferenceModel!.smokingStatus.toString() ?? '';
   drinkingController.text= Get.find<ProfileController>().preferenceModel!.drinkingStatus.toString() ?? '';
     preferredProfession.text= Get.find<ProfileController>().preferenceModel!.profession.toString() ?? '';
    minimumDegreeController.text= Get.find<ProfileController>().preferenceModel!.minDegree.toString() ?? '';
    financialCondition.text= Get.find<ProfileController>().preferenceModel!.financialCondition.toString() ?? '';
    languageController.text= Get.find<ProfileController>().preferenceModel!.language.toString() ?? '';



  }

  DateTime _selectedTime = DateTime.now();
  String time = "-";

  int _feet = 5;
  int _inches = 0;

  int _feet2 = 5;
  int _inches2 = 0;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Partner Expectation",),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child:
          loading ?
          loadingButton(context: context) :button(context: context, onTap: () {
            setState(() {
              loading = true;
            });
            partnerExpectationUpdateApi(
                generalRequirement: generalInfo.text,
                country: countryController.text,
                minAge: minAgeController.text,
                maxAge: maxAgeController.text,
                minHeight: heightController.text,
                maxWeight: weightController.text,
                religion: preferredReligionController.text,
                community:communityController.text,
                smokingStatus: smokingController.text,
                drinkingStatus: drinkingController.text,
                profession: preferredProfession.text,
                minDegree: minimumDegreeController.text,
                financialCondition: financialCondition.text,
                language: languageController.text,
                maxHeight: maxHeightController.text).then((value) {
              setState(() {
              });
              if (value['status'] == true) {
                setState(() {
                  loading = false;
                });
                Navigator.pop(context);
                dynamic message = value['message']['original']['message'];
                List<String> errors = [];

                if (message != null && message is Map) {
                  // If the message is not null and is a Map, extract the error messages
                  message.forEach((key, value) {
                    errors.addAll(value);
                  });
                }

                String errorMessage = errors.isNotEmpty ? errors.join(", ") : "Update succesfully.";
                Fluttertoast.showToast(msg: errorMessage);

              } else {
                setState(() {
                  loading = false;
                });
                Fluttertoast.showToast(msg: "Add All Details");
              }
            });
          },  title: "Save"),
        ),
      ),
      body: isLoading ? const AttributesShimmerWidget() : CustomRefreshIndicator(
        onRefresh: () {
          setState(() {
            isLoading = true;
          });
          // return careerInfo();
        },
        child:  GetBuilder<ProfileController>(builder: (preferenceControl) {
          return SingleChildScrollView(

            physics: const  AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Partner Expectations",style:styleSatoshiMedium(size: 16, color: primaryColor)),
                  sizedBox16(),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return NameEditDialogWidget(
                            title: 'General Introduction',
                            addTextField: TextFormField(
                              maxLength: 200,
                              onChanged: (v) {
                                setState(() {});
                              },
                              onEditingComplete: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              controller: generalInfo,
                              decoration: AppTFDecoration(hint: 'General Introduction')
                                  .decoration(),
                              //keyboardType: TextInputType.phone,
                            ),
                          );
                        },
                      );

                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "General Information",style: styleSatoshiRegular(size: 14, color: color5E5E5E),
                            ),
                            SizedBox(width: 3,),
                            Icon(
                              Icons.edit,
                              size: 12,
                            ),
                          ],
                        ),
                        generalInfo.text.isEmpty?
                        SizedBox() :
                        Column(
                          children: [
                            sizedBox16(),

                            Text(
                              generalInfo.text.isEmpty
                                  ? (preferenceControl.preferenceModel!.id == null ||
                                  preferenceControl.preferenceModel!.generalRequirement == null ||
                                  preferenceControl.preferenceModel!.generalRequirement!.isEmpty
                                  ? ''
                                  : preferenceControl.preferenceModel!.generalRequirement!)
                                  : generalInfo.text,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),

                          ],
                        )


                      ],
                    ),
                  ),

                  sizedBox16(),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return NameEditDialogWidget(
                            title: 'Country',
                            addTextField: TextFormField(
                              maxLength: 40,
                              onChanged: (v) {
                                setState(() {
                                });
                              },
                              onEditingComplete: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              controller: countryController,
                              decoration: AppTFDecoration(
                                  hint: 'Country').decoration(),
                              //keyboardType: TextInputType.phone,
                            ),
                          );
                        },
                      );
                    },
                    child: buildDataAddRow(title: 'Country',
                      data1: countryController.text.isEmpty
                          ? (preferenceControl.preferenceModel!.id == null || preferenceControl.preferenceModel!.country == null || preferenceControl.preferenceModel!.country!.isEmpty
                          ? 'Not Added'
                          : preferenceControl.preferenceModel!.country!)
                          : countryController.text,
                      data2: StringUtils.capitalize(countryController.text),
                      isControllerTextEmpty: countryController.text.isEmpty, widget: SizedBox(),),
                  ),
                  sizedBox16(),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return NameEditDialogWidget(
                            title: 'Min Age',
                            addTextField: TextFormField(
                              maxLength: 40,
                              onChanged: (v) {
                                setState(() {
                                });
                              },
                              onEditingComplete: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              controller: minAgeController,
                              decoration: AppTFDecoration(
                                  hint: 'Min Age').decoration(),
                              //keyboardType: TextInputType.phone,
                            ),
                          );
                        },
                      );
                    },
                    child: buildDataAddRow(title: 'Min Age',
                      data1: minAgeController.text.isEmpty
                          ? (preferenceControl.preferenceModel!.id == null || preferenceControl.preferenceModel!.minAge == null
                          ? 'Not Added'
                          : preferenceControl.preferenceModel!.minAge.toString())
                          : minAgeController.text,
                      data2: StringUtils.capitalize(minAgeController.text),
                      isControllerTextEmpty: minAgeController.text.isEmpty, widget: SizedBox(),),
                  ),
                  sizedBox16(),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return NameEditDialogWidget(
                            title: 'Max Age',
                            addTextField: TextFormField(
                              maxLength: 40,
                              onChanged: (v) {
                                setState(() {
                                });
                              },
                              onEditingComplete: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              controller: maxAgeController,
                              decoration: AppTFDecoration(
                                  hint: 'Max Age').decoration(),
                              //keyboardType: TextInputType.phone,
                            ),
                          );
                        },
                      );
                    },
                    child: buildDataAddRow(title: 'Max Age',
                      data1: maxAgeController.text.isEmpty
                          ? (preferenceControl.preferenceModel!.id == null || preferenceControl.preferenceModel!.maxAge == null
                          ? 'Not Added'
                          : preferenceControl.preferenceModel!.maxAge.toString())
                          : maxAgeController.text,
                      data2: StringUtils.capitalize(maxAgeController.text),
                      isControllerTextEmpty: maxAgeController.text.isEmpty, widget: SizedBox(),),
                  ),

                  sizedBox16(),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext builder) {

                          // Create the modal bottom sheet widget containing the time picker and close button
                          return SizedBox(
                            height: MediaQuery.of(context).copyWith().size.height / 3,
                            child: Column(
                              children: [

                                WillPopScope(
                                  onWillPop: () async {

                                    return false;
                                  },
                                  child: SizedBox(
                                    height:200,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: CupertinoPicker(
                                            scrollController: FixedExtentScrollController(
                                              initialItem: _feet - 5,
                                            ),
                                            itemExtent: 32,
                                            onSelectedItemChanged: (index) {
                                              setState(() {
                                                _feet = index + 5;
                                              });
                                            },
                                            children: List.generate(
                                              7, // 7 feet in the range from 5 to 11
                                                  (index) => Center(child: Text('${index + 5}\'')),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: CupertinoPicker(
                                            scrollController: FixedExtentScrollController(
                                              initialItem: _inches,
                                            ),
                                            itemExtent: 32,
                                            onSelectedItemChanged: (index) {
                                              setState(() {
                                                _inches = index;
                                              });
                                              print(' $_feet-${_inches.toString().padLeft(2, '0')}');
                                            },
                                            children: List.generate(
                                              12, // 12 inches in a foot
                                                  (index) => Center(child: Text('$index\"')),
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),



                                // Close button
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                    Flexible(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.redAccent, // Change the background color to red
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child:  Text('Close',
                                          style: styleSatoshiMedium(
                                              size: 13,
                                              color: Colors.white),),
                                      ),
                                    ),
                                    SizedBox(width: 8,),
                                    Flexible(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            heightController.text = '$_feet.${_inches.toString().padLeft(1, '0')}';

                                            print('$_feet.${_inches.toString().padLeft(1, '0')}');
                                          });
                                          Navigator.pop(context);
                                        },
                                        child:  Text('Save',
                                          style: styleSatoshiMedium(
                                              size: 13,
                                              color: Colors.black),),
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          );
                        },
                      );

                    },
                    child: buildDataAddRow(title: 'Min Height ',
                        data1: heightController.text.isEmpty
                            ? (preferenceControl.preferenceModel!.id == null || preferenceControl.preferenceModel!.minHeight == null || preferenceControl.preferenceModel!.minHeight!.isEmpty
                            ? 'Not Added'
                            : preferenceControl.preferenceModel!.minHeight.toString())
                            : heightController.text,
                        data2: heightController.text,
                        isControllerTextEmpty: heightController.text.isEmpty, widget: SizedBox()),
                    // child: CarRowWidget(favourites: favourites!,)
                  ),
                  sizedBox16(),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext builder) {

                          // Create the modal bottom sheet widget containing the time picker and close button
                          return SizedBox(
                            height: MediaQuery.of(context).copyWith().size.height / 3,
                            child: Column(
                              children: [

                                WillPopScope(
                                  onWillPop: () async {

                                    return false;
                                  },
                                  child: SizedBox(
                                    height:200,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: CupertinoPicker(
                                            scrollController: FixedExtentScrollController(
                                              initialItem: _feet2 - 5,
                                            ),
                                            itemExtent: 32,
                                            onSelectedItemChanged: (index) {
                                              setState(() {
                                                _feet2 = index + 5;
                                              });
                                            },
                                            children: List.generate(
                                              7, // 7 feet in the range from 5 to 11
                                                  (index) => Center(child: Text('${index + 5}\'')),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: CupertinoPicker(
                                            scrollController: FixedExtentScrollController(
                                              initialItem: _inches2,
                                            ),
                                            itemExtent: 32,
                                            onSelectedItemChanged: (index) {
                                              setState(() {
                                                _inches2 = index;
                                              });
                                              print(' $_feet2-${_inches2.toString().padLeft(2, '0')}');
                                            },
                                            children: List.generate(
                                              12, // 12 inches in a foot
                                                  (index) => Center(child: Text('$index\"')),
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                    Flexible(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.redAccent, // Change the background color to red
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child:  Text('Close',
                                          style: styleSatoshiMedium(
                                              size: 13,
                                              color: Colors.white),),
                                      ),
                                    ),
                                    SizedBox(width: 8,),
                                    Flexible(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            maxHeightController.text = '$_feet2.${_inches2.toString().padLeft(1, '0')}';
                                            // maxHeightController.text = '$_feet2-${_inches2.toString()}';
                                            print('$_feet2.${_inches2.toString().padLeft(1, '0')}');
                                          });
                                          Navigator.pop(context);
                                        },
                                        child:  Text('Save',
                                          style: styleSatoshiMedium(
                                              size: 13,
                                              color: Colors.black),),
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          );
                        },
                      );

                    },
                    child: buildDataAddRow(title: 'Max Height ',
                        data1: maxHeightController.text.isEmpty
                            ? (preferenceControl.preferenceModel!.id == null || preferenceControl.preferenceModel!.minHeight == null || preferenceControl.preferenceModel!.minHeight!.isEmpty
                            ? 'Not Added'
                            : preferenceControl.preferenceModel!.minHeight.toString())
                            : maxHeightController.text,
                        data2: maxHeightController.text,
                        isControllerTextEmpty: maxHeightController.text.isEmpty, widget: SizedBox()),
                    // child: CarRowWidget(favourites: favourites!,)
                  ),

                  sizedBox16(),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return NameEditDialogWidget(
                            title: 'Max Weight',
                            addTextField: TextFormField(
                              keyboardType: TextInputType.number,
                              maxLength: 40,
                              onChanged: (v) {
                                setState(() {
                                });
                              },
                              onEditingComplete: () {
                                Navigator.pop(context);
                              },
                              controller: weightController,
                              decoration: AppTFDecoration(
                                  hint: 'Max Weight').decoration(),
                              //keyboardType: TextInputType.phone,
                            ),
                          );
                        },
                      );
                    },
                    child: buildDataAddRow(title: 'Max Weight',
                      data1: weightController.text.isEmpty
                          ? (preferenceControl.preferenceModel!.id == null || preferenceControl.preferenceModel!.maxWeight == null || preferenceControl.preferenceModel!.maxWeight!.isEmpty
                          ? 'Not Added'
                          : preferenceControl.preferenceModel!.maxWeight.toString())
                          : weightController.text,
                      data2: weightController.text,
                      isControllerTextEmpty: weightController.text.isEmpty, widget: SizedBox(),),
                    // child: CarRowWidget(favourites: favourites!,)
                  ),
                  sizedBox16(),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return ReligionSheet(
                            privacyStatus: '',
                            onPop: (val) {
                              preferredReligionController.text = val;
                              print(preferredReligionController.text);
                            },
                          );
                        },
                      );
                    },
                    child: buildDataAddRow(
                      title: 'Preferred Religion',
                      widget: const Icon(
                        Icons.edit,
                        size: 12,
                      ),
                      data1: preferredReligionController.text.isEmpty
                          ? (preferenceControl.preferenceModel!.id == null ||
                          preferenceControl.preferenceModel!.religion == null
                          ? 'Not Added'
                          : preferenceControl.preferenceModel!.religion.toString())
                          : preferredReligionController.text,
                      data2: preferredReligionController.text,
                      isControllerTextEmpty: preferredReligionController.text.isEmpty,
                    ),
                  ),
                  sizedBox16(),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return NameEditDialogWidget(
                            title: 'Preferred Profession',
                            addTextField: TextFormField(
                              maxLength: 40,
                              onChanged: (v) {
                                setState(() {
                                });
                              },
                              onEditingComplete: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              controller: preferredProfession,
                              decoration: AppTFDecoration(
                                  hint: 'Preferred Profession').decoration(),
                              //keyboardType: TextInputType.phone,
                            ),
                          );
                        },
                      );
                    },
                    child: buildDataAddRow(title: 'Preferred Profession',
                      data1: preferredProfession.text.isEmpty
                          ? (preferenceControl.preferenceModel!.id == null || preferenceControl.preferenceModel!.profession == null || preferenceControl.preferenceModel!.profession!.isEmpty
                          ? 'Not Added'
                          : preferenceControl.preferenceModel!.profession!)
                          : preferredProfession.text,
                      data2: StringUtils.capitalize(preferredProfession.text),
                      isControllerTextEmpty: preferredProfession.text.isEmpty, widget: SizedBox(),),
                  ),
                  sizedBox16(),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return FinancialBottomSheet(
                            privacyStatus: '',
                            onPop: (val) {
                              financialCondition.text = val;
                              print(financialCondition.text);
                            },
                          );
                        },
                      );
                    },
                    child: buildDataAddRow(
                      title: 'Financial Condition',
                      widget: const Icon(
                        Icons.edit,
                        size: 12,
                      ),
                      data1: financialCondition.text.isEmpty
                          ? (preferenceControl.preferenceModel!.id == null ||
                          preferenceControl.preferenceModel!.financialCondition == null
                          ? 'Not Added'
                          : preferenceControl.preferenceModel!.financialCondition.toString())
                          : financialCondition.text,
                      data2: financialCondition.text,
                      isControllerTextEmpty: financialCondition.text.isEmpty,
                    ),
                  ),
                  sizedBox16(),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return MotherTongueSheet(
                            privacyStatus: '',
                            onPop: (val) {
                              motherTongueController.text = val;
                              print(motherTongueController.text);
                            },
                          );
                        },
                      );
                    },
                    child: buildDataAddRow(
                      title: 'Mother Tongue',
                      widget: const Icon(
                        Icons.edit,
                        size: 12,
                      ),
                      data1: motherTongueController.text.isEmpty
                          ? (preferenceControl.preferenceModel!.id == null ||
                          preferenceControl.preferenceModel!.motherTongue == null
                          ? 'Not Added'
                          : preferenceControl.preferenceModel!.motherTongue.toString())
                          : motherTongueController.text,
                      data2: motherTongueController.text,
                      isControllerTextEmpty: motherTongueController.text.isEmpty,
                    ),
                  ),
                  sizedBox16(),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return CommuitySheet(
                            privacyStatus: '',
                            onPop: (val) {
                              communityController.text = val;
                              print(communityController.text);
                            },
                          );
                        },
                      );
                    },
                    child: buildDataAddRow(
                      title: 'Community',
                      widget: const Icon(
                        Icons.edit,
                        size: 12,
                      ),
                      data1: communityController.text.isEmpty
                          ? (preferenceControl.preferenceModel!.id == null ||
                          preferenceControl.preferenceModel!.community == null
                          ? 'Not Added'
                          : preferenceControl.preferenceModel!.community.toString())
                          : communityController.text,
                      data2: communityController.text,
                      isControllerTextEmpty: communityController.text.isEmpty,
                    ),
                  ),
                  sizedBox16(),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return NameEditDialogWidget(
                            title: 'Minimum Degree',
                            addTextField: TextFormField(
                              maxLength: 40,
                              onChanged: (v) {
                                setState(() {
                                });
                              },
                              onEditingComplete: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              controller: minimumDegreeController,
                              decoration: AppTFDecoration(
                                  hint: 'Minimum Degree').decoration(),
                              //keyboardType: TextInputType.phone,
                            ),
                          );
                        },
                      );
                    },
                    child: buildDataAddRow(title: 'Minimum Degree',
                      data1: minimumDegreeController.text.isEmpty
                          ? (preferenceControl.preferenceModel!.id == null || preferenceControl.preferenceModel!.minDegree == null || preferenceControl.preferenceModel!.minDegree!.isEmpty
                          ? 'Not Added'
                          : preferenceControl.preferenceModel!.minDegree!)
                          : minimumDegreeController.text,
                      data2: StringUtils.capitalize(minimumDegreeController.text),
                      isControllerTextEmpty: minimumDegreeController.text.isEmpty, widget: SizedBox(),),
                    // child: CarRowWidget(favourites: favourites!,)
                  ),
                  sizedBox16(),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return PrivacyStatusBottomSheet(
                            privacyStatus: '',
                            onPop: (val) {
                              smokingController.text = val;
                              print(smokingController.text);
                            },
                          );
                        },
                      );
                    },
                    child: buildDataAddRow(
                      title: 'Smoking status',
                      widget: const Icon(
                        Icons.edit,
                        size: 12,
                      ),
                      data1: smokingController.text.isEmpty
                          ? (preferenceControl.preferenceModel!.id == null ||
                          preferenceControl.preferenceModel!.smokingStatus == null
                          ? 'Not Added'
                          : preferenceControl.preferenceModel!.smokingStatus.toString())
                          : smokingController.text,
                      data2: smokingController.text,
                      isControllerTextEmpty: smokingController.text.isEmpty,
                    ),
                  ),
                  sizedBox16(),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return DrinkingStatusBottomSheet(
                            privacyStatus: '',
                            onPop: (val) {
                              drinkingController.text = val;
                              // print(smokingController.text);
                            },
                          );
                        },
                      );
                    },
                    child: buildDataAddRow(
                      title: 'Drinking status',
                      widget: const Icon(
                        Icons.edit,
                        size: 12,
                      ),
                      data1: drinkingController.text.isEmpty
                          ? (preferenceControl.preferenceModel!.id == null ||
                          preferenceControl.preferenceModel!.drinkingStatus == null
                          ? 'Not Added'
                          : preferenceControl.preferenceModel!.drinkingStatus.toString())
                          : drinkingController.text,
                      data2: drinkingController.text,
                      isControllerTextEmpty: drinkingController.text.isEmpty,
                    ),
                    // child: CarRowWidget(drinkingController)
                  ),
                  sizedBox16(),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return NameEditDialogWidget(
                            title: 'Language',
                            addTextField: TextFormField(
                              maxLength: 40,
                              onChanged: (v) {
                                setState(() {
                                });
                              },
                              onEditingComplete: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              controller: languageController,
                              decoration: AppTFDecoration(
                                  hint: 'Language').decoration(),
                              //keyboardType: TextInputType.phone,
                            ),
                          );
                        },
                      );
                    },
                    child: buildDataAddRow(title: 'Language',
                      data1: languageController.text.isEmpty
                          ? (preferenceControl.preferenceModel!.id == null || preferenceControl.preferenceModel!.language == null || preferenceControl.preferenceModel!.language!.isEmpty
                          ? 'Not Added'
                          : preferenceControl.preferenceModel!.language.toString())
                          : languageController.text,
                      data2: StringUtils.capitalize(removeBrackets(languageController.text)),
                      isControllerTextEmpty: languageController.text.isEmpty, widget: SizedBox(),),
                    // child: CarRowWidget(favourites: favourites!,)
                  ),





                ],
              ),
            ),
          );
        })




      ),
    );
  }

  String removeBrackets(String text) {
    return text.replaceAll(RegExp(r'\[|\]'), '');
  }

  Row buildDataAddRow({
    required String title,
    required String data1,
    required String data2,
    required bool isControllerTextEmpty,
    required Widget widget,
  }) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Text(
               title, style: styleSatoshiRegular(size: 14, color: color5E5E5E),
              ),
              const SizedBox(
                width: 3,
              ),
              widget,
            ],
          ),
        ),
        isControllerTextEmpty
            ? Expanded(
          // flex: 3,
          child: SizedBox(
            width: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      data1,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
            : Expanded(
          child: SizedBox(
            width: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  data2,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }


  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: backButton(
            context: context,
            image: icArrowLeft,
            onTap: () {
              Navigator.pop(context);
            }),
      ),
      title: Text("Edit Partner Expectation",
        style: styleSatoshiBold(size: 18, color: Colors.black),
      ),
    );
  }
}


class AttributesShimmerWidget extends StatelessWidget {
  const AttributesShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: Column(
          children: [
            Container(
              height: 15,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16)
              ),
            ),
            sizedBox16(),

            sizedBox16(),
            Container(
              height: 15,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16)
              ),
            ),
            sizedBox16(),

            sizedBox16(),
            Container(
              height: 15,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16)
              ),
            ),
            sizedBox16(),

            sizedBox16(),
            Container(
              height: 15,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16)
              ),
            ),
            sizedBox16(),

            sizedBox16(),
            Container(
              height: 15,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16)
              ),
            ),
            sizedBox16(),

            sizedBox16(),
            Container(
              height: 15,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16)
              ),
            ),
            sizedBox16(),


          ],
        ),
      ),
    );
  }
}


class FinancialBottomSheet extends StatefulWidget {
  final String privacyStatus;
  final Function(String) onPop;

  const FinancialBottomSheet(
      {Key? key, required this.privacyStatus, required this.onPop})
      : super(key: key);

  @override
  State<FinancialBottomSheet> createState() => _FinancialBottomSheet();
}

class _FinancialBottomSheet extends State<FinancialBottomSheet> {
  int _gIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Material(
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Select Financial Condition",
                  style: styleSatoshiMedium(size: 16, color: Colors.black),
                ),
                sizedBox16(),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 0;
                    Navigator.of(context).pop();
                    widget.onPop("Below 3 lacs");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 0 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Below 3 lacs',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 0 ? Colors.white : Colors.black),
                          // style: _gIndex == 0
                          //     ? textColorF7E64114w400
                          //     : ColorSelect.colorF7E641
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 1;
                    Navigator.of(context).pop();
                    widget.onPop("4-8 lacs");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 1 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          '4-8 lacs',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 1 ? Colors.white : Colors.black),
                          // style
                          // : _gIndex == 1
                          //     ? kManRope_500_16_white
                          //     : kManRope_500_16_626A6A,
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 2;
                    Navigator.of(context).pop();
                    widget.onPop("Above 8 lacs");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 2 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Above 8 lacs',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 2 ? Colors.white : Colors.black),
                          // style
                          // : _gIndex == 1
                          //     ? kManRope_500_16_white
                          //     : kManRope_500_16_626A6A,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    if (widget.privacyStatus == "Below 3 lacs") {
      _gIndex = 0;
    } else if (widget.privacyStatus == "4-8 lacs") {
      _gIndex = 1;
    }
    else if (widget.privacyStatus == "Above 8 lacs") {
      _gIndex = 2;
    }
    super.initState();
  }
}


class ReligionSheet extends StatefulWidget {
  final String privacyStatus;
  final Function(String) onPop;

  const ReligionSheet(
      {Key? key, required this.privacyStatus, required this.onPop})
      : super(key: key);

  @override
  State<ReligionSheet> createState() => _ReligionSheet();
}

class _ReligionSheet extends State<ReligionSheet> {
  int _gIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Material(
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Select Religion",
                  style: styleSatoshiMedium(size: 16, color: Colors.black),
                ),
                sizedBox16(),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 0;
                    Navigator.of(context).pop();
                    widget.onPop("Hindu");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 0 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Hindu',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 0 ? Colors.white : Colors.black),
                          // style: _gIndex == 0
                          //     ? textColorF7E64114w400
                          //     : ColorSelect.colorF7E641
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 1;
                    Navigator.of(context).pop();
                    widget.onPop("Muslim");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 1 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Muslim',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 1 ? Colors.white : Colors.black),
                          // style
                          // : _gIndex == 1
                          //     ? kManRope_500_16_white
                          //     : kManRope_500_16_626A6A,
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 2;
                    Navigator.of(context).pop();
                     widget.onPop("Jain");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 2 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Jain',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 2 ? Colors.white : Colors.black),
                          // style
                          // : _gIndex == 1
                          //     ? kManRope_500_16_white
                          //     : kManRope_500_16_626A6A,
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 3;
                    Navigator.of(context).pop();
                    widget.onPop("Buddhist");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 3 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Buddhist',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 3 ? Colors.white : Colors.black),
                          // style
                          // : _gIndex == 1
                          //     ? kManRope_500_16_white
                          //     : kManRope_500_16_626A6A,
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 4;
                    Navigator.of(context).pop();
                    widget.onPop("Sikh");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 4 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Sikh',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 4 ? Colors.white : Colors.black),
                          // style
                          // : _gIndex == 1
                          //     ? kManRope_500_16_white
                          //     : kManRope_500_16_626A6A,
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 5;
                    Navigator.of(context).pop();
                    widget.onPop("Marathi");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 5 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Marathi',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 5 ? Colors.white : Colors.black),
                          // style
                          // : _gIndex == 1
                          //     ? kManRope_500_16_white
                          //     : kManRope_500_16_626A6A,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    if (widget.privacyStatus == "Hindu") {
      _gIndex = 0;
    } else if (widget.privacyStatus == "Muslim") {
      _gIndex = 1;
    }
    else if (widget.privacyStatus == "Jain") {
      _gIndex = 2;
    } else if (widget.privacyStatus == "Buddhist") {
      _gIndex = 3;
    }  else if (widget.privacyStatus == "Sikh") {
      _gIndex = 4;
    } else if (widget.privacyStatus == "Marathi") {
      _gIndex = 5;
    }
    super.initState();
  }
}

class MotherTongueSheet extends StatefulWidget {
  final String privacyStatus;
  final Function(String) onPop;

  const MotherTongueSheet(
      {Key? key, required this.privacyStatus, required this.onPop})
      : super(key: key);

  @override
  State<MotherTongueSheet> createState() => _MotherTongueSheet();
}

class _MotherTongueSheet extends State<MotherTongueSheet> {
  int _gIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Material(
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Select Mother Tongue",
                  style: styleSatoshiMedium(size: 16, color: Colors.black),
                ),
                sizedBox16(),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 0;
                    Navigator.of(context).pop();
                    widget.onPop("Hindi");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 0 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Hindi',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 0 ? Colors.white : Colors.black),
                          // style: _gIndex == 0
                          //     ? textColorF7E64114w400
                          //     : ColorSelect.colorF7E641
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 1;
                    Navigator.of(context).pop();
                    widget.onPop("Bhojpuri");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 1 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Bhojpuri',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 1 ? Colors.white : Colors.black),
                          // style
                          // : _gIndex == 1
                          //     ? kManRope_500_16_white
                          //     : kManRope_500_16_626A6A,
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 2;
                    Navigator.of(context).pop();
                    widget.onPop("Marathi");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 2 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Marathi',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 2 ? Colors.white : Colors.black),
                          // style
                          // : _gIndex == 1
                          //     ? kManRope_500_16_white
                          //     : kManRope_500_16_626A6A,
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 3;
                    Navigator.of(context).pop();
                    widget.onPop("Bengali");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 3 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Bengali',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 3 ? Colors.white : Colors.black),
                          // style
                          // : _gIndex == 1
                          //     ? kManRope_500_16_white
                          //     : kManRope_500_16_626A6A,
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 4;
                    Navigator.of(context).pop();
                    widget.onPop("Odia");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 4 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Odia',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 4 ? Colors.white : Colors.black),
                          // style
                          // : _gIndex == 1
                          //     ? kManRope_500_16_white
                          //     : kManRope_500_16_626A6A,
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 5;
                    Navigator.of(context).pop();
                    widget.onPop("Gujarati");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 5 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Gujarati',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 5 ? Colors.white : Colors.black),
                          // style
                          // : _gIndex == 1
                          //     ? kManRope_500_16_white
                          //     : kManRope_500_16_626A6A,
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 6;
                    Navigator.of(context).pop();
                    widget.onPop("Punjabi");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 6 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Punjabi',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 6 ? Colors.white : Colors.black),
                          // style
                          // : _gIndex == 1
                          //     ? kManRope_500_16_white
                          //     : kManRope_500_16_626A6A,
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 7;
                    Navigator.of(context).pop();
                    widget.onPop("Urdu");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 7 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Urdu',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 7 ? Colors.white : Colors.black),
                          // style
                          // : _gIndex == 1
                          //     ? kManRope_500_16_white
                          //     : kManRope_500_16_626A6A,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    if (widget.privacyStatus == "Hindi") {
      _gIndex = 0;
    } else if (widget.privacyStatus == "Bhojpuri") {
      _gIndex = 1;
    }
    else if (widget.privacyStatus == "Marathi") {
      _gIndex = 2;
    } else if (widget.privacyStatus == "Bengali") {
      _gIndex = 3;
    }  else if (widget.privacyStatus == "Odia") {
      _gIndex = 4;
    } else if (widget.privacyStatus == "Gujarati") {
      _gIndex = 5;
    } else if (widget.privacyStatus == "Punjabi") {
      _gIndex = 6;
    }  else if (widget.privacyStatus == "Urdu") {
      _gIndex = 7;
    }
    super.initState();
  }
}

class CommuitySheet extends StatefulWidget {
  final String privacyStatus;
  final Function(String) onPop;

  const CommuitySheet(
      {Key? key, required this.privacyStatus, required this.onPop})
      : super(key: key);

  @override
  State<CommuitySheet> createState() => _CommuitySheet();
}

class _CommuitySheet extends State<CommuitySheet> {
  int _gIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Material(
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Select Community",
                  style: styleSatoshiMedium(size: 16, color: Colors.black),
                ),
                sizedBox16(),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 0;
                    Navigator.of(context).pop();
                    widget.onPop("Brahmin");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 0 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Brahmin',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 0 ? Colors.white : Colors.black),
                          // style: _gIndex == 0
                          //     ? textColorF7E64114w400
                          //     : ColorSelect.colorF7E641
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 1;
                    Navigator.of(context).pop();
                    widget.onPop("Rajput");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 1 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Rajput',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 1 ? Colors.white : Colors.black),
                          // style
                          // : _gIndex == 1
                          //     ? kManRope_500_16_white
                          //     : kManRope_500_16_626A6A,
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 2;
                    Navigator.of(context).pop();
                    widget.onPop("Kamma");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 2 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Kamma',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 2 ? Colors.white : Colors.black),
                          // style
                          // : _gIndex == 1
                          //     ? kManRope_500_16_white
                          //     : kManRope_500_16_626A6A,
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 3;
                    Navigator.of(context).pop();
                    widget.onPop("Yadav");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 3 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Yadav',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 3 ? Colors.white : Colors.black),
                          // style
                          // : _gIndex == 1
                          //     ? kManRope_500_16_white
                          //     : kManRope_500_16_626A6A,
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 4;
                    Navigator.of(context).pop();
                    widget.onPop("Gupta");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 4 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Gupta',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 4 ? Colors.white : Colors.black),
                          // style
                          // : _gIndex == 1
                          //     ? kManRope_500_16_white
                          //     : kManRope_500_16_626A6A,
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 5;
                    Navigator.of(context).pop();
                    widget.onPop("Muslim");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 5 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Muslim',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 5 ? Colors.white : Colors.black),
                          // style
                          // : _gIndex == 1
                          //     ? kManRope_500_16_white
                          //     : kManRope_500_16_626A6A,
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 6;
                    Navigator.of(context).pop();
                    widget.onPop("Sikh");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 6 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Sikh',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 6 ? Colors.white : Colors.black),
                          // style
                          // : _gIndex == 1
                          //     ? kManRope_500_16_white
                          //     : kManRope_500_16_626A6A,
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 7;
                    Navigator.of(context).pop();
                    widget.onPop("Punjabi");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 7 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Punjabi',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 7 ? Colors.white : Colors.black),
                          // style
                          // : _gIndex == 1
                          //     ? kManRope_500_16_white
                          //     : kManRope_500_16_626A6A,
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 8;
                    Navigator.of(context).pop();
                    widget.onPop("Aggarwal");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 8 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Aggarwal',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 8 ? Colors.white : Colors.black),
                          // style
                          // : _gIndex == 1
                          //     ? kManRope_500_16_white
                          //     : kManRope_500_16_626A6A,
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 9;
                    Navigator.of(context).pop();
                    widget.onPop("Muslim");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 9 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Muslim',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 9 ? Colors.white : Colors.black),
                          // style
                          // : _gIndex == 1
                          //     ? kManRope_500_16_white
                          //     : kManRope_500_16_626A6A,
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    _gIndex = 10;
                    Navigator.of(context).pop();
                    widget.onPop("Marathi");
                  }),
                  child: Container(
                    height: 44,
                    // width: 78,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: _gIndex == 10 ? primaryColor : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                          'Marathi',
                          style: styleSatoshiLight(
                              size: 14,
                              color: _gIndex == 10 ? Colors.white : Colors.black),
                          // style
                          // : _gIndex == 1
                          //     ? kManRope_500_16_white
                          //     : kManRope_500_16_626A6A,
                        )),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    if (widget.privacyStatus == "Brahmin") {
      _gIndex = 0;
    } else if (widget.privacyStatus == "Rajput") {
      _gIndex = 1;
    }
    else if (widget.privacyStatus == "Kamma") {
      _gIndex = 2;
    } else if (widget.privacyStatus == "Yadav") {
      _gIndex = 3;
    }  else if (widget.privacyStatus == "Gupta") {
      _gIndex = 4;
    } else if (widget.privacyStatus == "Muslim") {
      _gIndex = 5;
    } else if (widget.privacyStatus == "Sikh") {
      _gIndex = 6;
    } else if (widget.privacyStatus == "Punjabi") {
      _gIndex = 7;
    } else if (widget.privacyStatus == "Aggarwal") {
      _gIndex = 8;
    } else if (widget.privacyStatus == "Muslim") {
      _gIndex = 9;
    }  else if (widget.privacyStatus == "Marathi") {
      _gIndex = 10;
    }
    super.initState();
  }
}

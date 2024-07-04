import 'package:bureau_couple/controllers/profile_controller.dart';
import 'package:bureau_couple/src/constants/sizedboxe.dart';
import 'package:bureau_couple/src/utils/widgets/buttons.dart';
import 'package:bureau_couple/src/utils/widgets/customAppbar.dart';
import 'package:bureau_couple/src/utils/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';
import '../../../apis/profile_apis/get_profile_api.dart';
import '../../../apis/profile_apis/physical_attributes_api.dart';
import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../constants/string.dart';
import '../../../constants/textstyles.dart';
import 'package:get/get.dart';
import '../../../utils/widgets/common_widgets.dart';
import '../../../utils/widgets/name_edit_dialog.dart';
import '../../../utils/widgets/textfield_decoration.dart';
import 'package:fluttertoast/fluttertoast.dart';
class EditPhysicalAttributesScreen extends StatefulWidget {
  const EditPhysicalAttributesScreen({super.key});

  @override
  State<EditPhysicalAttributesScreen> createState() => _EditPhysicalAttributesScreenState();
}

class _EditPhysicalAttributesScreenState extends State<EditPhysicalAttributesScreen> {
  final complexionController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final bloodGroupController = TextEditingController();
  final eyeColorController = TextEditingController();
  final hairColorController = TextEditingController();
  final disablityController = TextEditingController();

  bool loading = false;
  bool isLoading = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ProfileController>().getPhysicalAttributesApi();
      // fields();
    });
    super.initState();
  }


  // PhysicalAttributes physicalData = PhysicalAttributes();

  // careerInfo() {
  //   isLoading = true;
  //   var resp = getProfileApi();
  //   resp.then((value) {
  //     // physicalData.clear();
  //     if (value['status'] == true) {
  //       setState(() {
  //         var physicalAttributesData = value['data']['user']['physical_attributes'];
  //         if (physicalAttributesData != null) {
  //           setState(() {
  //             physicalData = PhysicalAttributes.fromJson(physicalAttributesData);
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
    complexionController.text = Get.find<ProfileController>().physicalAttributes!.complexion.toString() ?? '';
    heightController.text =Get.find<ProfileController>().physicalAttributes!.height.toString() ?? '';
    weightController.text =Get.find<ProfileController>().physicalAttributes!.weight.toString() ?? '';
    bloodGroupController.text = Get.find<ProfileController>().physicalAttributes!.bloodGroup.toString()?? '';
    eyeColorController.text =Get.find<ProfileController>().physicalAttributes!.eyeColor.toString() ?? '';
    hairColorController.text = Get.find<ProfileController>().physicalAttributes!.hairColor.toString() ?? '';
    disablityController.text = Get.find<ProfileController>().physicalAttributes!.disability.toString() ?? '';

  }

  DateTime _selectedTime = DateTime.now();
  String time = "-";

  int _feet = 5;
  int _inches = 0;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Physical Attributes",isBackButtonExist: true,),
      // appBar: buildAppBar(context),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child:
          loading ?
          loadingButton(context: context) :button(context: context, onTap: () {
            setState(() {
              loading = true;
            });
            physicalAppearanceUpdateApi(
                height: heightController.text,
                weight: weightController.text,
                bloodGroup: bloodGroupController.text,
                eyeColor: eyeColorController.text,
                hairColor: hairColorController.text,
                complexion: complexionController.text,
                disability: disablityController.text).then((value) {
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
          // setState(() {
          //   isLoading = true;
          // });
          // return careerInfo();
        },
        child: GetBuilder<ProfileController>(builder: (physicalControl) {
          return SingleChildScrollView(
            physics: const  AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return NameEditDialogWidget(
                            title: 'Complexion',
                            addTextField: TextFormField(
                              maxLength: 40,
                              onChanged: (v) {
                                setState(() {
                                });
                              },
                              onEditingComplete: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              controller: complexionController,
                              decoration: AppTFDecoration(
                                  hint: 'Complexion').decoration(),
                              //keyboardType: TextInputType.phone,
                            ),
                          );
                        },
                      );
                    },
                    child: buildDataAddRow(title: 'Complexion',
                      data1: complexionController.text.isEmpty
                          ? (physicalControl.physicalAttributes!.id == null || physicalControl.physicalAttributes!.complexion == null || physicalControl.physicalAttributes!.complexion!.isEmpty
                          ? 'Not Added'
                          : physicalControl.physicalAttributes!.complexion!)
                          : complexionController.text,
                      data2: StringUtils.capitalize(complexionController.text),
                      isControllerTextEmpty: complexionController.text.isEmpty,),
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
                                            // heightController.text = ' $_feet-${_inches.toString().padLeft(2, '0')}';
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
                    child: buildDataAddRow(title: 'Height',
                        data1: heightController.text.isEmpty
                            ? (physicalControl.physicalAttributes!.id == null || physicalControl.physicalAttributes!.height == null || physicalControl.physicalAttributes!.height!.isEmpty
                            ? 'Not Added'
                            : physicalControl.physicalAttributes!.height.toString())
                            : heightController.text,
                        data2: heightController.text,
                        isControllerTextEmpty: heightController.text.isEmpty),
                    // child: CarRowWidget(favourites: favourites!,)
                  ),
                  sizedBox16(),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return NameEditDialogWidget(
                            title: 'Weight in kgs',
                            addTextField: TextFormField(
                              keyboardType: TextInputType.number,
                              maxLength: 40,
                              onChanged: (v) {
                                setState(() {

                                });
                              },
                              onEditingComplete: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              controller: weightController,
                              decoration: AppTFDecoration(
                                  hint: 'Weight').decoration(),
                              //keyboardType: TextInputType.phone,
                            ),
                          );
                        },
                      );
                    },
                    child: buildDataAddRow(title: 'Weight',
                      data1: weightController.text.isEmpty
                          ? (physicalControl.physicalAttributes!.id == null || physicalControl.physicalAttributes!.weight == null || physicalControl.physicalAttributes!.weight!.isEmpty
                          ? 'Not Added'
                          : physicalControl.physicalAttributes!.weight.toString())
                          : weightController.text,
                      data2: weightController.text,
                      isControllerTextEmpty: weightController.text.isEmpty,),
                    // child: CarRowWidget(favourites: favourites!,)
                  ),
                  sizedBox16(),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return NameEditDialogWidget(
                            title: 'Blood Group',
                            addTextField: TextFormField(
                              maxLength: 40,
                              onChanged: (v) {
                                setState(() {
                                });
                              },
                              onEditingComplete: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              controller: bloodGroupController,
                              decoration: AppTFDecoration(
                                  hint: 'Blood Group').decoration(),
                              //keyboardType: TextInputType.phone,
                            ),
                          );
                        },
                      );
                    },
                    child: buildDataAddRow(title: 'Blood Group',
                      data1: bloodGroupController.text.isEmpty
                          ? (physicalControl.physicalAttributes!.id == null || physicalControl.physicalAttributes!.bloodGroup == null || physicalControl.physicalAttributes!.bloodGroup!.isEmpty
                          ? 'Not Added'
                          : physicalControl.physicalAttributes!.bloodGroup.toString())
                          : bloodGroupController.text,
                      data2: StringUtils.capitalize(bloodGroupController.text),
                      isControllerTextEmpty: bloodGroupController.text.isEmpty,),
                    // child: CarRowWidget(favourites: favourites!,)
                  ),
                  sizedBox16(),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return NameEditDialogWidget(
                            title: 'EyeColor ',
                            addTextField: TextFormField(
                              maxLength: 40,
                              onChanged: (v) {
                                setState(() {

                                });
                              },
                              onEditingComplete: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              controller: eyeColorController,
                              decoration: AppTFDecoration(
                                  hint: 'EyeColor').decoration(),
                              //keyboardType: TextInputType.phone,
                            ),
                          );
                        },
                      );
                    },
                    child: buildDataAddRow(title: 'EyeColor',
                      data1: eyeColorController.text.isEmpty
                          ? (physicalControl.physicalAttributes!.id == null || physicalControl.physicalAttributes!.eyeColor == null || physicalControl.physicalAttributes!.eyeColor!.isEmpty
                          ? 'Not Added'
                          : physicalControl.physicalAttributes!.eyeColor.toString())
                          : eyeColorController.text,
                      data2: StringUtils.capitalize(eyeColorController.text),
                      isControllerTextEmpty: eyeColorController.text.isEmpty,),
                    // child: CarRowWidget(favourites: favourites!,)
                  ),
                  sizedBox16(),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return NameEditDialogWidget(
                            title: 'Hair Color',
                            addTextField: TextFormField(
                              maxLength: 40,
                              onChanged: (v) {
                                setState(() {

                                });
                              },
                              onEditingComplete: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              controller: hairColorController,
                              decoration: AppTFDecoration(
                                  hint: 'Hair Color').decoration(),
                              //keyboardType: TextInputType.phone,
                            ),
                          );
                        },
                      );
                    },
                    child: buildDataAddRow(title: 'Hair Color',
                      data1: hairColorController.text.isEmpty
                          ? (physicalControl.physicalAttributes!.id == null || physicalControl.physicalAttributes!.hairColor == null || physicalControl.physicalAttributes!.hairColor!.isEmpty
                          ? 'Not Added'
                          : physicalControl.physicalAttributes!.weight.toString())
                          : hairColorController.text,
                      data2: StringUtils.capitalize(hairColorController.text),
                      isControllerTextEmpty: hairColorController.text.isEmpty,),
                    // child: CarRowWidget(favourites: favourites!,)
                  ),
                  sizedBox16(),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return NameEditDialogWidget(
                            title: 'Disability',
                            addTextField: TextFormField(
                              maxLength: 40,
                              onChanged: (v) {
                                setState(() {
                                });
                              },
                              onEditingComplete: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              controller: disablityController,
                              decoration: AppTFDecoration(
                                  hint: 'Disability').decoration(),
                              //keyboardType: TextInputType.phone,
                            ),
                          );
                        },
                      );
                    },
                    child: buildDataAddRow(title: 'Disability',
                      data1: disablityController.text.isEmpty
                          ? (physicalControl.physicalAttributes!.id == null || physicalControl.physicalAttributes!.disability == null || physicalControl.physicalAttributes!.disability!.isEmpty
                          ? 'Not Added'
                          : physicalControl.physicalAttributes!.disability.toString())
                          : disablityController.text,
                      data2: StringUtils.capitalize(disablityController.text),
                      isControllerTextEmpty: disablityController.text.isEmpty,),
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

  Row buildDataAddRow({
    required String title,
    required String data1,
    required String data2,
    required bool isControllerTextEmpty,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title, style: styleSatoshiRegular(size: 14, color: color5E5E5E),
          ),
        ),
        isControllerTextEmpty ?
        Expanded(
          // flex: 3,
          child: SizedBox(
            width: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  data1,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ) :
        SizedBox(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(data2,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ],
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
      title: Text("Physical Attributes",
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

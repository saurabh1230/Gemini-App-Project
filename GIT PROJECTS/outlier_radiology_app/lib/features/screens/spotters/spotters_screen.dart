
import 'package:flutter/material.dart';
import 'package:outlier_radiology_app/controllers/notes_controller.dart';
import 'package:outlier_radiology_app/controllers/spotters_controller.dart';
import 'package:outlier_radiology_app/features/screens/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:outlier_radiology_app/features/screens/spotters/components/spotters_content_section.dart';
import 'package:outlier_radiology_app/features/widgets/custom_loading_widget.dart';
import 'package:outlier_radiology_app/utils/dimensions.dart';
import 'package:outlier_radiology_app/utils/sizeboxes.dart';
import 'package:outlier_radiology_app/utils/styles.dart';
class SpottersScreen extends StatelessWidget {
  const SpottersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<SpottersController>().getSpottersList();
    });

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Spotters",
        isBackButtonExist: true,
        backGroundColor: Colors.black,
      ),
        body:
          GetBuilder<SpottersController>(builder: (spottersControl) {
        return  spottersControl.isSpottersLoading  || spottersControl.spottersList == null ?
            const Center(child: LoaderWidget()) :
          PageView.builder(
          scrollDirection: Axis.vertical,
          controller: spottersControl.pageController,
          itemCount: spottersControl.spottersList!.length,
          itemBuilder: (context, index) {
            return SpotterContentWidget(spottersControl.spottersList![index].image.toString(),
                spottersControl.spottersList![index].title.toString(),
                spottersControl.spottersList![index].content.toString());
          },);
      })




    );
  }
}

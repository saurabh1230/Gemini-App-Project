import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radiology/controllers/munchies_controller.dart';
import 'package:radiology/controllers/notes_controller.dart';
import 'package:radiology/data/repo/munchies_repo.dart';
import 'package:radiology/data/repo/note_repo.dart';
import 'package:radiology/features/screens/custom_appbar.dart';
import 'package:radiology/features/screens/munchies/munches_sub_category_screen.dart';
import 'package:radiology/features/screens/notes/components/note_selectio_section.dart';
import 'package:radiology/features/screens/notes/notes_sub_category_screen.dart';
import 'package:radiology/features/widgets/custom_loading_widget.dart';
import 'package:radiology/helper/route_helper.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/sizeboxes.dart';
import 'package:radiology/utils/styles.dart';
import 'package:get/get.dart';

class MunchiesCategoryScreen extends StatefulWidget {
  MunchiesCategoryScreen({super.key});

  @override
  State<MunchiesCategoryScreen> createState() => _MunchiesCategoryScreenState();
}

class _MunchiesCategoryScreenState extends State<MunchiesCategoryScreen> {
  final MunchiesRepo munchiesRp = Get.put(MunchiesRepo(apiClient: Get.find()));

  final MunchiesController controller = Get.put(MunchiesController(munchiesRepo: Get.find()));
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getMunchesList();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MunchiesController>(builder: (munchiesControl) {
      return Stack(
        children: [
          SafeArea(
            child: Scaffold(
              appBar: const CustomAppBar(
                isBackButtonExist: true,
                title: "Munchies",
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  controller.getMunchesList();
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Text(
                        'Select topic to know',
                        style: poppinsRegular.copyWith(
                          fontSize: Dimensions.fontSize14,
                          color: Theme.of(context).cardColor.withOpacity(0.50),
                        ),
                      ),
                      sizedBoxDefault(),
                      munchiesControl.munchiesList != null && munchiesControl.munchiesList!.isNotEmpty
                          ? ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeDefault,
                          vertical: Dimensions.paddingSizeDefault,
                        ),
                        itemCount: munchiesControl.munchiesList!.length,
                        shrinkWrap: true,
                        itemBuilder: (_, i) {
                          final note = munchiesControl.munchiesList![i];
                          return NotesSelectionSelection(
                            tap: () {
                              Get.to(() => MunchesSubCategoryScreen(noteListModel: note,
                              ));

                            },
                            title: note.name.toString(),
                            colorString: note.color.toString(),
                            topics:'Topics ${ note.child!.length}',
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            sizedBoxDefault(),
                      )
                          : Center(
                        child: Text(
                          'Nothing available',
                          style: poppinsRegular.copyWith(
                            fontSize: Dimensions.fontSize14,
                            color: Theme.of(context).cardColor.withOpacity(0.50),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (munchiesControl.isMunchiesLoading || munchiesControl.isMunchiesLoading == null)
            const LoaderWidget(),
        ],
      );
    });
  }
}


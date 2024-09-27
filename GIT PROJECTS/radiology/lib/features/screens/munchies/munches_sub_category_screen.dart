import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radiology/controllers/notes_controller.dart';
import 'package:radiology/data/repo/munchies_repo.dart';
import 'package:radiology/data/repo/note_repo.dart';
import 'package:radiology/features/screens/custom_appbar.dart';
import 'package:radiology/features/screens/notes/components/note_selectio_section.dart';
import 'package:radiology/features/widgets/custom_loading_widget.dart';
import 'package:radiology/features/widgets/empty_data_widget.dart';
import 'package:radiology/helper/route_helper.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/images.dart';
import 'package:radiology/utils/sizeboxes.dart';
import 'package:radiology/utils/styles.dart';
import 'package:get/get.dart';

import '../../../controllers/munchies_controller.dart';
import '../../../data/model/response/note_list_model.dart';

class MunchesSubCategoryScreen extends StatelessWidget {
  final NoteListModel? noteListModel;

  MunchesSubCategoryScreen({
    super.key,
    required this.noteListModel,
  });

  final MunchiesRepo notesRp = Get.put(MunchiesRepo(apiClient: Get.find()));
  final MunchiesController notesController = Get.put(MunchiesController(munchiesRepo: Get.find()));

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notesController.getMunchesList();
    });

    return GetBuilder<MunchiesController>(builder: (noteControl) {
      return Stack(
        children: [
          SafeArea(
            child: Scaffold(
              appBar: CustomAppBar(
                isBackButtonExist: true,
                title: noteListModel!.name.toString(),
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  notesController.getMunchesList();


                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Text(
                        'Select to see notes',
                        style: poppinsRegular.copyWith(
                          fontSize: Dimensions.fontSize14,
                          color: Theme.of(context).cardColor.withOpacity(0.50),
                        ),
                      ),
                      sizedBoxDefault(),
                      noteListModel!.child != null && noteListModel!.child!.isNotEmpty
                          ? ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeDefault,
                          vertical: Dimensions.paddingSizeDefault,
                        ),
                        itemCount: noteListModel!.child!.length,
                        shrinkWrap: true,
                        itemBuilder: (_, i) {
                          return NotesSelectionSelection(
                            tap: () {
                              Get.toNamed(RouteHelper.getMunchesDashboardRoute(
                                  noteListModel!.child![i].id.toString(),
                                  noteListModel!.child![i].name.toString()));
                            },
                            title: noteListModel!.child![i].name.toString(),
                            colorString:noteListModel!.child![i].color.toString(),
                            topics:'Completed ${noteListModel!.child![i].readNote} / ${noteListModel!.child![i].notesCount}',
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) => sizedBoxDefault(),
                      ) : const Center(child: EmptyDataWidget(
                        image: Images.emptyDataImage,
                        text: "Nothing Available",)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (noteControl.isMunchiesLoading || noteControl.munchiesList == null)
            const LoaderWidget(),
        ],
      );
    });
  }
}

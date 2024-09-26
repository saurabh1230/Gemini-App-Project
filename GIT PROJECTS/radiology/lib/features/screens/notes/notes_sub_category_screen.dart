import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radiology/controllers/notes_controller.dart';
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
import '../../../data/model/response/note_list_model.dart';

class NotesSubCategoryScreen extends StatelessWidget {
  final NoteListModel? noteListModel;
  NotesSubCategoryScreen({
    super.key,
    required this.noteListModel,
  });

  final NoteRepo notesRp = Get.put(NoteRepo(apiClient: Get.find()));
  final NotesController notesController =
      Get.put(NotesController(noteRepo: Get.find()));

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notesController.getNoteList();
    });

    return GetBuilder<NotesController>(builder: (noteControl) {
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
                  notesController.getNoteList();

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
                                    Get.toNamed(RouteHelper.getNotesDashboardRoute(
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
                              text: "No Notes Available",)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (noteControl.isNoteLoading || noteControl.noteList == null)
            const LoaderWidget(),
        ],
      );
    });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radiology/controllers/notes_controller.dart';
import 'package:radiology/data/repo/note_repo.dart';
import 'package:radiology/features/screens/custom_appbar.dart';
import 'package:radiology/features/screens/notes/components/note_selectio_section.dart';
import 'package:radiology/features/widgets/custom_loading_widget.dart';
import 'package:radiology/helper/route_helper.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/sizeboxes.dart';
import 'package:radiology/utils/styles.dart';
import 'package:get/get.dart';

class NotesScreen extends StatelessWidget {
  NotesScreen({super.key});
  final NoteRepo notesRp = Get.put(NoteRepo(apiClient: Get.find()));
  final NotesController notesController = Get.put(NotesController(noteRepo: Get.find()));


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
              appBar: const CustomAppBar(
                isBackButtonExist: true,
                title: "NOTES",
              ),
              body: SingleChildScrollView(
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
                    noteControl.noteList != null && noteControl.noteList!.isNotEmpty
                        ? ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeDefault,
                        vertical: Dimensions.paddingSizeDefault,
                      ),
                      itemCount: noteControl.noteList!.length,
                      shrinkWrap: true,
                      itemBuilder: (_, i) {
                        final note = noteControl.noteList![i];
                        return NotesSelectionSelection(
                          tap: () {
                            noteControl.toggleExpanded(note.id!);
                          },
                          title: note.name.toString(),
                          colorString: note.color.toString(),
                          childColorString: note.child != null && note.child!.isNotEmpty
                              ? note.child![0].color.toString()
                              : "#FFFFFF",
                          noteListModel: note,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          sizedBoxDefault(),
                    )
                        : Center(
                      child: Text(
                        'No notes available',
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
          if (noteControl.isNoteLoading || noteControl.noteList == null)
            const LoaderWidget(),
        ],
      );
    });
  }
}


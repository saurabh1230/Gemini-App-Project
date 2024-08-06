import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radiology/controllers/notes_controller.dart';
import 'package:radiology/data/repo/note_repo.dart';
import 'package:radiology/features/screens/custom_appbar.dart';
import 'package:radiology/features/screens/notes/components/note_selectio_section.dart';
import 'package:radiology/features/screens/notes/notes_sub_category_screen.dart';
import 'package:radiology/features/widgets/custom_loading_widget.dart';
import 'package:radiology/helper/route_helper.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/sizeboxes.dart';
import 'package:radiology/utils/styles.dart';
import 'package:get/get.dart';

class NotesScreen extends StatefulWidget {
  NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final NoteRepo notesRp = Get.put(NoteRepo(apiClient: Get.find()));

  final NotesController notesController = Get.put(NotesController(noteRepo: Get.find()));
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notesController.getNoteList();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   notesController.getNoteList();
    // });
    return GetBuilder<NotesController>(builder: (noteControl) {
      return Stack(
        children: [
          SafeArea(
            child: Scaffold(
              appBar: const CustomAppBar(
                isBackButtonExist: true,
                title: "NOTES",
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
                              Get.toNamed(RouteHelper.getNotesDashboardRoute(
                                  noteControl.noteList![i].id.toString(),
                                  noteControl.noteList![i].name.toString()));
                              // Get.to(() => NotesSubCategoryScreen(noteListModel: note,
                              //   // childName: note.child![i].name.toString(),
                              //   // childColorString:note.child![i].color.toString(),
                              // ));



                              // noteControl.toggleExpanded(note.id!);
                            },
                            noteListModel:noteControl.noteList![i],
                            // title: note.name.toString(),
                            // colorString: note.color.toString(),

                            // noteListModel: note,
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
          ),
          if (noteControl.isNoteLoading || noteControl.noteList == null)
            const LoaderWidget(),
        ],
      );
    });
  }
}


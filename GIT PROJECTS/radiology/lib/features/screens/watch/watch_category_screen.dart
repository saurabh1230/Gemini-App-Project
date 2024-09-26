import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radiology/controllers/notes_controller.dart';
import 'package:radiology/controllers/watch_controller.dart';
import 'package:radiology/data/repo/note_repo.dart';
import 'package:radiology/data/repo/watch_repo.dart';
import 'package:radiology/features/screens/custom_appbar.dart';
import 'package:radiology/features/screens/notes/components/note_selectio_section.dart';
import 'package:radiology/features/screens/notes/notes_sub_category_screen.dart';
import 'package:radiology/features/screens/watch/watch_sub_category_screen.dart';
import 'package:radiology/features/widgets/custom_loading_widget.dart';
import 'package:radiology/helper/route_helper.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/sizeboxes.dart';
import 'package:radiology/utils/styles.dart';
import 'package:get/get.dart';

class WatchCategoryScreen extends StatefulWidget {
  WatchCategoryScreen({super.key});

  @override
  State<WatchCategoryScreen> createState() => _WatchCategoryScreenState();
}

class _WatchCategoryScreenState extends State<WatchCategoryScreen> {
  final WatchRepo notesRp = Get.put(WatchRepo(apiClient: Get.find()));

  final WatchController notesController = Get.put(WatchController(watchRepo: Get.find()));
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notesController.getWatchList();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WatchController>(builder: (noteControl) {
      return Stack(
        children: [
          SafeArea(
            child: Scaffold(
              appBar: const CustomAppBar(
                isBackButtonExist: true,
                title: "Watch And Learn",
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  notesController.getWatchList();

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
                              Get.to(() => WatchSubCategoryScreen(noteListModel: note,
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
          if (noteControl.isWatchLoading || noteControl.noteList == null)
            const LoaderWidget(),
        ],
      );
    });
  }
}


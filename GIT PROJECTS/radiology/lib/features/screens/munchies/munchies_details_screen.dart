import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radiology/controllers/bookmark_controller.dart';
import 'package:radiology/controllers/munchies_controller.dart';
import 'package:radiology/controllers/notes_controller.dart';
import 'package:radiology/data/repo/munchies_repo.dart';
import 'package:radiology/data/repo/note_repo.dart';
import 'package:radiology/features/screens/custom_appbar.dart';
import 'package:radiology/features/screens/notes/components/notes_view_component.dart';
import 'package:radiology/features/widgets/custom_app_button.dart';
import 'package:radiology/features/widgets/custom_loading_widget.dart';
import 'package:radiology/features/widgets/empty_data_widget.dart';
import 'package:radiology/utils/app_constants.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/images.dart';
import 'package:radiology/utils/sizeboxes.dart';
import 'package:radiology/utils/styles.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';

class MunchiesDetailScreen extends StatelessWidget {
  final String? categoryId;
  final String? categoryName;
  MunchiesDetailScreen({super.key, required this.categoryId, this.categoryName});
  final LoopPageController _loopPageController = LoopPageController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('check');
      Get.find<MunchiesController>().getMunchiesDetailsApi(categoryId);
    });
    return GetBuilder<MunchiesController>(builder: (control) {
      final data = control.munchiesDetails;
      final isListEmpty = data == null;

      return SafeArea(
        child: Scaffold(
          floatingActionButton: IconButton(
            splashColor: Theme.of(context).cardColor,
            icon: Icon(
              CupertinoIcons.arrowshape_turn_up_right_fill,
              color: Theme.of(context).disabledColor,
            ),
            onPressed: () {
              Share.share(AppConstants.shareContent);
            },
          ),
          backgroundColor: Theme.of(context).cardColor,
          appBar: CustomAppBar(
            title: categoryName ?? 'Notes',
            isBackButtonExist: true,
            backGroundColor: Colors.black,
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.paddingSize12,
                      horizontal: Dimensions.paddingSize8,
                    ),
                    color: Theme.of(context).canvasColor,
                    child: Row(
                      children: [

                      ],
                    ),
                  ),
                  isListEmpty && !control.isMunchiesNotesLoading
                      ? Padding(padding: const EdgeInsets.only(
                      top: Dimensions.paddingSize100),
                    child: Center(
                        child: EmptyDataWidget(
                          text: 'No Notes Yet',
                          image: Images.emptyDataBlackImage,
                          fontColor: Theme.of(context).disabledColor,
                        )),
                  ) : Expanded(
                    child: NotesViewComponent(isNotBookmark: true,
                      title: data!.title.toString(),
                      question: data.title.toString(),
                      saveNote: () {
                      },
                      saveNoteColor: Theme.of(context)
                          .cardColor
                          .withOpacity(0.60),
                    ),
                  ),
                ],
              ),
              if (control.isMunchiesDetailsLoading)
                const Center(child: LoaderWidget()),
            ],
          ),
        ),
      );
    });
  }


}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radiology/controllers/basic_controller.dart';
import 'package:radiology/controllers/bookmark_controller.dart';
import 'package:radiology/controllers/notes_controller.dart';
import 'package:radiology/data/repo/basic_repo.dart';
import 'package:radiology/data/repo/note_repo.dart';
import 'package:radiology/features/screens/custom_appbar.dart';
import 'package:radiology/features/screens/notes/components/notes_view_component.dart';
import 'package:radiology/features/widgets/custom_loading_widget.dart';
import 'package:radiology/features/widgets/empty_data_widget.dart';
import 'package:radiology/utils/app_constants.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/images.dart';
import 'package:radiology/utils/styles.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';


class BasicDetailsScreen extends StatelessWidget {
  final String? categoryId;
  final String? categoryName;
  BasicDetailsScreen({super.key, required this.categoryId, this.categoryName});

  final BasicRepo basicRepo = Get.put(BasicRepo(apiClient: Get.find()));
  final BasicController basicController = Get.put(BasicController(basicRepo: Get.find()));

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      basicController.getBasicDetailsApi(categoryId);
    });

    return GetBuilder<BasicController>(builder: (basicControl) {
      final data = basicControl.basicDetails;
      final isListEmpty = data == null;
      final isLoading = basicControl.isBasicDetailsLoading;

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
            title: categoryName ?? 'Back To Basics',
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
                      children: [],
                    ),
                  ),
                  if (isListEmpty && !isLoading)
                    Padding(
                      padding: const EdgeInsets.only(top: Dimensions.paddingSize100),
                      child: Center(
                        child: EmptyDataWidget(
                          text: 'No Notes Yet',
                          image: Images.emptyDataBlackImage,
                          fontColor: Theme.of(context).disabledColor,
                        ),
                      ),
                    )
                  else if (!isListEmpty)
                    Expanded(
                      child: GetBuilder<BookmarkController>(builder: (bookmarkControl) {
                        bool isBookmarked = bookmarkControl.bookmarkBasicIdList.contains(data.id);

                        return NotesViewComponent(
                          title: data.title.toString(), // Ensure data is not null
                          question: data.content.toString(),
                          saveNote: () {
                            isBookmarked
                                ? bookmarkControl.removeNoteBookMarkList(int.parse(data.id.toString()))
                                : bookmarkControl.addNoteBookMarkList('', data);
                          },
                          saveNoteColor: isBookmarked
                              ? Theme.of(context).cardColor
                              : Theme.of(context).cardColor.withOpacity(0.60),
                          isNotBookmark: true,
                        );
                      }),
                    ),
                ],
              ),
              if (isLoading) const Center(child: LoaderWidget()),
            ],
          ),
        ),
      );
    });
  }
}



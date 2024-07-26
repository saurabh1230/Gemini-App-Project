
import 'package:flutter/material.dart';
import 'package:outlier_radiology_app/controllers/notes_controller.dart';
import 'package:outlier_radiology_app/features/screens/auth/widgets/buttons.dart';
import 'package:outlier_radiology_app/features/screens/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:outlier_radiology_app/features/screens/notes/components/notes_view_component.dart';
import 'package:outlier_radiology_app/features/widgets/custom_app_button.dart';
import 'package:outlier_radiology_app/features/widgets/empty_data_widget.dart';
import 'package:outlier_radiology_app/utils/dimensions.dart';
import 'package:outlier_radiology_app/utils/images.dart';
import 'package:outlier_radiology_app/utils/sizeboxes.dart';
import 'package:outlier_radiology_app/utils/styles.dart';

class NotesDashboard extends StatelessWidget {
  final String? categoryId;
  final String? categoryName;

  const NotesDashboard({super.key, required this.categoryId, this.categoryName});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print(categoryId);
      Get.find<NotesController>().getCategoryNoteList(categoryId);
    });

    return GetBuilder<NotesController>(builder: (noteControl) {
      final noteList = noteControl.categoryNoteList;
      final isListEmpty = noteList == null || noteList.isEmpty;

      return Scaffold(
        appBar: CustomAppBar(
          title: categoryName ?? 'Notes',
          isBackButtonExist: true,
          backGroundColor: Colors.black,
        ),
        bottomNavigationBar: noteControl.isCategoryNoteLoading && isListEmpty
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(Dimensions.paddingSize10),
            color: Theme.of(context).canvasColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    noteList?.length ?? 0,
                        (index) {
                      return Container(
                        margin: const EdgeInsets.all(2),
                        width: noteControl.currentIndex == index ? 15 : 6,
                        height: 6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            noteControl.currentIndex == index
                                ? Dimensions.paddingSize5
                                : Dimensions.paddingSizeDefault,
                          ),
                          color: noteControl.currentIndex == index
                              ? Colors.blue
                              : Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    CustomRoundButton(
                      tap: noteControl.previousPage,
                      child: Image.asset(
                        Images.icDoubleArrowBack,
                        height: Dimensions.fontSize10,
                      ),
                    ),
                    sizedBoxW10(),
                    CustomButtonWidget(
                      width: 100,
                      height: Dimensions.paddingSize40,
                      buttonText: 'Next',
                      isBold: false,
                      onPressed: noteControl.nextPage,
                      suffixIconPath: Images.icDoubleArrowRight,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: Dimensions.paddingSize12,
                horizontal: Dimensions.paddingSize8,
              ),
              color: Theme.of(context).hintColor.withOpacity(0.60),
              child: Row(
                children: [
                  Text(
                    'Page ${noteControl.currentIndex + 1}/${noteList?.length ?? 0}',
                    style: poppinsRegular.copyWith(
                      fontSize: Dimensions.fontSize10,
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                ],
              ),
            ),
            isListEmpty
                ? const Padding(
              padding: EdgeInsets.only(top: Dimensions.paddingSize100),
              child: Center(child: EmptyDataWidget()),
            ) : Expanded(
              child: PageView.builder(
                controller: noteControl.pageController,
                itemCount: noteList?.length ?? 0,
                onPageChanged: (index) => noteControl.updateIndex(index),
                itemBuilder: (context, i) {
                  return NotesViewComponent(
                    title: noteList![i].title.toString(),
                    question: noteList[i].content.toString(),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}


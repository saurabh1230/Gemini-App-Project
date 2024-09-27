import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radiology/controllers/basic_controller.dart';
import 'package:radiology/controllers/munchies_controller.dart';
import 'package:radiology/controllers/notes_controller.dart';
import 'package:radiology/data/repo/basic_repo.dart';
import 'package:radiology/data/repo/munchies_repo.dart';
import 'package:radiology/data/repo/note_repo.dart';
import 'package:radiology/features/screens/basics/basic_sub_category.dart';
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

class BasicCategoryScreen extends StatefulWidget {
  BasicCategoryScreen({super.key});

  @override
  State<BasicCategoryScreen> createState() => _BasicCategoryScreenState();
}

class _BasicCategoryScreenState extends State<BasicCategoryScreen> {
  final BasicRepo munchiesRp = Get.put(BasicRepo(apiClient: Get.find()));

  final BasicController controller = Get.put(BasicController(basicRepo: Get.find()));
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getBasicList();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BasicController>(builder: (control) {
      return Stack(
        children: [
          SafeArea(
            child: Scaffold(
              appBar: const CustomAppBar(
                isBackButtonExist: true,
                title: "Back To Basics",
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  controller.getBasicList();
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
                      control.list != null && control.list!.isNotEmpty
                          ? ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeDefault,
                          vertical: Dimensions.paddingSizeDefault,
                        ),
                        itemCount: control.list!.length,
                        shrinkWrap: true,
                        itemBuilder: (_, i) {
                          final note = control.list![i];
                          return NotesSelectionSelection(
                            tap: () {
                              Get.to(() => BasicSubCategoryScreen(noteListModel: note,));

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
          if (control.isBasicLoading || control.isBasicLoading == null)
            const LoaderWidget(),
        ],
      );
    });
  }
}


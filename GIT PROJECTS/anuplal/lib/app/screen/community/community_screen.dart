import 'package:anuplal/app/screen/community/components/post_component.dart';
import 'package:anuplal/app/widgets/custom_appbar.dart';
import 'package:anuplal/app/widgets/custom_buttons.dart';
import 'package:anuplal/utils/sizeboxes.dart';
import 'package:flutter/material.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Community',menuWidget: Row(
        children: [
          CustomNotificationButton(tap: () {  },),
          sizedBoxW10(),
          CustomCartButton(tap: () {  },)
        ],
      ),),
      body: SingleChildScrollView(
        child: ListView.builder(
          itemCount: 6,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_,i) {
          return const PostComponent();
        }),
      ),
    );
  }
}

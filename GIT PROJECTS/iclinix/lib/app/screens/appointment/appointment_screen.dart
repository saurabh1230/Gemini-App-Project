import 'package:flutter/material.dart';
import 'package:iclinix/app/screens/appointment/components/clinic_content_card.dart';
import 'package:iclinix/app/widget/common_widgets.dart';
import 'package:iclinix/app/widget/custom_app_bar.dart';
import 'package:iclinix/app/widget/location_search_field.dart';
import 'package:iclinix/utils/sizeboxes.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(
        title: 'Schedule Appointment',
        menuWidget: Row(
          children: [
            NotificationButton(tap: () {  },)
          ],
        ),
      ),
      body: Column(
        children: [
          TypeAheadFieldWidget(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const ClinicContentCard(),
                  sizedBox100(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

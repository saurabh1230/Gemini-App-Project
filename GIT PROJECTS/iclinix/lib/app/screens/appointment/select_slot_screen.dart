import 'package:flutter/material.dart';
import 'package:iclinix/app/screens/appointment/components/select_slot_card.dart';
import 'package:iclinix/app/widget/common_widgets.dart';
import 'package:iclinix/app/widget/custom_app_bar.dart';
import 'package:iclinix/app/widget/custom_button_widget.dart';
import 'package:iclinix/app/widget/custom_textfield.dart';
import 'package:iclinix/controller/appointment_controller.dart';
import 'package:iclinix/helper/route_helper.dart';
import 'package:iclinix/utils/dimensions.dart';
import 'package:iclinix/utils/sizeboxes.dart';
import 'package:iclinix/utils/styles.dart';
import 'package:get/get.dart';

import 'components/select_slot_time_component.dart';
class SelectSlotScreen extends StatelessWidget {
   SelectSlotScreen({super.key});

  final _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Select Slot',
      menuWidget: Row(
        children: [
          NotificationButton(tap: () {  },),
        ],
      )),
      body: SingleChildScrollView(
        child: GetBuilder<AppointmentController>(builder: (appointmentControl) {
          return  Column(
            children: [
              SelectSlotCard(),
              Padding( padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('APPOINTMENT DATE',style: openSansRegular.copyWith(color: Theme.of(context).hintColor,
                        fontSize: Dimensions.fontSize14),),
                    sizedBox5(),
                    CustomTextField(
                      controller: _dateController,
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: appointmentControl.selectedDate ?? DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );

                        if (pickedDate != null) {
                          appointmentControl.updateDate(pickedDate);
                          _dateController.text = appointmentControl.formattedDate.toString();
                        }
                      },
                      hintText: 'Select',
                      isCalenderIcon: true,
                      editText: true,
                    ),
                    sizedBoxDefault(),
                    SelectSlotTimeComponent()



                  ],
                ),
              ),


            ],
          );
        })




      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: SingleChildScrollView(
          child: CustomButtonWidget(buttonText: 'Continue',
          onPressed: () {
            Get.toNamed(RouteHelper.getAddPatientDetailsRoute());
          },),
        ),
      ),
    );
  }
}

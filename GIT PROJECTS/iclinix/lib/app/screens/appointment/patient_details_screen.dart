import 'package:flutter/material.dart';
import 'package:iclinix/app/widget/common_widgets.dart';
import 'package:iclinix/app/widget/custom_app_bar.dart';
import 'package:iclinix/app/widget/custom_button_widget.dart';
import 'package:iclinix/app/widget/custom_dropdown_field.dart';
import 'package:iclinix/app/widget/custom_textfield.dart';
import 'package:iclinix/controller/appointment_controller.dart';
import 'package:iclinix/helper/route_helper.dart';
import 'package:iclinix/utils/dimensions.dart';
import 'package:iclinix/utils/sizeboxes.dart';
import 'package:get/get.dart';

class PatientDetailsScreen extends StatelessWidget {
  PatientDetailsScreen({super.key});

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dateController = TextEditingController();
  final _problemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            title: 'Patient Details',
            menuWidget: Row(
              children: [
                NotificationButton(
                  tap: () {},
                ),
              ],
            )),
        body: GetBuilder<AppointmentController>(builder: (appointmentControl) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomButtonWidget(
                          height: 40,
                          buttonText: 'New Patient',
                          isBold: false,
                          fontSize: Dimensions.fontSize14,
                          onPressed: () {},
                        ),
                      ),
                      sizedBoxW10(),
                      Expanded(
                        child: CustomButtonWidget(
                          color: Theme.of(context).hintColor.withOpacity(0.0),
                          height: 40,
                          buttonText: 'Follow up Patient',
                          textColor: Theme.of(context).primaryColor,
                          isBold: false,
                          fontSize: Dimensions.fontSize14,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  sizedBoxDefault(),
                  CustomTextField(
                    showTitle: true,
                    capitalization: TextCapitalization.words,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      } else if (RegExp(r'[^\p{L}\s]', unicode: true)
                          .hasMatch(value)) {
                        return 'Full name must not contain special characters';
                      }
                      return null;
                    },
                    controller: _nameController,
                    hintText: 'Full Name',
                  ),
                  sizedBoxDefault(),
                  CustomTextField(
                    controller: _phoneController,
                    isAmount: true,
                    maxLength: 10,
                    showTitle: true,
                    hintText: "Phone No",
                    editText: false,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone number is required';
                      } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                        return 'Enter a valid 10-digit phone number';
                      }
                      return null; // If valid, no error message is returned
                    },
                  ),
                  sizedBoxDefault(),
                  CustomDropdownField(
                    hintText: 'Gender',
                    selectedValue: appointmentControl.selectedGender.isEmpty
                        ? null
                        : appointmentControl.selectedGender,
                    options: appointmentControl.genderOptions,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        // genderController.updateGender(newValue); // Update controller
                      }
                    },
                    showTitle: true, // Set to true to show title
                  ),
                  sizedBoxDefault(),
                  CustomTextField(
                    showTitle: true,
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
                    hintText: 'Date of Birth',
                    isCalenderIcon: true,
                    editText: true,
                  ),
                  sizedBoxDefault(),
                  CustomTextField(
                    showTitle: true,
                    maxLines: 4,
                    controller: _problemController,
                    hintText: 'Write Your Problem',
                  ),
                ],
              ),
            ),
          );
        }),
       bottomNavigationBar: Padding(
         padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
         child: SingleChildScrollView(
           child: CustomButtonWidget(
             isBold: false,
             fontSize: Dimensions.fontSize14  ,
             buttonText: 'Confirm Your Appointment',
           onPressed: () {
               Get.toNamed(RouteHelper.getPaymentMethodRoute());
           },),
         ),
       ),
    );

  }
}

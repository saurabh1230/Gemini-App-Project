import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iclinix/controller/appointment_controller.dart';
import 'package:iclinix/utils/dimensions.dart';
import 'package:iclinix/utils/sizeboxes.dart';
import 'package:iclinix/utils/styles.dart';


class SelectSlotTimeComponent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentController>(
      builder: (appointmentControl) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SELECT APPOINTMENT TIME',style: openSansRegular.copyWith(color: Theme.of(context).hintColor,
                fontSize: Dimensions.fontSize14),),
            sizedBox10(),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3 fruits per row
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                mainAxisExtent: 30
              ),
              itemCount: appointmentControl.timeSlot.length, // Total 9 fruits
              itemBuilder: (context, index) {
                bool isSelected = appointmentControl.selectedIndex == index;
                return GestureDetector(
                  onTap: () {
                    appointmentControl.selectTimeSlot(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.5,
                        color: Theme.of(context).hintColor,

                      ),
                      color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).cardColor, // Change color based on selection
                      borderRadius: BorderRadius.circular(Dimensions.radius10),
                    ),
                    child: Center(
                      child: Text(
                        appointmentControl.timeSlot[index], // Display the fruit name
                        style: openSansRegular.copyWith(
                          fontSize: Dimensions.fontSize12,
                          color:isSelected ? Theme.of(context).cardColor : Theme.of(context).hintColor,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

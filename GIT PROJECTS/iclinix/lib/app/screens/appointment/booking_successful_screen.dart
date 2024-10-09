import 'package:flutter/material.dart';
import 'package:iclinix/app/widget/custom_containers.dart';
import 'package:iclinix/utils/dimensions.dart';
import 'package:iclinix/utils/images.dart';
import 'package:iclinix/utils/sizeboxes.dart';
import 'package:iclinix/utils/styles.dart';
import 'package:iclinix/utils/themes/light_theme.dart';

class BookingSuccessfulScreen extends StatelessWidget {
  const BookingSuccessfulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Images.icBookingSuccessful,height: 160,),
              sizedBox10(),
              Text('Booking Successful!',style: openSansBold.copyWith(color: blueColor,
              fontSize: Dimensions.fontSize20),),
              sizedBox5(),
              Text('You have successfully booked your appointment at',
                textAlign: TextAlign.center,
                style: openSansRegular.copyWith(
                  fontSize: Dimensions.fontSize12,
              color: Theme.of(context).disabledColor.withOpacity(0.70)),),
              sizedBoxDefault(),
              Text('IClinix Advanced Eye And Retina Centre Lajpat Nagar',
                textAlign: TextAlign.center,
                style: openSansRegular.copyWith(
                  fontSize: Dimensions.fontSizeDefault,
                  color: Theme.of(context).disabledColor),),
              sizedBoxDefault(),
              Row(
                children: [
                  Expanded(
                    child: CustomDecoratedContainer(
                        child: Column(children: [
                          Text('On',style: openSansRegular.copyWith(
                            fontSize: Dimensions.fontSize14,
                            color: Theme.of(context).disabledColor.withOpacity(0.70)),),
                          Text('Mon, 02 july 24',
                            textAlign: TextAlign.center,
                            style: openSansSemiBold.copyWith(
                                fontSize: Dimensions.fontSize14,
                                color: Theme.of(context).primaryColor),),



                    ],)),
                  ),
                  sizedBoxW10(),
                  Expanded(
                    child: CustomDecoratedContainer(
                        child: Column(children: [
                          Text('At',style: openSansRegular.copyWith(
                              fontSize: Dimensions.fontSize14,
                              color: Theme.of(context).disabledColor.withOpacity(0.70)),),
                          Text('03:00 PM',
                            textAlign: TextAlign.center,
                            style: openSansSemiBold.copyWith(
                                fontSize: Dimensions.fontSize14,
                                color: Theme.of(context).primaryColor),),



                        ],)),
                  ),
                ],
              )



            ],
          ),
        ),
      ),
    );
  }
}

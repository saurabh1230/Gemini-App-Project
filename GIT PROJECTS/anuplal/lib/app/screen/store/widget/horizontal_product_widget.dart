import 'package:anuplal/app/widgets/custom_button_widget.dart';
import 'package:anuplal/utils/dimensions.dart';
import 'package:anuplal/utils/images.dart';
import 'package:anuplal/utils/sizeboxes.dart';
import 'package:anuplal/utils/styles.dart';
import 'package:flutter/material.dart';

class HorizontalProductWidget extends StatelessWidget {
  final String sectionTitle;
  final List<String> imgList;
  final List<String> titleList;
  final List<String> weightList;
  final List<String> priceList;
  final Function() seeAllTap;
  final Function() productTap;


  const HorizontalProductWidget({
    Key? key,
    required this.sectionTitle,
    required this.imgList,
    required this.titleList,
    required this.weightList,
    required this.priceList,
    required this.seeAllTap,
    required this.productTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                      height: 40,width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius10)
                      ),
                      child: Image.asset(Images.icSeeds,)),
                  sizedBoxW5(),
                  Text(
                    sectionTitle,
                    style: poppinsMedium.copyWith(
                      fontSize: Dimensions.fontSize14,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              TextButton(onPressed: seeAllTap, child: Text('SEE ALL',
              style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
              color: Theme.of(context).hintColor),))
            ],
          ),
          sizedBox10(),
          SizedBox(
            height: 240, // Adjust the height to fit your items.
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imgList.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: productTap,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10), // Add spacing between items
                    child: Container(
                      width: 160, // Adjust width to your needs
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius10),
                        border: Border.all(
                          width: 1,
                          color: Theme.of(context).primaryColor.withOpacity(0.10),
                        ),
                      ),
                      padding: const EdgeInsets.all(Dimensions.paddingSize10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image.asset(
                              imgList[i],
                              width: 100,
                              height: 100,
                            ),
                          ),
                          sizedBox10(),
                          Text(
                            titleList[i],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: poppinsRegular.copyWith(
                              fontSize: Dimensions.fontSize14,
                              color: Theme.of(context).disabledColor.withOpacity(0.80),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  weightList[i],
                                  overflow: TextOverflow.ellipsis,
                                  style: poppinsRegular.copyWith(
                                    fontSize: Dimensions.fontSize12,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  '₹ ${priceList[i]}',
                                  overflow: TextOverflow.ellipsis,
                                  style: poppinsBold.copyWith(
                                    fontSize: Dimensions.fontSize18,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          sizedBox10(),
                          CustomButtonWidget(
                            height: 30,
                            isBold: false,
                            fontSize: Dimensions.fontSize14,
                            buttonText: "Add to Cart",
                            transparent: true,
                            onPressed: () {
                              // Add your onPressed functionality here
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:hexacom_user/common/widgets/custom_directionality_widget.dart';
import 'package:hexacom_user/features/checkout/providers/checkout_provider.dart';
import 'package:flutter/material.dart';
import 'package:hexacom_user/helper/price_converter_helper.dart';
import 'package:hexacom_user/localization/language_constrants.dart';
import 'package:hexacom_user/features/splash/providers/splash_provider.dart';
import 'package:hexacom_user/utill/dimensions.dart';
import 'package:hexacom_user/utill/styles.dart';
import 'package:provider/provider.dart';

class SelectDeliveryTypeWidget extends StatelessWidget {
  final String value;
  final String? title;
  final bool kmWiseFee;
  const SelectDeliveryTypeWidget({super.key, required this.value, required this.title, required this.kmWiseFee});

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckoutProvider>(
      builder: (context, checkoutProvider, child) {
        return InkWell(
          onTap: () => checkoutProvider.setOrderType(value),
          child: Row(
            children: [
              Radio(
                value: value,
                groupValue: checkoutProvider.orderType,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (String? value) => checkoutProvider.setOrderType(value),
              ),
              const SizedBox(width: Dimensions.paddingSizeSmall),

              Text(title!, style: rubikRegular),
              const SizedBox(width: 5),

              kmWiseFee ? const SizedBox() : CustomDirectionalityWidget(
                child: Text('(${value == 'delivery' ? PriceConverterHelper.convertPrice(Provider.of<SplashProvider>(context, listen: false)
                    .configModel!.deliveryCharge) : getTranslated('free', context)})', style: rubikMedium),
              ),

            ],
          ),
        );
      },
    );
  }
}

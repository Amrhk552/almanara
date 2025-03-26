import 'package:almanara/core/constrain/color.dart';
import 'package:almanara/core/constrain/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ServiceCategories extends StatelessWidget {
  const ServiceCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: services.map((service) {
          return Padding(
            padding:
                EdgeInsets.symmetric(horizontal: SizeConfig.widthPercentage(2)),
            child: Column(
              children: [
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(16),
                  child: SvgPicture.asset(
                    service['img'],
                    width: SizeConfig.widthPercentage(18),
                  ),
                ),
                Text(
                  service['label'],
                  style: TextStyle(fontSize: 16, color: brown),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

List<Map<String, dynamic>> services = [
  {'img': 'assets/images/box.svg', 'label': 'بوكس & \nاكسبرس'},
  {'img': 'assets/images/buy_for_me.svg', 'label': 'إشتري لي'},
  {'img': 'assets/images/shipping.svg', 'label': 'شحن الأثاث \nالمنزلي'},
  {'img': 'assets/images/covering.svg', 'label': 'مواد تغليف'},
];

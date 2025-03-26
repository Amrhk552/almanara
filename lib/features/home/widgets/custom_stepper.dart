import 'package:almanara/core/constrain/color.dart';
import 'package:almanara/core/constrain/size_config.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

class CustomStepper extends StatelessWidget {
  final int step;
  const CustomStepper({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
      alignment: Alignment.topCenter,
      height: SizeConfig.heightPercentage(12),
      child: EasyStepper(
        padding: EdgeInsets.zero,
        alignment: Alignment.topCenter,
        internalPadding: 0,
        showStepBorder: false,
        showLoadingAnimation: false,
        fitWidth: true,
        activeStep: step, // الخطوة الحالية
        lineStyle: LineStyle(
            lineLength: SizeConfig.widthPercentage(18),
            lineThickness: 1,
            lineType: LineType.normal,
            lineSpace: 0,
            defaultLineColor: grey, // اللون الرمادي
            finishedLineColor: orange // اللون البرتقالي للخط النشط
            ),
        activeStepTextColor: orange,
        stepRadius: 4, activeStepIconColor: orange,
        activeStepBorderType: BorderType.dotted,
        defaultStepBorderType: BorderType.normal, // حجم النقاط المصمتة
        steps: List.generate(4, (index) {
          bool isActive = index <= step;
          return EasyStep(
            customStep: Container(
              decoration: BoxDecoration(
                color: isActive ? orange : grey, // اللون بناءً على النشاط
                shape: BoxShape.circle,
              ),
            ),
            topTitle: true,
            customTitle: Text(
              titles[index],
              style:
                  TextStyle(fontSize: 10, color: index == step ? orange : grey),
              textAlign: TextAlign.center,
            ),
          );
        }),
      ),
    );
  }
}

// قائمة العناوين
const List<String> titles = [
  'تم الحجز',
  'تأكيد الموعد',
  'في الطريق',
  'استلام الطلب'
];

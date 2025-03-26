import 'package:almanara/core/constrain/size_config.dart';
import 'package:almanara/core/constrain/sized_box.dart';
import 'package:almanara/features/home/widgets/shipment_name_card.dart';
import 'package:flutter/material.dart';
import 'package:almanara/core/constrain/color.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/shipment_model.dart';

class CustomBottomBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomBar(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  bool showBottomSheeet = false;
  PersistentBottomSheetController? _bottomSheetController;

  void _toggleAppointments(BuildContext context) {
    if (showBottomSheeet) {
      _bottomSheetController?.close();
      setState(() {
        showBottomSheeet = false;
      });
    } else {
      _showAppointments(context);
    }
  }

  void _showAppointments(BuildContext context) {
    DateTime today = DateTime.now();
    List<ShipmentModel> todayShipments = [];
    List<ShipmentModel> pastShipments = [];

    for (var shipment in shipments) {
      DateTime shipmentDate = shipment.date;
      if (shipmentDate.year == today.year &&
          shipmentDate.month == today.month &&
          shipmentDate.day == today.day) {
        todayShipments.add(shipment); // إذا كان اليوم، ضفها لقائمة "مواعيدي"
      } else {
        pastShipments.add(shipment); // غير ذلك، ضفها لـ "المواعيد السابقة"
      }
    }
    setState(() {
      showBottomSheeet = true;
    });
    _bottomSheetController = showBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32)),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 25,
                      offset: Offset(0, 4),
                      color: Color.fromRGBO(228, 70, 46, 0.25))
                ]),
            padding: const EdgeInsets.all(16),
            height: SizeConfig.heightPercentage(45),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (todayShipments.isNotEmpty) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text("مواعيـــدي",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: brown)),
                        ),
                        TextButton(
                          onPressed: () {
                            _bottomSheetController?.close();
                            setState(() {
                              showBottomSheeet = false;
                            });
                          },
                          child: Text(
                            'شاهد أقل',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: grey,
                              color: grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: todayShipments.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                            position: index,
                            delay: Duration(milliseconds: index * 10),
                            duration: const Duration(milliseconds: 400),
                            child: ScaleAnimation(
                                child: FadeInAnimation(
                              child: ShipmentNameCard(
                                  shipment: todayShipments[index]),
                            )));
                      },
                    ),
                    sizedBoxHM,
                  ],
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text('المواعيد السابقة'),
                  ),
                  sizedBoxHM,
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: pastShipments.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AnimationConfiguration.staggeredList(
                          position: index,
                          delay: Duration(milliseconds: index * 10),
                          duration: const Duration(milliseconds: 400),
                          child: ScaleAnimation(
                              child: FadeInAnimation(
                            child: ShipmentNameCard(
                                shipment: pastShipments[index]),
                          )));
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    _bottomSheetController?.closed.then((_) {
      if (mounted) {
        setState(() {
          showBottomSheeet = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return BottomAppBar(
      padding: EdgeInsets.symmetric(horizontal: 0),
      height: SizeConfig.heightPercentage(20),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // لون الظل
                blurRadius: 10, // مقدار الضبابية
                spreadRadius: 2, // مدى انتشار الظل
                offset: Offset(0, -2), // اتجاه الظل (أعلى قليلاً)
              ),
            ],
            borderRadius: BorderRadius.circular(32),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                  right: SizeConfig.widthPercentage(40),
                  top: SizeConfig.heightPercentage(4),
                  child: InkWell(
                      customBorder: CircleBorder(),
                      onTap: () {},
                      child: SvgPicture.asset(
                        'assets/icons/add.svg',
                        height: SizeConfig.heightPercentage(9),
                      ))),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          'شحنــــــــاتي',
                          style: TextTheme.of(context).bodyLarge!.copyWith(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10),
                          child: AnimatedRotation(
                            duration: const Duration(milliseconds: 300),
                            turns: showBottomSheeet ? -0.25 : 0,
                            child: SvgPicture.asset(
                              'assets/icons/arrow_right.svg',
                              width: 16,
                            ),
                          ),
                        ),
                        onTap: () => _toggleAppointments(context),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            child: SvgPicture.asset(
                              'assets/icons/home.svg',
                              colorFilter: widget.currentIndex == 0
                                  ? ColorFilter.mode(
                                      brown,
                                      BlendMode.srcIn,
                                    )
                                  : ColorFilter.mode(
                                      grey,
                                      BlendMode.srcIn,
                                    ),
                            ),
                            onTap: () => widget.onTap(0),
                          ),
                          Text(
                            'الرئيسية',
                            style: TextStyle(
                                color: widget.currentIndex == 0 ? brown : null),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                            child: SvgPicture.asset(
                              'assets/icons/calculater.svg',
                              colorFilter: widget.currentIndex == 1
                                  ? ColorFilter.mode(
                                      brown,
                                      BlendMode.srcIn,
                                    )
                                  : null,
                            ),
                            onTap: () => widget.onTap(1),
                          ),
                          Text(
                            'حاسبة الشحن',
                            style: TextStyle(
                                color: widget.currentIndex == 1 ? brown : null),
                          )
                        ],
                      ),
                      SizedBox(
                          width: SizeConfig.widthPercentage(
                              14)), // مساحة لزر الـ +
                      Column(
                        children: [
                          InkWell(
                            child: SvgPicture.asset(
                              'assets/icons/wallet.svg',
                              colorFilter: widget.currentIndex == 2
                                  ? ColorFilter.mode(
                                      brown,
                                      BlendMode.srcIn,
                                    )
                                  : null,
                            ),
                            onTap: () => widget.onTap(2),
                          ),
                          Text(
                            'محفظتي',
                            style: TextStyle(
                                color: widget.currentIndex == 2 ? brown : null),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                            child: SvgPicture.asset(
                              'assets/icons/account.svg',
                              colorFilter: widget.currentIndex == 3
                                  ? ColorFilter.mode(
                                      brown,
                                      BlendMode.srcIn,
                                    )
                                  : null,
                            ),
                            onTap: () => widget.onTap(3),
                          ),
                          Text(
                            'حسابي',
                            style: TextStyle(
                                color: widget.currentIndex == 3 ? brown : null),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

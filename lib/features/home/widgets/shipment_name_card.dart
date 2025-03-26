import 'package:almanara/core/constrain/color.dart';
import 'package:almanara/core/constrain/size_config.dart';
import 'package:almanara/core/constrain/sized_box.dart';
import 'package:almanara/features/home/models/shipment_model.dart';
import 'package:almanara/features/home/widgets/custom_stepper.dart';
import 'package:almanara/features/home/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';

class ShipmentNameCard extends StatefulWidget {
  const ShipmentNameCard({super.key, required this.shipment});
  final ShipmentModel shipment;

  @override
  State<ShipmentNameCard> createState() => _ShipmentNameCardState();
}

class _ShipmentNameCardState extends State<ShipmentNameCard> {
  bool showDetails = false;
  @override
  Widget build(BuildContext context) {
    String formattedDate = formatDate(widget.shipment.date);
    String time = formatTime(widget.shipment.date);
    bool isToday = formattedDate.contains('اليوم');
    void toggileShowDetails() {
      setState(() {
        showDetails = !showDetails;
      });
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(242, 72, 34, 0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: SizeConfig.widthPercentage(33),
                child: Text(
                  textAlign: TextAlign.start,
                  "شحنة ${widget.shipment.title}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: brown,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(
                width: SizeConfig.widthPercentage(23),
                child: !showDetails
                    ? Text(
                        formattedDate,
                        textAlign: TextAlign.start,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 14),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'الموعـــــــــــــد',
                            style: TextStyle(color: lightOrange, fontSize: 8),
                          ),
                          Text(
                            time,
                            style: TextStyle(color: brown),
                          )
                        ],
                      ),
              ),
              if (widget.shipment.completed)
                widget.shipment.rated > 0
                    ? _buildStarRating(widget.shipment.rated)
                    : SizedBox(
                        width: SizeConfig.widthPercentage(20),
                        child: Text(
                          "تم الإلغاء",
                          textAlign: TextAlign.start,
                        ))
              else if (!isToday)
                _buildActionButton(),
              if (isToday)
                Container(
                  width: SizeConfig.widthPercentage(20),
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: AnimatedRotation(
                          duration: const Duration(milliseconds: 300),
                          turns: showDetails ? -0.25 : 0,
                          child: SvgPicture.asset(
                            'assets/icons/arrow_right.svg',
                            width: 16,
                          ),
                        ),
                      ),
                      onTap: () => toggileShowDetails()),
                ),
            ],
          ),
          if (showDetails)
            Column(mainAxisSize: MainAxisSize.min, children: [
              CustomStepper(
                step: 1,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'هل تريد تأكيد الموعد؟',
                  style: TextStyle(fontSize: 10, color: lightOrange),
                ),
              ),
              sizedBoxHS,
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 0,
                                blurRadius: 20,
                                color: Color.fromRGBO(242, 72, 34, 0.5),
                                offset: Offset(0, 4)),
                          ]),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text("نعم، تأكيد",
                            style: TextStyle(color: white)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: orange),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text("لا، إلغاء",
                          style: TextStyle(color: orange)),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // ✅ الخريطة
              Container(
                height: SizeConfig.heightPercentage(13),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      12), // لتطبيق borderRadius على الخريطة
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: LatLng(widget.shipment.latitude,
                          widget.shipment.longitude), // إحداثيات الرياض كمثال
                      initialZoom: 13.0, // مستوى التكبير
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName:
                            'com.example.app', // استبدل باسم تطبيقك
                      ),
                      MarkerLayer(markers: [
                        Marker(
                            point: LatLng(widget.shipment.latitude,
                                widget.shipment.longitude),
                            child: Icon(
                              Icons.location_on,
                              color: orange,
                            ))
                      ])
                    ],
                  ),
                ),
              ),
              sizedBoxHM,
              CustomTextField(
                onDateTimeSelected: (p0) {},
                hint: 'تعديل الموعد',
                suffixIcon: SvgPicture.asset(
                  'assets/icons/edit.svg',
                  fit: BoxFit.contain, // تأكد من عدم تمدد الأيقونة
                ),
              )
            ]),
        ],
      ),
    );
  }

  Widget _buildStarRating(double rating) {
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5; // هل يوجد نصف نجمة؟

    return SizedBox(
      width: SizeConfig.widthPercentage(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ...List.generate(
              fullStars,
              (index) => Icon(Icons.star,
                  color: yellow, size: 3.2 * SizeConfig.blockWidth)),
          if (hasHalfStar)
            Icon(Icons.star_half,
                color: yellow, size: 3.2 * SizeConfig.blockWidth),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    return InkWell(
      onTap: () {},
      child: Container(
          alignment: Alignment.centerLeft,
          width: SizeConfig.widthPercentage(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: orange,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          child: const Text(
            "قيم الآن",
            style: TextStyle(color: white),
          )),
    );
  }
}

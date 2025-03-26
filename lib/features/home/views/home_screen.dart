import 'package:almanara/core/constrain/color.dart';
import 'package:almanara/core/constrain/size_config.dart';
import 'package:almanara/core/constrain/sized_box.dart';
import 'package:almanara/features/home/widgets/custom_bottom_bar.dart';
import 'package:almanara/features/home/widgets/custom_text_field.dart';
import 'package:almanara/features/home/widgets/service_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SvgPicture.asset('assets/images/logo.svg',
            height: SizeConfig.heightPercentage(5)),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              child: SvgPicture.asset('assets/icons/notifications_active.svg'),
            ),
          ),
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                sizedBoxHL,
                ServiceCategories(),
                sizedBoxHM,
                CustomTextField(
                  hint: "اكتب رقم او اسم الشحنة للبحث عنها...",
                  prefixIcon: Icon(Icons.search),
                ),
                sizedBoxHM,
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:swasthyamap/common/widgets/search_field/app_search_field.dart';
import 'package:swasthyamap/core/config/assets/app_vector.dart';
import 'package:swasthyamap/feature/dashboard/presentation/widgets/doctor_card.dart';

import '../../../../common/widgets/containers/app_container.dart';
import '../../../../common/widgets/scaffold/app_scaffold.dart';
import '../../../../common/widgets/text/app_text_widget.dart';
import '../../../../core/config/theme/app_color.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: AppContainer(
          color: AppColor.lightBgColor,
          margin: EdgeInsets.all(10),
          borderRadius: 10,
          onTap: ()=>GoRouter.of(context).pop(),
          child: Icon(Icons.arrow_back_ios_new_outlined,color: AppColor.subTextColor,size: 20,),
        ),
        title: AppTextWidget(text: "Find Doctors",fontSize: 18.sp,fontWeight: FontWeight.w400,),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            AppSearchField(
              hintText: 'Search..',
              prefixIcon: SvgPicture.asset(AppVector.searchIcon2),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: 60.h),
                itemCount: 20,
                  itemBuilder: (context,index){
                return DoctorCard();
              }),
            ),
          ],
        ),
      )
    );
  }
}

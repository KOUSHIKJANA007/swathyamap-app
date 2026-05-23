import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swasthyamap/common/widgets/button/basic_app_button.dart';
import 'package:swasthyamap/common/widgets/containers/app_container.dart';
import 'package:swasthyamap/common/widgets/images/cached_image_container.dart';
import 'package:swasthyamap/common/widgets/text/app_text_widget.dart';
import 'package:swasthyamap/core/config/theme/app_color.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 7),
      borderRadius: 10,
      color: AppColor.lightBgColor,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          offset: const Offset(0, 0),
          blurRadius: 20,
          spreadRadius: 0,
        ),
      ],
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedImageContainer(
                url: "url",
                isImageExist: false,
                height: 100,
                width: 100,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextWidget(
                    text: "Dr. Shruti Kedia",
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    color: AppColor.headingTextColor,
                  ),
                  AppTextWidget(
                    text: "Dentist",
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: AppColor.primaryColor,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextWidget(
                    text: "Next Available",
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: AppColor.primaryColor,
                  ),
                  AppTextWidget(
                    text: "10:00 AM tomorrow",
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: AppColor.subTextColor,
                  ),
                ],
              ),
              BasicAppButton(
                borderRadius: 7,
                btnNameSize: 14.sp,
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 13),
                  buttonName: 'Book Now',
                  onTap: (){
              })
            ],
          )
        ],
      ),
    );
  }
}

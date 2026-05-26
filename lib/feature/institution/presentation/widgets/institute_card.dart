import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:swasthyamap/common/widgets/containers/app_container.dart';
import 'package:swasthyamap/common/widgets/images/cached_image_container.dart';
import 'package:swasthyamap/core/config/assets/app_images.dart';
import 'package:swasthyamap/core/config/routes/route_name.dart';
import 'package:swasthyamap/feature/institution/domain/entities/institute_res_dto.dart';

import '../../../../common/widgets/text/app_text_widget.dart';
import '../../../../core/config/theme/app_color.dart';

class InstituteCard extends StatelessWidget {
  const InstituteCard({super.key, required this.institute});
  final InstituteResDto institute;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      onTap: ()=>GoRouter.of(context).pushNamed(RouteName.instituteDetailsScreen,extra: institute),
      borderRadius: 10,
      color: AppColor.lightBgColor,
      clip: Clip.hardEdge,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          offset: const Offset(0, 0),
          blurRadius: 20,
          spreadRadius: 0,
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedImageContainer(
            url: institute.banner,
            isImageExist: institute.banner.isNotEmpty,
            height: 150,
            width: double.infinity,
            defaultImageUrl: AppImages.instituteDefaultImg,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextWidget(
                  text: institute.name,
                  color: AppColor.darkBgColor,
                  fontWeight: FontWeight.w500,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Colors.red,
                      size: 18,
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: AppTextWidget(
                        text: institute.address,
                        color: AppColor.subTextColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.medical_information_outlined,
                            color: AppColor.primaryColor,
                            size: 18,
                          ),
                          const SizedBox(width: 5),
                          Flexible(
                            child: AppTextWidget(
                              text: "${institute.totalDoctor} Doctors",
                              color: AppColor.subTextColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppTextWidget(
                      text: "View Details",
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

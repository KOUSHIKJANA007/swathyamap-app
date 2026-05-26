import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:swasthyamap/common/widgets/button/basic_app_button.dart';
import 'package:swasthyamap/common/widgets/images/cached_image_container.dart';
import 'package:swasthyamap/common/widgets/scaffold/app_scaffold.dart';
import 'package:swasthyamap/feature/institution/domain/entities/institute_res_dto.dart';

import '../../../../common/widgets/containers/app_container.dart';
import '../../../../common/widgets/text/app_text_widget.dart';
import '../../../../core/config/assets/app_images.dart';
import '../../../../core/config/theme/app_color.dart';

class InstituteDetails extends StatelessWidget {
  const InstituteDetails({super.key, required this.institute});
  final InstituteResDto institute;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: AppTextWidget(
          text: "Institute Details",
          fontWeight: FontWeight.w500,
          color: AppColor.darkBgColor,
        ),
        titleSpacing: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: AppContainer(
          color: AppColor.lightBgColor,
          margin: EdgeInsets.all(10),
          borderRadius: 10,
          onTap: () => GoRouter.of(context).pop(),
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: AppColor.subTextColor,
            size: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppContainer(
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
              child: CachedImageContainer(
                url: institute.banner,
                isImageExist: institute.banner.isNotEmpty,
                height: 200,
                width: double.infinity,
                defaultImageUrl: AppImages.instituteDefaultImg,
                borderRadius: 10,
              ),
            ),
            const SizedBox(height: 15),
            AppContainer(
              padding: EdgeInsets.all(15),
              color: AppColor.lightBgColor,
              width: double.infinity,
              borderRadius: 10,
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
                  AppTextWidget(
                    text: institute.name,
                    color: AppColor.darkBgColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 24.sp,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: AppColor.subTextColor,
                        size: 18,
                      ),
                      const SizedBox(width: 2),
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
                  AppContainer(
                    color: AppColor.primaryColor.withAlpha(35),
                    padding: EdgeInsets.all(10),
                    borderRadius: 10,
                    child: Row(
                      children: [
                        Icon(
                          Icons.groups_outlined,
                          color: AppColor.primaryColor,
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextWidget(
                              text: "Total Doctor",
                              color: AppColor.subTextColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                            ),
                            AppTextWidget(
                              text: "${institute.totalDoctor} doctors",
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: BasicAppButton(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      borderRadius: 7,
                      btnNameSize: 16.sp,
                      icon: Icon(
                        Icons.person_add_alt,
                        color: AppColor.lightBgColor,
                      ),
                      buttonName: 'Add New Doctor',
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            AppTextWidget(
              text: "Facility Directory",
              color: AppColor.darkBgColor,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
            const SizedBox(height: 15),
            AppContainer(
              padding: EdgeInsets.all(10),
              color: AppColor.lightBgColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  offset: const Offset(0, 0),
                  blurRadius: 20,
                  spreadRadius: 0,
                ),
              ],
              borderRadius: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      AppContainer(
                        padding: EdgeInsets.all(10),
                        borderRadius: 7,
                        color: AppColor.primaryColor.withAlpha(35),
                        child: Icon(
                          Icons.groups_outlined,
                          color: AppColor.primaryColor,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextWidget(
                            text: "Manage Doctors",
                            color: AppColor.darkBgColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                          ),
                          AppTextWidget(
                            text: "View and manage doctors",
                            color: AppColor.darkBgColor.withAlpha(150),
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColor.darkBgColor.withAlpha(100),
                    size: 18,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            AppContainer(
              padding: EdgeInsets.all(10),
              color: AppColor.lightBgColor,
              width: double.infinity,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  offset: const Offset(0, 0),
                  blurRadius: 20,
                  spreadRadius: 0,
                ),
              ],
              borderRadius: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextWidget(
                    text: "Facility Information",
                    color: AppColor.darkBgColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                  const SizedBox(height: 15),
                  buildInfoOptions(
                      Icon(Icons.location_on_outlined,color: AppColor.primaryColor),
                      "ADDRESS",
                      institute.address
                  ),
                  const SizedBox(height: 15),
                  buildInfoOptions(
                      Icon(Icons.call,color: AppColor.primaryColor),
                      "CONTACT NUMBER",
                      institute.phone
                  ),
                  const SizedBox(height: 15),
                  buildInfoOptions(
                      Icon(Icons.email_outlined,color: AppColor.primaryColor),
                      "EMAIL",
                      institute.email
                  ),
                ],
              ),
            ),
            SizedBox(height: 60.h)
          ],
        ),
      ),
    );
  }

  Widget buildInfoOptions(Icon icon, String title, String data) {
    if(data.isEmpty) return SizedBox();
    return Row(
      children: [
        AppContainer(
            padding: EdgeInsets.all(10),
            color: AppColor.primaryColor.withAlpha(40),
            borderRadius: 10,
            child: icon),
        const SizedBox(width: 10,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextWidget(
                text: title,
                color: AppColor.darkBgColor.withAlpha(100),
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
              AppTextWidget(
                text: data,
                color: AppColor.darkBgColor,
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

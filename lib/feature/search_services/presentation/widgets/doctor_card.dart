import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swasthyamap/common/widgets/button/basic_app_button.dart';
import 'package:swasthyamap/common/widgets/containers/app_container.dart';
import 'package:swasthyamap/common/widgets/images/cached_image_container.dart';
import 'package:swasthyamap/common/widgets/text/app_text_widget.dart';
import 'package:swasthyamap/core/config/theme/app_color.dart';
import 'package:swasthyamap/core/utils/data_parse_helper/data_parse_helper.dart';
import 'package:swasthyamap/core/utils/date_time_helper/date_time_helper.dart';
import 'package:swasthyamap/core/utils/search_helper/search_helper.dart';
import 'package:swasthyamap/feature/search_services/domain/entities/doctor_search_res_dto.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({super.key, required this.doctor});

  final DoctorSearchResDto doctor;


  String getAvailabilityTitle() {
    return doctor.availableNow ? "Available" : "Next Available";
  }

  String getAvailabilitySubtitle() {
    if (doctor.availableNow) {
      return "${DateTimeHelper.formatDateTime(
        dateTime: doctor.startTime??DateTime.now(),
        format: 'h:mm a',
        toUtc: false,
      )} ${SearchHelper.getDayLabel(doctor.dayOfWeek)}";
    }

    final isNextDay = doctor.endTime != null &&
        doctor.nextAvailableStartTime != null &&
        doctor.endTime!.isBefore(doctor.nextAvailableStartTime!);

    return "${DateTimeHelper.formatDateTime(
      dateTime: doctor.nextAvailableStartTime??DateTime.now(),
      format: 'h:mm a',
      toUtc: false,
    )} ${isNextDay
        ? SearchHelper.getDayLabel(doctor.nextAvailableDay)
        : DataParseHelper.normalizeAndCapitalize(
      doctor.nextAvailableDay,
    )}";
  }

  Widget buildInfoRow({
    required IconData icon,
    required String text,
    Color? iconColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor ?? AppColor.primaryColor,
            size: 15,
          ),
          const SizedBox(width: 5),
          Expanded(
            child: AppTextWidget(
              text: text,
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: AppColor.subTextColor,
              maxLine: 1,
              textOverflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

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
                height: 115,
                width: 100,
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    AppTextWidget(
                      text: doctor.doctorName,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                      color: AppColor.headingTextColor,
                    ),

                    AppTextWidget(
                      text: doctor.specialization,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: AppColor.primaryColor,
                    ),

                    buildInfoRow(
                      icon: Icons.location_on_outlined,
                      iconColor: Colors.red,
                      text: doctor.address,
                    ),

                    buildInfoRow(
                      icon: Icons.circle,
                      text:
                      "${doctor.experienceYears} ${doctor.experienceYears > 1 ? 'years' : 'year'} of experience",
                    ),

                    buildInfoRow(
                      icon: Icons.circle,
                      text:
                      "${doctor.distanceKm.toStringAsFixed(1)} km away",
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  AppTextWidget(
                    text: getAvailabilityTitle(),
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: AppColor.primaryColor,
                  ),

                  const SizedBox(height: 2),

                  AppTextWidget(
                    text: getAvailabilitySubtitle(),
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: AppColor.subTextColor,
                  ),
                ],
              ),

              BasicAppButton(
                borderRadius: 7,
                btnNameSize: 14.sp,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 13,
                ),
                buttonName: 'Book Now',
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

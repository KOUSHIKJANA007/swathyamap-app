import 'package:flutter/material.dart';
import 'package:swasthyamap/common/widgets/containers/app_container.dart';
import 'package:swasthyamap/common/widgets/images/cached_image_container.dart';

import '../../../../common/widgets/text/app_text_widget.dart';
import '../../../../core/config/theme/app_color.dart';

class PopularDoctorCard extends StatelessWidget {
  const PopularDoctorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      color: AppColor.lightBgColor,
      borderRadius: 15,
      clip: Clip.hardEdge,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.18),
          offset: const Offset(0, 0),
          blurRadius: 25,
          spreadRadius: 0,
        ),
      ],
      child: Column(
        children: [
          CachedImageContainer(url: "url",isImageExist: false,width: 190,height: 180,),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                AppTextWidget(
                  text: "Dr. Fillerup Grab",
                  color: AppColor.darkBgColor,
                  fontWeight: FontWeight.w500,
                ),
                AppTextWidget(
                  text: "Medicine Specialist",
                  color: AppColor.subTextColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
                Row(
                  children: List.generate(5, (index)=>
                  Icon(Icons.star,color: index < 3 ? AppColor.starGoldenColor : AppColor.starSilverColor,size: 18)
                  ).toList(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

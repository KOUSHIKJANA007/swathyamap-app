import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swasthyamap/core/config/theme/app_color.dart';

import '../../../core/config/assets/app_vector.dart';
import '../containers/app_container.dart';
import '../text/app_text_widget.dart';

class AppBottomSheet {
  AppBottomSheet._();

  static Future<void> buildImagePickerBottomSheet(BuildContext context, Function(String) onSelect) {
    Widget buildImagePickOption(String name, String icon) {
      return Column(
        children: [
          AppContainer(
            height: 50,
            width: 50,
            padding: EdgeInsets.all(13),
            borderRadius: 50,
            color: AppColor.darkBgColor.withAlpha(25),
            border: Border.all(
              width: 0.5,
              color: AppColor.darkBgColor.withAlpha(25),
            ),
            child: SvgPicture.asset(icon,colorFilter: ColorFilter.mode(AppColor.primaryColor, BlendMode.srcIn),),
          ),
          const SizedBox(height: 10),
          AppTextWidget(
            text: name,
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: AppColor.subTextColor,
          ),
        ],
      );
    }
    return showModalBottomSheet(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      backgroundColor: AppColor.lightBgColor,
      context: context,
      builder: (context) {
        // return ImagePickerOptions(

        //   galleryOnTap: () async {

        // );
        return AppContainer(
          height: 200,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 5),
              Container(
                width: 80,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Row(
                spacing: 20,
                children: [
                  GestureDetector(
                    onTap: () {
                      onSelect('GALLERY');
                    },
                    child: buildImagePickOption(
                      "Gallery",
                      AppVector.pickGalleryIcon,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      onSelect('CAMERA');
                    },
                    child: buildImagePickOption(
                      "Camera",
                      AppVector.pickCameraIcon,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );

  }
  static Future<void> appBottomSheet(BuildContext context,Widget? child) {
    return showModalBottomSheet<String>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Center(
                  child: AppContainer(
                    height: 5,
                    width: 70,
                    color: AppColor.lightGrayColor,
                    borderRadius: 10,
                  ),
                ),
                const SizedBox(height: 20),
                ?child
              ],
            ),
          ),
        ),
      ),
    );
  }
}
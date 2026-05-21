import 'package:flutter/material.dart';
import 'package:swasthyamap/core/config/theme/app_color.dart';

import '../containers/app_container.dart';

class AppBottomSheet {
  AppBottomSheet._();


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
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:swasthyamap/common/widgets/text/app_text_widget.dart';

import '../../../../common/widgets/containers/app_container.dart';
import '../../../../common/widgets/scaffold/app_scaffold.dart';
import '../../../../core/config/theme/app_color.dart';

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({super.key});

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: AppContainer(
          color: AppColor.lightBgColor,
          margin: EdgeInsets.all(10),
          borderRadius: 10,
          onTap: ()=>GoRouter.of(context).pop(),
          child: Icon(Icons.arrow_back_ios_new_outlined,color: AppColor.subTextColor,size: 20,),
        ),
        title: AppTextWidget(text: "Find Doctors",fontSize: 18.sp,fontWeight: FontWeight.w400,),
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}

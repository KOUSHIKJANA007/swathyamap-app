import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:swasthyamap/common/widgets/app_otp_input_fields/app_otp_input_field.dart';
import 'package:swasthyamap/common/widgets/button/basic_app_button.dart';
import 'package:swasthyamap/common/widgets/containers/app_container.dart';
import 'package:swasthyamap/common/widgets/scaffold/app_scaffold.dart';
import 'package:swasthyamap/core/config/routes/route_name.dart';

import '../../../../common/widgets/text/app_text_widget.dart';
import '../../../../core/config/theme/app_color.dart';

class OtpVerifyScreen extends StatefulWidget {
  const OtpVerifyScreen({super.key});

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: AppContainer(
          color: AppColor.lightBgColor,
          margin: EdgeInsets.all(10),
          borderRadius: 10,
          onTap: ()=>GoRouter.of(context).pop(),
          child: Icon(Icons.arrow_back_ios_new_outlined,color: AppColor.subTextColor,size: 20,),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 60),
            AppTextWidget(
              text: "Verification Code",
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
            ),
            AppTextWidget(
              text: "We have sent the verification code to your email address",
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColor.subTextColor,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 80),
            AppOtpInputField(length: 4, controller: _controller),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: BasicAppButton(
                buttonName: 'Confirm',
                onTap: () {
                  GoRouter.of(context).pushNamed(RouteName.loginScreen);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

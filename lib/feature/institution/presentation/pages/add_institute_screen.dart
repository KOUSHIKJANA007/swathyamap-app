import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swasthyamap/common/widgets/loader/basic_loader.dart';
import 'package:swasthyamap/core/extentions/auth_extention.dart';
import '../../../../common/widgets/bottom_sheets/app_bottom_sheet.dart';
import '../../../../common/widgets/button/basic_app_button.dart';
import '../../../../common/widgets/containers/app_container.dart';
import '../../../../common/widgets/dropdowns/app_dropdown.dart';
import '../../../../common/widgets/scaffold/app_scaffold.dart';
import '../../../../common/widgets/text/app_text_widget.dart';
import '../../../../common/widgets/text_input_fields/app_google_address_field.dart';
import '../../../../common/widgets/text_input_fields/app_phone_input_field.dart';
import '../../../../common/widgets/text_input_fields/app_text_input_field.dart';
import '../../../../core/config/theme/app_color.dart';
import '../../../../core/services/image_service/image_picker_service.dart';
import '../../../../core/utils/institute_helper/institute_helper.dart';
import '../../../../injection_container.dart';
import '../bloc/institute_bloc.dart';

class AddInstituteScreen extends StatefulWidget {
  const AddInstituteScreen({super.key});

  @override
  State<AddInstituteScreen> createState() => _AddInstituteScreenState();
}

class _AddInstituteScreenState extends State<AddInstituteScreen> {
  Map<String, dynamic> data = {};
  final _formKey = GlobalKey<FormState>();
  late ImagePickerService imagePickerService;
  File? _image;

  void collectData(String fieldName, dynamic val) {
    data[fieldName] = val;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    imagePickerService = sl();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InstituteBloc, InstituteState>(
      listener: (context, state) {
        if(state is InstituteLoading){
          BasicLoader.show(context);
        }
        if(state is InstituteCreated){
          BasicLoader.hide(context);
          GoRouter.of(context).pop(true);
        }
        if(state is InstituteError){
          BasicLoader.hide(context);
        }
      },
      child: AppScaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: AppTextWidget(
            text: "Add New Institute",
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
          actions: [
            BasicAppButton(
              padding: EdgeInsets.symmetric(horizontal: 15),
              buttonName: 'Save',
              borderRadius: 6,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  context.read<InstituteBloc>().add(
                    CreateInstitute(
                      ownerUserId: context.currentUser!.id,
                        name: data['name'],
                        type: data['type'],
                        description: data['description'],
                        phone: data['phone'],
                        email: data['email'],
                        address: data['address'],
                        city: data['city'],
                        state: data['state'],
                        postalCode: data['pinCode'],
                        image: _image,
                        latitude: 22.163634,
                        longitude: 87.386741
                    ),
                  );
                }
              },
            ),
            const SizedBox(width: 16),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                AppContainer(
                  padding: EdgeInsets.all(15),
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
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.medical_information,
                            color: AppColor.primaryColor,
                            size: 18,
                          ),
                          const SizedBox(width: 5),
                          Flexible(
                            child: AppTextWidget(
                              text: "General Information",
                              color: AppColor.darkBgColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      AppTextInputField(
                        label: "Institute Name",
                        hintText: 'e.g. your medical shop or clinic etc',
                        isRequired: true,
                        value: data['name'],
                        onChange: (val) => collectData('name', val),
                      ),
                      const SizedBox(height: 10),
                      AppDropdown(
                        items: InstituteHelper.instituteTypes,
                        label: "Institute Type",
                        isRequired: true,
                        value: data['type'],
                        onChange: (val) => collectData('type', val),
                      ),
                      const SizedBox(height: 10),
                      AppTextInputField(
                        label: "Description",
                        hintText:
                        "Provide a detailed overview of the institute's mission and facilities.",
                        maxLine: 4,
                        value: data['description'],
                        onChange: (val) => collectData('description', val),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                AppContainer(
                  padding: EdgeInsets.all(15),
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
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.quick_contacts_dialer_outlined,
                            color: AppColor.primaryColor,
                            size: 18,
                          ),
                          const SizedBox(width: 5),
                          Flexible(
                            child: AppTextWidget(
                              text: "Contact Details",
                              color: AppColor.darkBgColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      AppPhoneInputField(
                        label: "Phone",
                        isRequired: true,
                        value: data['phone'],
                        onChange: (val) => collectData('phone', val.completeNumber),
                      ),
                      AppTextInputField(
                        label: "Email",
                        hintText: 'e.g. contact@institute.com',
                        isRequired: true,
                        type: TextInputType.emailAddress,
                        value: data['email'],
                        onChange: (val) => collectData('email', val),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                AppContainer(
                  padding: EdgeInsets.all(15),
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
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: AppColor.primaryColor,
                            size: 18,
                          ),
                          const SizedBox(width: 5),
                          Flexible(
                            child: AppTextWidget(
                              text: "Location Details",
                              color: AppColor.darkBgColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      AppGoogleAddressField(
                        label: "Address",
                        hintText: 'e.g. 123 Medical Plaza',
                        isRequired: true,
                        value: data['address'],
                        onChange: (val) => collectData('address', val),
                      ),
                      const SizedBox(height: 10),
                      AppTextInputField(
                        label: "City",
                        hintText: 'e.g. Kolkata',
                        isRequired: true,
                        value: data['city'],
                        onChange: (val) => collectData('city', val),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: AppDropdown(
                              isRequired: true,
                              items: InstituteHelper.indianStates
                                  .map((data) => {'label': data, 'value': data})
                                  .toList(),
                              label: "State",
                              value: data['state'],
                              onChange: (val) => collectData('state', val),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: AppTextInputField(
                              label: "PIN Code",
                              hintText: 'e.g. 700001',
                              isRequired: true,
                              innerPadding: EdgeInsets.symmetric(
                                  horizontal: 10),
                              value: data['pinCode'],
                              onChange: (val) => collectData('pinCode', val),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                AppContainer(
                  padding: EdgeInsets.all(15),
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
                      Row(
                        children: [
                          Icon(
                            Icons.add_a_photo_outlined,
                            color: AppColor.primaryColor,
                            size: 18,
                          ),
                          const SizedBox(width: 5),
                          Flexible(
                            child: AppTextWidget(
                              text: "Institute Photo",
                              color: AppColor.darkBgColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      AppContainer(
                        onTap: () async {
                          await AppBottomSheet.buildImagePickerBottomSheet(
                            context,
                                (type) async {
                              if (type == 'CAMERA') {
                                var pickedImage = await imagePickerService
                                    .pickImage(ImageSource.camera);
                                int imageLength = await pickedImage!.length();
                                if (imageLength / (1024 * 1024) > 5) {
                                  if (!mounted) return;
                                  // AppSnackBar.showWarning(
                                  //     context,
                                  //     "Please upload photo less then 5 MB "
                                  // );
                                  GoRouter.of(context).pop();
                                  return;
                                }
                                _image = File(pickedImage.path);
                                if (!mounted) return;
                                setState(() {});
                                GoRouter.of(context).pop();
                              } else if (type == 'GALLERY') {
                                var pickedImage = await imagePickerService
                                    .pickImage(ImageSource.gallery);
                                int imageLength = await pickedImage!.length();

                                if (imageLength / (1024 * 1024) > 5) {
                                  if (!mounted) return;
                                  // AppSnackBar.showWarning(
                                  //     context,
                                  //     "Please upload photo less then 5 MB "
                                  // );
                                  GoRouter.of(context).pop();
                                  return;
                                }
                                _image = File(pickedImage.path);
                                if (!mounted) return;
                                setState(() {});
                                GoRouter.of(context).pop();
                              }
                            },
                          );
                        },
                        width: double.infinity,
                        height: 150,
                        padding: EdgeInsets.all(_image == null ? 15 : 0),
                        borderRadius: 10,
                        clip: Clip.hardEdge,
                        color: AppColor.primaryColor.withAlpha(45),
                        border: _image == null
                            ? Border.all(color: AppColor.primaryColor)
                            : null,
                        child: _image == null
                            ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_a_photo_outlined,
                              size: 30,
                              color: AppColor.darkBgColor.withAlpha(55),
                            ),
                            AppTextWidget(
                              text: "Upload High-Res Photo",
                              color: AppColor.darkBgColor.withAlpha(150),
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                            ),
                          ],
                        )
                            : Image.file(_image!, fit: BoxFit.cover),
                      ),
                      const SizedBox(height: 3),
                      AppTextWidget(
                        text: "Minimum 1200x800px. JPG or PNG format only.",
                        color: AppColor.darkBgColor.withAlpha(150),
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 60.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:intl_phone_number_input/intl_phone_number_input_test.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart' as parser;
import '../../../core/config/theme/app_color.dart';
import '../text/app_text_widget.dart';

class AppPhoneInputField extends StatefulWidget {
  const AppPhoneInputField({
    super.key,
    this.focusColor = AppColor.primaryColor,
    this.borderRadius = 10.0,
    required this.label,
    this.innerPadding,
    required this.isRequired,
    this.onChange,
    this.value,
    this.hintText,
     this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon
  });

  final Color focusColor;
  final double borderRadius;
  final String label;
  final EdgeInsetsGeometry? innerPadding;
  final bool isRequired;
  final void Function(PhoneNumber)? onChange;
  final String? value;
  final String? hintText;
  final bool readOnly;
  final Icon? prefixIcon;
  final Widget? suffixIcon;

  @override
  State<AppPhoneInputField> createState() =>
      _AppPhoneInputFieldState();
}

class _AppPhoneInputFieldState extends State<AppPhoneInputField> {
  final TextEditingController _controller=TextEditingController();
  String _isoCode = 'IN';


  @override
  void initState() {
    super.initState();
   WidgetsBinding.instance.addPostFrameCallback((_){
    Future.delayed(Duration(seconds: 1),()=>setPhoneNumber());
   });
  }
  void setPhoneNumber()async{
   if(widget.value?.isNotEmpty??false){
     final phoneNumber = await PhoneNumberTest.getRegionInfoFromPhoneNumber(widget.value??'');
     _controller.text = phoneNumber.parseNumber();
     if(phoneNumber.isoCode?.isNotEmpty??false){
       _isoCode = phoneNumber.isoCode!;
     }
     setState(() {

     });
   }
  }
  String getDialCode(String isoCode) {
    try {
      final country = countries.firstWhere(
            (c) => c.code == isoCode,
      );
      return '+${country.dialCode}';
    } catch (e) {
      return '';
    }
  }
  @override
  void didUpdateWidget(covariant AppPhoneInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    final mobile = widget.value ?? '';

    final updatedText =
    mobile.replaceFirst(getDialCode(_isoCode), "");

    // IMPORTANT:
    // update only if text actually changed
    // otherwise cursor jumps to end
    if (_controller.text != updatedText) {

      final selection = _controller.selection;

      _controller.value = TextEditingValue(
        text: updatedText,
        selection: TextSelection.collapsed(
          offset: selection.baseOffset.clamp(
            0,
            updatedText.length,
          ),
        ),
      );
    }
  }
  @override
  void dispose() {
    _controller.clear();
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextWidget(
          text: widget.isRequired ? "${widget.label} *" : widget.label,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColor.subTextColor.withOpacity(0.9),
        ),
        const SizedBox(height: 4),
        IntlPhoneField(
          key: ValueKey(_isoCode),
          controller: _controller,
          onChanged: widget.onChange,
          initialCountryCode: _isoCode,
          onCountryChanged: (country){
            _isoCode = country.code;
            setState(() {

            });
          },
          validator: (val) {
            if (val?.number == null || val!.number.isEmpty) {
              return "${widget.label} is required";
            }
            try {
              final phone = parser.PhoneNumber.parse(val.number);

              if (!phone.isValid()) {
                return "Invalid ${widget.label}";
              }
            } catch (e) {
              return "Invalid ${widget.label}";
            }
            return null;
          },
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(width: 1.0,  color: AppColor.darkBgColor.withAlpha(25)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(width: 1.0, color: widget.focusColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: const BorderSide(
                color: Color(0xFFCA0E05),
                width: 1.0,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: const BorderSide(
                color: Color(0xFFCA0E05),
                width: 1.0,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(width: 1.0, color: AppColor.lightBgColor.withAlpha(25)),
            ),
          ),
        ),
      ],
    );
  }
}

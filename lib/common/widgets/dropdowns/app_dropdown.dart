import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/config/theme/app_color.dart';
import '../text/app_text_widget.dart';

class AppDropdown extends StatefulWidget {
  const AppDropdown({
    super.key,
    this.onChange,
    required this.items,
    this.value,
    this.isRequired = false,
    this.readOnly = false,
    required this.label,
    this.borderRadius = 10.0,
  });

  final void Function(String?)? onChange;
  final List<Map<String, String>> items;
  final String? value;
  final String label;
  final bool isRequired;
  final bool readOnly;
  final double borderRadius;
  @override
  State<AppDropdown> createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
  late final ValueNotifier<String?> _selectedValue;


  @override
  void initState() {
    super.initState();

    _selectedValue = ValueNotifier(
      _normalizeValue(widget.value),
    );
  }

  @override
  void didUpdateWidget(covariant AppDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);

    final newValue = _normalizeValue(widget.value);

    if (_selectedValue.value != newValue) {
      _selectedValue.value = newValue;
    }
  }

  String? _normalizeValue(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    return value;
  }

  @override
  void dispose() {
    _selectedValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uniqueItems = {
      for (var item in widget.items)
        if (item['value'] != null) item['value']!: item
    }.values.toList();

    final dropdownItems = uniqueItems
        .map((item) => DropdownItem<String>(
      value: item['value']!,
      height: 40.h,
      child: AppTextWidget(
        text: item['label'] ?? '',
        fontSize: 16.sp,
        color: AppColor.subTextColor,
        fontWeight: FontWeight.w400,
      ),
    ))
        .toList();

    return FormField<String>(
      initialValue: _selectedValue.value,
      validator: (value) {
        if (widget.isRequired && (value == null || value.isEmpty)) {
          return "${widget.label} is required";
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (state) {
        final isError = state.hasError;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextWidget(
              text: widget.isRequired
                  ? "${widget.label} *"
                  : widget.label,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: isError
                  ? Colors.red
                  : AppColor.subTextColor.withOpacity(0.9),
            ),
            const SizedBox(height: 4),

            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,

                hint: AppTextWidget(
                  text: 'Select ${widget.label}',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: isError
                      ? Colors.red
                      : AppColor.subTextColor.withAlpha(180),
                  maxLine: 1,
                  textOverflow: TextOverflow.ellipsis,
                ),

                items: dropdownItems,
                valueListenable: _selectedValue,

                onChanged: widget.readOnly
                    ? null
                    : (value) {
                  _selectedValue.value = value;

                  state.didChange(value); // 🔥 IMPORTANT

                  widget.onChange?.call(value);
                },

                buttonStyleData: ButtonStyleData(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(widget.borderRadius),
                    border: Border.all(
                      color: isError
                          ? Colors.red
                          : AppColor.darkBgColor.withAlpha(25),
                    ),
                  ),
                  elevation: 0,
                ),

                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: AppColor.lightBgColor,
                  ),
                ),

                iconStyleData: IconStyleData(
                  icon: const Icon(Icons.keyboard_arrow_down),
                  iconSize: 16.sp,
                  iconEnabledColor: AppColor.subTextColor,
                  iconDisabledColor: AppColor.subTextColor,
                ),
              ),
            ),

            // 🔴 Error Message (clean)
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 4),
                child: AppTextWidget(
                  text: state.errorText!,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.red,
                ),
              ),
          ],
        );
      },
    );
  }
}

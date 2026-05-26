import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import '../../../core/config/theme/app_color.dart';
import '../text/app_text_widget.dart';

class AppGoogleAddressField extends StatefulWidget {
  final Color focusColor;
  final double borderRadius;
  final String? label;
  final String? hintText;
  final bool isLabelVisible;
  final TextStyle? hintTextStyle;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final bool isBorderVisible;
  final EdgeInsetsGeometry? innerPadding;
  final void Function(String?)? onChange;
  final void Function(String?)? onSelect;
  final void Function()? onClear;
  final String? value;
  final bool isRequired;

  const AppGoogleAddressField(
      {super.key,
        this.focusColor = AppColor.primaryColor,
        this.label,
        this.hintText,
        this.borderRadius = 10.0,
        this.onChange,
        this.onClear,
        this.innerPadding,
        this.value,
        this.isRequired = false,
        this.isBorderVisible = true,
        this.isLabelVisible = true,
        this.prefixIcon,
        this.hintTextStyle,
        this.onSelect, this.suffixIcon});

  @override
  State<AppGoogleAddressField> createState() => _AppGoogleAddressFieldState();
}

class _AppGoogleAddressFieldState extends State<AppGoogleAddressField> {
  var uuid = const Uuid();
  String _sessionToken = '';
  List<dynamic> _placeList = [];
  OverlayEntry? _overlayEntry;
  final TextEditingController _controller = TextEditingController();
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.value ?? '';
  }

  @override
  void didUpdateWidget(covariant AppGoogleAddressField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.value != null &&
        widget.value != _controller.text) {

      final cursorPosition = _controller.selection;

      _controller.value = TextEditingValue(
        text: widget.value!,
        selection: cursorPosition.copyWith(
          baseOffset: cursorPosition.baseOffset.clamp(
            0,
            widget.value!.length,
          ),
          extentOffset: cursorPosition.extentOffset.clamp(
            0,
            widget.value!.length,
          ),
        ),
      );
    }
  }

  void _onChanged() {
    if (widget.value?.isEmpty ?? true) {
      _removeOverlay();
      return;
    }

    if (_sessionToken.isEmpty) {
      _sessionToken = uuid.v4();
    }

    getSuggestion(widget.value ?? '');
  }

  String getPlacesApiKey() {
    if (Platform.isAndroid) {
      return dotenv.env['GOOGLE_PLACES_ANDROID_KEY'] ?? '';
    } else if (Platform.isIOS) {
      return dotenv.env['GOOGLE_PLACES_IOS_KEY'] ?? '';
    } else {
      return '';
    }
  }

  void getSuggestion(String input) async {
    final String placesApiKey = getPlacesApiKey(); // <-- Replace here

    try {
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request =
          '$baseURL?input=$input&key=$placesApiKey&sessiontoken=$_sessionToken';

      var response = await http.get(Uri.parse(request));
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          _placeList = data['predictions'];
        });
        _showOverlay();
      } else {
        throw Exception('Failed to load predictions');
      }
    } catch (e) {
      debugPrint("Error fetching suggestions: $e");
    }
  }

  void _showOverlay() {
    _removeOverlay();

    final overlay = Overlay.of(context);

    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: const Offset(0, 50),
          showWhenUnlinked: false,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 250),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: _placeList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      spacing: 5,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.location_on, color: Colors.red),
                        Expanded(child: Text(_placeList[index]["description"])),
                      ],
                    ),
                    onTap: () {
                      widget.onChange?.call(_placeList[index]["description"]);
                      widget.onSelect?.call(_placeList[index]["description"]);
                      _removeOverlay();
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextWidget(
            text: widget.label??'',
            fontSize: 14,fontWeight: FontWeight.w400,
            color: AppColor.subTextColor.withOpacity(0.9)
        ),
        const SizedBox(height: 4),
        CompositedTransformTarget(
          link: _layerLink,
          child: TextFormField(
            controller: _controller,
            validator: (val) {
              if (widget.isRequired && (val == null || val.isEmpty)) {
                return "${widget.label} is required";
              } else {
                return null;
              }
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (val) {
              widget.onChange?.call(val);
              _onChanged();
            },
            decoration: InputDecoration(
              contentPadding: widget.innerPadding,
              prefixIcon:widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              hintText: widget.hintText,
              hintStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 14.sp,color: AppColor.subTextColor.withOpacity(0.8)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: BorderSide(
                      width: 1.0, color: AppColor.darkBgColor.withAlpha(25))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: BorderSide(
                      width: 1.0,
                      color: widget.focusColor)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: const BorderSide(
                      color: Color(0xFFCA0E05), width: 1.0)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: const BorderSide(
                      color: Color(0xFFCA0E05), width: 1.0)),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(width: 1.0, color: Colors.grey.shade400),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

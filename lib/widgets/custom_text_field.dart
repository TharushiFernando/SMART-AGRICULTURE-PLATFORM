import 'package:flutter/material.dart';

import '../color_resources/color_resources.dart';
import '../dimensions.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String label;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final Color? fillColor;
  final int maxLines;
  final bool isPassword;
  final bool isCountryPicker;
  final bool isShowBorder;
  final bool isIcon;
  final bool readOnly;
  final bool isShowSuffixIcon;
  final bool isShowPrefixIcon;
  final Function()? onTap;
  final Function(String?)? onChanged;
  final String? suffixIconUrl;
  final Widget? suffixIcon;
  final String? prefixIconUrl;
  final bool isSearch;
  final bool disabled;
  final languageProvider;

  const CustomTextField(
      {Key? key,
      this.hintText = 'Write something...',
      this.label = '',
      this.controller,
      this.focusNode,
      this.nextFocus,
      this.inputType = TextInputType.text,
      this.inputAction = TextInputAction.next,
      this.maxLines = 1,
      this.fillColor,
      this.isCountryPicker = false,
      this.isShowBorder = false,
      this.isShowSuffixIcon = false,
      this.isShowPrefixIcon = false,
      this.onTap,
      this.onChanged,
      this.isIcon = false,
      this.isPassword = false,
      this.suffixIconUrl,
      this.suffixIcon,
      this.prefixIconUrl,
      this.isSearch = false,
      this.readOnly = false,
      this.disabled = false,
      this.languageProvider})
      : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label.isNotEmpty
            ? Text(
                widget.label,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              )
            : SizedBox(),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).cardColor,
              border: Border.all(
                  color: widget.isShowBorder
                      ? ColorResources.BORDER_COLOR!
                      : Colors.transparent)),
          child: TextField(
            maxLines: widget.maxLines,
            controller: widget.controller,
            focusNode: widget.focusNode,
            enabled: !widget.disabled,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Colors.black, fontSize: Dimensions.FONT_SIZE_LARGE),
            textInputAction: widget.inputAction,
            keyboardType: widget.inputType,
            cursorColor: ColorResources.COLOR_PRIMARY,
            readOnly: widget.readOnly,
            //onChanged: widget.isSearch ? widget.languageProvider.searchLanguage : null,
            obscureText: widget.isPassword ? _obscureText : false,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 22),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(style: BorderStyle.none, width: 0),
              ),
              isDense: true,
              hintText: widget.hintText,
              fillColor: widget.fillColor ?? Theme.of(context).cardColor,
              hintStyle: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: Dimensions.FONT_SIZE_SMALL,
                  color: ColorResources.BORDER_COLOR),
              filled: true,
              prefixIcon: widget.isShowPrefixIcon
                  ? Padding(
                      padding: const EdgeInsets.only(
                          left: Dimensions.PADDING_SIZE_LARGE,
                          right: Dimensions.PADDING_SIZE_SMALL),
                      child: Image.asset(widget.prefixIconUrl!),
                    )
                  : const SizedBox.shrink(),
              prefixIconConstraints:
                  const BoxConstraints(minWidth: 23, maxHeight: 20),
              suffixIcon: widget.isShowSuffixIcon
                  ? widget.isPassword
                      ? IconButton(
                          icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color:
                                  Theme.of(context).hintColor.withOpacity(.3)),
                          onPressed: _toggle)
                      : widget.isIcon
                          ? widget.suffixIcon ??
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: Dimensions.PADDING_SIZE_LARGE,
                                    right: Dimensions.PADDING_SIZE_SMALL),
                                child: Image.asset(
                                  widget.suffixIconUrl!,
                                  width: 15,
                                  height: 15,
                                ),
                              )
                          : null
                  : null,
            ),
            onTap: widget.onTap,
            // onChanged: (value) {
            //   // print(value);
            //   setState(() {
            //     widget.onChanged!(value);
            //   });
            // },
            onSubmitted: (text) => widget.nextFocus != null
                ? FocusScope.of(context).requestFocus(widget.nextFocus)
                : null,

            onChanged: widget.onChanged,
          ),
        ),
      ],
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}

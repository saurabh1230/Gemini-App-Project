import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/styles.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool isPassword;
  final Function? onChanged;
  final Function? onSubmit;
  final bool isEnabled;
  final int maxLines;
  final TextCapitalization capitalization;
  final String? prefixImage;
  final IconData? prefixIcon;
  final bool divider;
  final bool showTitle;
  final bool isAmount;
  final bool isNumber;
  final bool isPhone;
  final bool showBorder;
  final double iconSize;
  final bool isRequired;
  final Color? fillColor;
  final Color? borderColor;
  final Color? hintColor;
  final FormFieldValidator<String>? validation;

  const CustomTextField(
      {Key? key, this.hintText = 'Write something...',
        this.controller,
        this.focusNode,
        this.nextFocus,
        this.isEnabled = true,
        this.inputType = TextInputType.text,
        this.inputAction = TextInputAction.next,
        this.maxLines = 1,
        this.onSubmit,
        this.onChanged,
        this.prefixImage,
        this.prefixIcon,
        this.capitalization = TextCapitalization.none,
        this.isPassword = false,
        this.divider = false,
        this.showTitle = false,
        this.isAmount = false,
        this.isNumber = false,
        this.isPhone = false,
        this.showBorder = true,
        this.iconSize = 18,
        this.isRequired = false,
        this.validation, this.fillColor, this.borderColor, this.hintColor,
      }) : super(key: key);

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.showTitle ? Text(widget.hintText, style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize5)) : const SizedBox(),
        SizedBox(height: widget.showTitle ? Dimensions.paddingSize5 : 0),
        TextFormField(
          validator: widget.validation,
          maxLines: widget.maxLines,
          controller: widget.controller,
          focusNode: widget.focusNode,
          style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize18,color:widget.hintColor ?? Theme.of(context).cardColor.withOpacity(0.40)),
          textInputAction: widget.inputAction,
          keyboardType: widget.isAmount ? TextInputType.number : widget.inputType,
          cursorColor: Theme.of(context).primaryColor,
          textCapitalization: widget.capitalization,
          enabled: widget.isEnabled,
          autofocus: false,
          autofillHints: widget.inputType == TextInputType.name ? [AutofillHints.name]
              : widget.inputType == TextInputType.emailAddress ? [AutofillHints.email]
              : widget.inputType == TextInputType.phone ? [AutofillHints.telephoneNumber]
              : widget.inputType == TextInputType.streetAddress ? [AutofillHints.fullStreetAddress]
              : widget.inputType == TextInputType.url ? [AutofillHints.url]
              : widget.inputType == TextInputType.visiblePassword ? [AutofillHints.password] : null,
          obscureText: widget.isPassword ? _obscureText : false,
          inputFormatters: widget.inputType == TextInputType.phone ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9+]'))]
              : widget.isAmount ? [FilteringTextInputFormatter.allow(RegExp(r'\d'))] : widget.isNumber ? [FilteringTextInputFormatter.allow(RegExp(r'\d'))] : null,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSize10),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius5),
              borderSide: BorderSide(style: widget.showBorder ? BorderStyle.solid : BorderStyle.none, width: 0.3, color: widget.borderColor ?? Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius5),
              borderSide: BorderSide(style: widget.showBorder ? BorderStyle.solid : BorderStyle.none, width: 1, color: widget.borderColor ?? Colors.transparent),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius5),
              borderSide: BorderSide(style: widget.showBorder ? BorderStyle.solid : BorderStyle.none, width: 0.3, color: widget.borderColor ??Colors.transparent),
            ),
            isDense: true,
            hintText: widget.hintText,
            fillColor: widget.fillColor ?? Theme.of(context).hintColor,
            hintStyle: poppinsRegular.copyWith(fontSize: Dimensions.fontSize13, color: widget.hintColor ?? Theme.of(context).cardColor.withOpacity(0.40)),
            filled: true,
            prefixIcon: widget.isPhone ? SizedBox(width: 95, child: Row(children: [
              Container(
                  width: 85,height: 50,
                  decoration:  const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius5),
                      bottomLeft: Radius.circular(Dimensions.radius5),
                    ),
                  ),
                  margin: const EdgeInsets.only(right: 0),
                  padding: const EdgeInsets.only(left: 5),
                  child: const SizedBox()),

              Container(
                height: 20, width: 2,
                color: Theme.of(context).disabledColor,
              )
            ]),
            ) : widget.prefixImage != null && widget.prefixIcon == null ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSize10),
              child: Image.asset(widget.prefixImage!, height: 20, width: 20),
            ) : widget.prefixImage == null && widget.prefixIcon != null ? Icon(widget.prefixIcon, size: widget.iconSize,color: widget.hintColor ??Theme.of(context).cardColor.withOpacity(0.40),) : null,
            suffixIcon: widget.isPassword ? IconButton(
              icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color:widget.hintColor ?? Theme.of(context).cardColor.withOpacity(0.40)),
              onPressed: _toggle,
            ) : null,
          ),
          // onSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus)
          //     : widget.onSubmit != null ? widget.onSubmit!(text) : null,
          onChanged: widget.onChanged as void Function(String)?,
        ),

        widget.divider ? const Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault), child: Divider()) : const SizedBox(),
      ],
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}




// class CustomTextField extends StatefulWidget {
//   final String hintText;
//   final TextEditingController? controller;
//   final FocusNode? focusNode;
//   final FocusNode? nextFocus;
//   final TextInputType inputType;
//   final TextInputAction inputAction;
//   final bool isPassword;
//   final Function? onChanged;
//   final Function? onSubmit;
//   final bool isEnabled;
//   final int maxLines;
//   final TextCapitalization capitalization;
//   final String? prefixIcon;
//   final bool divider;
//   final bool showTitle;
//   final bool isAmount;
//   final bool isNumber;
//   final bool showShadow;
//
//   const CustomTextField(
//       {Key? key, this.hintText = 'Write something...',
//         this.controller,
//         this.focusNode,
//         this.nextFocus,
//         this.isEnabled = true,
//         this.inputType = TextInputType.text,
//         this.inputAction = TextInputAction.next,
//         this.maxLines = 1,
//         this.onSubmit,
//         this.onChanged,
//         this.prefixIcon,
//         this.capitalization = TextCapitalization.none,
//         this.isPassword = false,
//         this.divider = false,
//         this.showTitle = false,
//         this.isAmount = false,
//         this.isNumber = false,
//         this.showShadow = false,
//       }) : super(key: key);
//
//   @override
//   CustomTextFieldState createState() => CustomTextFieldState();
// }
//
// class CustomTextFieldState extends State<CustomTextField> {
//   bool _obscureText = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//
//         widget.showTitle ? Text(widget.hintText, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall)) : const SizedBox(),
//         SizedBox(height: widget.showTitle ? Dimensions.paddingSizeExtraSmall : 0),
//
//         Container(
//           decoration: widget.showShadow ? BoxDecoration(
//             color: Theme.of(context).cardColor,
//             borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
//             boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 800 : 200]!, spreadRadius: 1, blurRadius: 5, offset: const Offset(0, 5))],
//           ) : null,
//           child: TextField(
//             maxLines: widget.maxLines,
//             controller: widget.controller,
//             focusNode: widget.focusNode,
//             style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge),
//             textInputAction: widget.inputAction,
//             keyboardType: widget.isAmount ? TextInputType.number : widget.inputType,
//             cursorColor: Theme.of(context).primaryColor,
//             textCapitalization: widget.capitalization,
//             enabled: widget.isEnabled,
//             autofocus: false,
//             autofillHints: widget.inputType == TextInputType.name ? [AutofillHints.name]
//                 : widget.inputType == TextInputType.emailAddress ? [AutofillHints.email]
//                 : widget.inputType == TextInputType.phone ? [AutofillHints.telephoneNumber]
//                 : widget.inputType == TextInputType.streetAddress ? [AutofillHints.fullStreetAddress]
//                 : widget.inputType == TextInputType.url ? [AutofillHints.url]
//                 : widget.inputType == TextInputType.visiblePassword ? [AutofillHints.password] : null,
//             obscureText: widget.isPassword ? _obscureText : false,
//             inputFormatters: widget.inputType == TextInputType.phone ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9+]'))]
//                 : widget.isAmount ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))] : widget.isNumber ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))] : null,
//             decoration: InputDecoration(
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
//                 borderSide: const BorderSide(style: BorderStyle.none, width: 0),
//               ),
//               isDense: true,
//               hintText: widget.hintText,
//               fillColor: Theme.of(context).cardColor,
//               hintStyle: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).hintColor),
//               filled: true,
//               prefixIcon: widget.prefixIcon != null ? Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
//                 child: Image.asset(widget.prefixIcon!, height: 20, width: 20),
//               ) : null,
//               suffixIcon: widget.isPassword ? IconButton(
//                 icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: Theme.of(context).hintColor.withOpacity(0.3)),
//                 onPressed: _toggle,
//               ) : null,
//             ),
//             onSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus)
//                 : widget.onSubmit != null ? widget.onSubmit!(text) : null,
//             onChanged: widget.onChanged as void Function(String)?,
//           ),
//         ),
//
//         widget.divider ? const Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge), child: Divider()) : const SizedBox(),
//       ],
//     );
//   }
//
//   void _toggle() {
//     setState(() {
//       _obscureText = !_obscureText;
//     });
//   }
// }

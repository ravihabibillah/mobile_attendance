import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.hint,
    required this.label,
    this.onChanged,
    this.onSubmit,
    this.validator,
    this.autovalidateMode,
    this.suffixIcon,
    this.keyboardType,
    this.controller,
    this.focusNode,
    this.isObscure = false,
    this.readOnly = false,
    this.onTap,
    this.minLines = 1,
    this.maxLines = 1,
  });
  final String label;
  final String hint;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;
  // final Widget? validationWidget;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool isObscure;
  final bool readOnly;
  final Function()? onTap;
  final int? minLines;
  final int? maxLines;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          TextFormField(
            onTap: widget.onTap,
            readOnly: widget.readOnly,
            focusNode: widget.focusNode,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            autovalidateMode: widget.autovalidateMode,
            validator: widget.validator,
            onChanged: widget.onChanged,
            onFieldSubmitted: widget.onSubmit,
            obscureText: widget.isObscure,
            minLines: widget.minLines,
            maxLines: widget.maxLines,
            decoration: InputDecoration(
              hintText: widget.hint,
              // hintStyle: AppTextStyle.secondaryColor500Regular,
              fillColor: Colors.white,
              // filled: true,
              suffixIcon: widget.suffixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomTextFiled extends StatelessWidget {
  final bool isPassword;
  final String lable;
  final Color filedColors;
  final Widget? suffixicon;
  final String? Function(String?)? validator;
  final TextEditingController textController;
  final GlobalKey<FormState> formState;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final TextInputType keyboardType;
  final Iterable<String>? autofillHints;
  const CustomTextFiled(
      {super.key,
      required this.isPassword,
      required this.lable,
      required this.filedColors,
      this.suffixicon,
      required this.validator,
      required this.textController,
      required this.formState,
      this.focusNode,
      this.onFieldSubmitted,
      required this.keyboardType,
      this.autofillHints});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formState,
      child: TextFormField(
        autofillHints: autofillHints,
        obscureText: isPassword,
        cursorColor: filedColors,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            label: Text(lable),
            labelStyle: TextStyle(color: filedColors),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            suffixIcon: suffixicon,
            suffixIconColor: filedColors,
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: filedColors),
              borderRadius: const BorderRadius.all(Radius.circular(50)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(color: Colors.red),
            )),
        validator: validator,
        controller: textController,
      ),
    );
  }
}

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:smartbank/shared/themes.dart';

class InputField extends StatefulWidget {
  final String labelText;
  final String type;
  final String hintText;
  final TextEditingController  stateName;
  const InputField(
      {required this.labelText,
      this.type = 'false',
      required this.hintText,
      required this.stateName,
      Key? key})
      : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: textBlackStyle.copyWith(
              fontWeight: FontWeight.w500, fontSize: 14),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          style: textWhiteGreyStyle,
          obscureText: widget.type == 'password' ? true : false,
          controller: widget.stateName,
          keyboardType: widget.type == 'email'
              ? TextInputType.emailAddress
              : TextInputType.text,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Primary, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: borderColor, width: 1.5),
            ),
            focusColor: Colors.red,
            labelStyle: TextStyle(color: TextBlack),
            hintText: widget.hintText,
            contentPadding: EdgeInsets.all(9), // Added this
        
          ),
        ),
      ],
    );
  }
}

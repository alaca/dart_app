import 'package:flutter/material.dart';


final InputDecoration authScreenTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.fromLTRB(10.0, 18.0, 10.0, 18.0),
  fillColor: Colors.white,
  filled: true,
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(40.0),
    borderSide: BorderSide(
      width: 1.00,
      color: Color(0xFFF44336)
    )
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(40.0),
    borderSide: BorderSide.none
  ),
  alignLabelWithHint: true,
  errorMaxLines: 2
);
import 'package:flutter/material.dart';

// 2 formas de fazer a mesma coisa 
void unFocus(BuildContext context)=> FocusScope.of(context).unfocus();

extension unFocusExtension on BuildContext {
  void unFocus() => Focus.of(this).unfocus(); 
}
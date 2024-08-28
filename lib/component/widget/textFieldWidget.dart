import 'package:flutter/material.dart';

Widget TextFieldWidget(BuildContext context, String title, double size, Color bgColor, Color mainColor, TextEditingController controller, {double? heith, int? maxLines, bool? isObscure}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
      const SizedBox(height: 9,),
      Container(
        width: size,
        height: heith ?? 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: bgColor
        ),
        child: TextField(
          controller: controller,
          maxLines: maxLines ?? 1,
          obscureText: isObscure ?? false,
          decoration: InputDecoration(
              border: InputBorder.none,
              focusColor: mainColor,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width:1.5,color: mainColor),
              )
          ),
        ),
      ),
    ],
  );
}
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tasksblok/shared/cubit/cubit.dart';

// ignore: must_be_immutable
class KMainEelevatedButtom extends StatelessWidget {
  String? textchild;
  Function function;
  double borderradius;
  Color? textcolor;
  double? fontsize;
  double? width;
  double? height;
  Color? backgroundcolor;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? margin;
  KMainEelevatedButtom(
      {super.key,
      required this.function,
      this.textchild,
      required this.borderradius,
      this.textcolor,
      this.backgroundcolor,
      this.margin,
      this.padding,
      this.fontsize,
      this.height,
      this.width});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      child: ElevatedButton(
          onPressed: function(),
          style: ElevatedButton.styleFrom(
              backgroundColor: backgroundcolor,
              padding: padding,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderradius))),
          child: Text(
            '$textchild',
            style: TextStyle(color: textcolor, fontSize: fontsize),
          )),
    );
  }
}

//====================================================================

class KMainTextFormFeld extends StatelessWidget {
  Function functionontap;
  TextEditingController? controller;
  bool? filled;
  Color? fillcolor;
  double? hintfontSize;
  FontWeight? hintfontweidth;
  Color? hintcolor;
  String? hintText;
  Widget? label;
  TextStyle? labelStyle;
  String? Function(String? val)? validator;

  TextInputType? keyboardType;

  BorderRadius borderradiusoutlineinputeborder;
  BorderRadius borderradiusoutlineenabledborder;
  BorderRadius borderradiusoutlinefocusedborder;
  BorderRadius borderradiusoutlineerrorborder;

  Color coloroutlineinputborder;
  Color coloroutlinefocusedborder;
  Color coloroutlineerrorborder;
  Color coloroutlineenableborder;
  double widthoutlineinputborder;
  double widthoutlinefocusedborder;
  double widthoutlineerrorborder;
  double widthoutlineenableborder;

  Widget? suffixIcon;
  Widget? prefixIcon;

  KMainTextFormFeld({
    super.key,
    this.fillcolor,
    this.filled,
    this.hintcolor,
    this.hintfontSize,
    this.hintfontweidth,
    required this.functionontap,
    this.controller,
    required this.coloroutlineinputborder,
    required this.coloroutlinefocusedborder,
    required this.coloroutlineerrorborder,
    required this.coloroutlineenableborder,
    required this.widthoutlineinputborder,
    required this.widthoutlinefocusedborder,
    required this.widthoutlineerrorborder,
    required this.widthoutlineenableborder,
    required this.borderradiusoutlineinputeborder,
    required this.borderradiusoutlineenabledborder,
    required this.borderradiusoutlinefocusedborder,
    required this.borderradiusoutlineerrorborder,
    this.hintText,
    this.keyboardType,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.label,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      onTap: () {
        functionontap();
      },
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,

        prefixIcon: prefixIcon,
        // contentPadding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
        label: label,
        labelStyle: labelStyle,
        hintText: hintText,
        fillColor: fillcolor,
        filled: filled,
        errorStyle: TextStyle(height: 0, color: Colors.transparent),
        hintStyle: TextStyle(
          fontSize: hintfontSize,
          color: hintcolor,
          fontWeight: hintfontweidth,
        ),
        // ignore: prefer_const_constructors
        border: OutlineInputBorder(
            borderRadius: borderradiusoutlineinputeborder,
            borderSide: BorderSide(
                color: coloroutlineinputborder,
                width: widthoutlineinputborder)),
        enabledBorder: OutlineInputBorder(
            borderRadius: borderradiusoutlineenabledborder,
            borderSide: BorderSide(
                color: coloroutlineenableborder,
                width: widthoutlineenableborder)),
        focusedBorder: OutlineInputBorder(
            borderRadius: borderradiusoutlinefocusedborder,
            borderSide: BorderSide(
                color: coloroutlinefocusedborder,
                width: widthoutlinefocusedborder)),
        errorBorder: OutlineInputBorder(
          borderRadius: borderradiusoutlineerrorborder,
          borderSide: BorderSide(
              color: coloroutlineerrorborder, width: widthoutlineerrorborder),
        ),
      ),
      style: TextStyle(
        fontSize: 16,
        color: Color(0xFF3C3C43),
      ),
    );
  }
}

//=================================================
//widget buildTasksItem

Widget buildTasksItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35,
              child: Text('${model['time']}'),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .updateData(status: 'done', id: model['id']);
                },
                icon: Icon(Icons.check_box)),
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .updateData(status: 'archived', id: model['id']);
                },
                icon: Icon(Icons.archive))
          ],
        ),
      ),
    );

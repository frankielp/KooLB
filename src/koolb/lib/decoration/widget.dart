import 'package:flutter/material.dart';
import 'color.dart';

class CompanyItem extends StatelessWidget {
  CompanyItem(
      {Key? key,
      // required this.data,
      this.bgColor = Colors.white,
      this.color = primary,
      this.selected = false,
      this.onTap})
      : super(key: key);
  // final data;
  final Color bgColor;
  final Color color;
  final bool selected;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 110,
        height: 110,
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.1),
              spreadRadius: .5,
              blurRadius: 1,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: color.withOpacity(.3)),
            child: Icon(Icons.house, color: color),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'test name',
            maxLines: 1,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
              child: Text(
            'test type',
            style: TextStyle(fontSize: 12, color: darker),
          )),
          Visibility(
            visible: selected,
            child: Container(
              width: double.infinity,
              height: 2,
              decoration: BoxDecoration(color: primary),
            ),
          ),
        ]),
      ),
    );
  }
}

class CustomImage extends StatelessWidget {
  const CustomImage(this.name,
      {this.width = 100,
      this.height = 100,
      this.bgColor,
      this.borderWidth = 0,
      this.borderColor,
      this.trBackground = false,
      this.isNetwork = true,
      this.radius = 50});
  final String name;
  final double width;
  final double height;
  final double borderWidth;
  final Color? borderColor;
  final Color? bgColor;
  final bool trBackground;
  final bool isNetwork;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
        image: DecorationImage(image: NetworkImage(name), fit: BoxFit.cover),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  CategoryItem(
      {Key? key, required this.data, this.selected = false, this.onTap})
      : super(key: key);
  final data;
  final bool selected;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
        margin: EdgeInsets.only(right: 10),
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          color: selected ? primary : cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.1),
              spreadRadius: .5,
              blurRadius: .5,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(data["icon"],
                size: 25, color: selected ? Colors.white : Colors.black),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: Text(
                data["name"],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 13, color: selected ? Colors.white : darker),
              ),
            ),
            // Visibility(
            //     visible: selected,
            //     child: Container(
            //       width: double.infinity, height: 2,
            //       decoration: BoxDecoration(
            //         color: primary,
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}

class CustomTextBox extends StatelessWidget {
  CustomTextBox(
      {Key? key,
      this.hint = "",
      this.prefix,
      this.suffix,
      this.controller,
      this.readOnly = false})
      : super(key: key);
  final String hint;
  final Widget? prefix;
  final Widget? suffix;
  final bool readOnly;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 3),
      height: 40,
      decoration: BoxDecoration(
        color: textBoxColor,
        border: Border.all(color: textBoxColor),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.05),
            spreadRadius: .5,
            blurRadius: .5,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: TextField(
        readOnly: readOnly,
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: prefix,
            suffixIcon: suffix,
            border: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 15)),
      ),
    );
  }
}

class IconBox extends StatelessWidget {
  IconBox(
      {Key? key,
      required this.child,
      this.bgColor,
      this.onTap,
      this.borderColor = Colors.transparent,
      this.radius = 50})
      : super(key: key);
  final Widget child;
  final Color borderColor;
  final Color? bgColor;
  final double radius;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: borderColor),
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

class PropertyItem extends StatelessWidget {
  PropertyItem({Key? key, required this.data}) : super(key: key);
  final data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 240,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.1),
            spreadRadius: .5,
            blurRadius: 1,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Stack(
        children: [
          CustomImage(
            data["image"],
            radius: 25,
            width: double.infinity,
            height: 150,
          ),
          Positioned(
              right: 20,
              top: 130,
              child: IconBox(
                child: Icon(
                  data["is_favorited"] ? Icons.favorite : Icons.favorite_border,
                  color: Colors.white,
                  size: 20,
                ),
                bgColor: red,
              )),
          Positioned(
              left: 15,
              top: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data["name"],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.place_outlined,
                        color: darker,
                        size: 13,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        data["location"],
                        style: TextStyle(fontSize: 13, color: darker),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    data["price"],
                    style: TextStyle(
                        fontSize: 15,
                        color: primary,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

class SettingItem extends StatelessWidget {
  final IconData? leadingIcon;
  final Color? leadingIconColor;
  final String title;
  final GestureTapCallback? onTap;
  const SettingItem(
      {Key? key,
      required this.title,
      this.onTap,
      this.leadingIcon,
      this.leadingIconColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
          color: cardColor,
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: leadingIcon != null
                ? [
                    Container(
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: cardColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: shadowColor.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Icon(
                        leadingIcon,
                        size: 24,
                        color: leadingIconColor,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: labelColor,
                      size: 14,
                    )
                  ]
                : [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: labelColor,
                      size: 14,
                    )
                  ],
          ),
        ),
      ),
    );
  }
}

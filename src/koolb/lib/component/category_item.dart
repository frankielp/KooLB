import 'package:flutter/material.dart';
import 'package:koolb/decoration/color.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem(
      {Key? key,
      required this.data,
      this.selected = false,
      this.onTap,
      this.icon})
      : super(key: key);
  final data;
  final icon;
  final bool selected;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        padding: EdgeInsets.fromLTRB(3, 10, 5, 5),
        margin: EdgeInsets.only(right: 10),
        width: size.width * 0.20,
        height: size.width * 0.13,
        decoration: BoxDecoration(
          color: selected ? BlueJean : LightBlue2,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: .5,
              blurRadius: .5,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              height: 20,
              width: 20,
              color: selected ? Colors.white : DarkBlue,
            ),
            const SizedBox(
              height: 3,
            ),
            Expanded(
              child: Center(
                child: Text(
                  data,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 11,
                      color: selected ? Colors.white : Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

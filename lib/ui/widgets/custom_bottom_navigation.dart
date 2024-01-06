import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class CustomBottomNavigation extends StatelessWidget {
  final String imageUrl;
  final String title;
  final bool isSelected;

  const CustomBottomNavigation({
    Key? key,
    required this.imageUrl,
    required this.title,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                imageUrl,
              ),
            ),
          ),
        ),
        Text(
          title,
          style: blueTextStyle.copyWith(
            fontSize: 12,
            color: isSelected ? kPrimaryColor : kGrayColor,
          ),
        ),
      ],
    );
  }
}

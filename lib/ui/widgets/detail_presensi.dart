import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class DetailPresensi extends StatelessWidget {
  final String title;

  const DetailPresensi({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(),
          SizedBox(width: 12),
          Flexible(
            flex: 10,
            // Add this
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: grayTextStyle.copyWith(
                fontSize: 15,
              ),
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.all(8.0), // Add padding to the text
            decoration: BoxDecoration(
              color: kGreenColor,
              borderRadius: BorderRadius.circular(100.0), // Add border radius
            ),
            child: Text(
              'PRESENT',
              style: whiteTextStyle.copyWith(
                fontSize: 10,
                fontWeight: medium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

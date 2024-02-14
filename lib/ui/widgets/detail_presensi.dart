import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class DetailPresensi extends StatelessWidget {
  final String title;
  final String status;

  const DetailPresensi({super.key, required this.title, required this.status});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (status) {
      case 'Present':
        statusColor = kGreenColor;
        break;
      case 'Absent':
        statusColor = kRedColor;
        break;
      case 'Pending':
        statusColor = kGreyColor3;
        break;
      default:
        statusColor = kGrayColor;
    }

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
            padding: EdgeInsets.all(6.0),
            constraints: BoxConstraints(minWidth: 60),
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: Center(
              child: Text(
                status.toUpperCase(),
                style: whiteTextStyle.copyWith(
                  fontSize: 10,
                  fontWeight: medium,
                  color: Colors.white, // Set the text color to white
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

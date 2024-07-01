import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../shared/theme.dart';

class ItemChat extends StatelessWidget {
  final bool isSender;
  final String message;
  final String time;

  const ItemChat({
    super.key,
    required this.isSender,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: isSender ? kGreyColor : Color(0xFF696CFF),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: isSender ? Radius.circular(15) : Radius.circular(0),
                bottomRight:
                    isSender ? Radius.circular(0) : Radius.circular(15),
              ),
            ),
            padding: EdgeInsets.all(15),
            child: Text(
              message,
              style: isSender
                  ? blackTextStyle.copyWith(fontSize: 15)
                  : whiteTextStyle.copyWith(fontSize: 15),
            ),
          ),
          SizedBox(height: 5),
          Text(DateFormat.jm().format(DateTime.parse(time))),
        ],
      ),
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
    );
  }
}

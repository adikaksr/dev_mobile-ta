import 'package:easkripsi/cubit/page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/theme.dart';

final icons = {
  'home': Icons.home_rounded,
  'form': Icons.assignment_rounded,
  'bimbingan': Icons.chat_bubble_rounded,
  'jadwal': Icons.calendar_today_rounded,
  'kehadiran': Icons.assignment_turned_in_rounded,
  'mahasiswa': Icons.group,
};

class CustomBottomNavigation extends StatelessWidget {
  final int index;
  final String iconKey;
  final String title;
  final BuildContext context;

  const CustomBottomNavigation({
    Key? key,
    required this.index,
    required this.iconKey,
    required this.title,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<PageCubit>().setPage(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icons[iconKey], // Use 'iconKey' to look up the IconData
            color: context.read<PageCubit>().state == index
                ? kPrimaryColor
                : kGrayColor,
          ),
          Text(
            title,
            style: blueTextStyle.copyWith(
              fontSize: 12,
              color: context.read<PageCubit>().state == index
                  ? kPrimaryColor
                  : kGrayColor,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../constants/AppStyle.dart';

class DateTimeWidget extends StatelessWidget {
  const DateTimeWidget({
    super.key,
    required this.icon,
    required this.text,
    required this.title,
    required this.onTap,
  });
  final IconData icon;
  final String text;
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyle.headingStyle,
          ),
          Gap(6),
          Material(
            child: Ink(
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => onTap(),
                child: Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) =>
                          Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: [
                        Icon(icon),
                        Gap(12),
                        Text(
                          text,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

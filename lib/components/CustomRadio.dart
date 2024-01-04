import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/RadioProvider.dart';

class CustomRadio extends StatelessWidget {
  const CustomRadio({
    super.key,
    required this.color,
    required this.text,
    required this.value,
    required this.onChange,
  });
  final Color color;
  final String text;
  final int value;
  final VoidCallback onChange;
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Theme(
      data: ThemeData(unselectedWidgetColor: color),
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final radio = ref.watch(radioProvider);
          return RadioListTile(
            contentPadding: EdgeInsets.zero,
            activeColor: color,
            value: value,
            groupValue: radio,
            onChanged: (_) => onChange(),
            title: Transform.translate(
              offset: const Offset(-15, 0),
              child: Text(text,
                  style: TextStyle(
                      color: color, fontWeight: FontWeight.w500, fontSize: 11)),
            ),
          );
        },
      ),
    ));
  }
}

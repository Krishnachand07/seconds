import 'package:flutter/material.dart';

class CardElement extends StatelessWidget {
  final String title;
  final int time;
  const CardElement({super.key, required this.time, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: 15,
          left: title != 'Current seconds' ? 7.5 : 15,
          right: title == 'Current seconds' ? 7.5 : 15,
          bottom: 15),
      height: 150,
      decoration: BoxDecoration(
          color: title == 'Current seconds'
              ? const Color(0xFFdde8fa)
              : const Color(0xFFdfd5e6),
          border: Border.all(
              color: title == 'Current seconds'
                  ? const Color(0xFF9badce)
                  : const Color(0xFFbdabc8)),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          Text(
            time.toString(),
            style: const TextStyle(
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}

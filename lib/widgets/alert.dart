import 'package:flutter/material.dart';

enum AlertStatus { success, error }

class AlertElement extends StatelessWidget {
  final int? value;
  final AlertStatus? status;
  final bool? timeOut;

  const AlertElement({super.key, this.value, this.status, this.timeOut});

  @override
  Widget build(BuildContext context) {
    final success = status == AlertStatus.success;
    return Container(
      margin: const EdgeInsets.all(15),
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
          color: success ? const Color(0xFF549f54) : const Color(0xFFedb949),
          border: Border.all(
              color:
                  success ? const Color(0xFF4d934d) : const Color(0xFFdcab43)),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              success
                  ? 'Success :)'
                  : (timeOut != null && timeOut!)
                      ? 'Sorry timeout need to restart!'
                      : 'Sorry try again! :(',
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Divider(
            color: success ? const Color(0xFF4d934d) : const Color(0xFFdcab43),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              success
                  ? 'SCORE: $value/5'
                  : (timeOut != null && timeOut!)
                      ? 'Tap refresh'
                      : 'Attempts: $value',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}

import 'dart:async';
import 'dart:math';

import 'package:exercise/widgets/alert.dart';
import 'package:exercise/widgets/card.dart';
import 'package:flutter/material.dart';

class Base extends StatefulWidget {
  const Base({super.key});

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {
  int time = 0;
  int randomNum = 0;
  int enableTimer = 5;
  int score = 0;
  int attempt = 3;
  late Timer timer;
  Random random = Random();
  bool isSuccess = false;

  @override
  void initState() {
    super.initState();
    timer = Timer(Duration.zero, () {});
    timer.cancel();
  }

  void startTimer() {
    enableTimer = 5;
    if (score == 5) {
      score = 0;
    }
    timer = Timer.periodic(const Duration(milliseconds: 1000), (_) {
      updateTime();
      randomNumber();
      updateEnableTimer();
    });
    setState(() {});
  }

  void updateEnableTimer() {
    if (enableTimer <= 0) {
      return;
    }
    enableTimer--;
    setState(() {});
  }

  void stopTimer() {
    timer.cancel();
    isSuccess = time == randomNum;
    if (isSuccess) {
      score++;
    } else if (attempt > 0) {
      attempt--;
    }
    setState(() {});
  }

  void randomNumber() {
    for (int i = 0; i < 10; i++) {
      setState(() {
        randomNum = random.nextInt(59);
      });
    }
  }

  void updateTime() => setState(() {
        time++;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent,
        title: const Text('Seconds matcher'),
      ),
      body: Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: CardElement(
                  time: time,
                  title: 'Current seconds',
                )),
                Expanded(
                    child: CardElement(
                  time: randomNum,
                  title: 'Random number',
                ))
              ],
            ),
            Visibility(
                visible: enableTimer == 0,
                child: const AlertElement(
                  status: AlertStatus.error,
                  timeOut: true,
                )),
            Visibility(
                visible: !timer.isActive && (time != 0 && randomNum != 0),
                child: isSuccess
                    ? AlertElement(value: score, status: AlertStatus.success)
                    : AlertElement(value: attempt, status: AlertStatus.error)),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Stack(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: CircularProgressIndicator(
                          strokeCap: StrokeCap.round,
                          strokeWidth: 9,
                          backgroundColor: Colors.grey[300],
                          color: Colors.green,
                          value: enableTimer / 5),
                    ),
                    Positioned(
                        top: 33,
                        bottom: 0,
                        left: 4,
                        right: 0,
                        child: Text(
                          '0:0$enableTimer',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 25),
                        )),
                  ],
                ),
              ),
            ),
            Expanded(
                child: Container(
              alignment: Alignment.bottomCenter,
              child: FilledButton(
                style: ButtonStyle(backgroundColor:
                    MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.yellow;
                  } else if (states.contains(MaterialState.disabled)) {
                    return Colors.grey[300];
                  }
                  return Colors.yellow;
                })),
                onPressed: (enableTimer > 0) && attempt > 0
                    ? timer.isActive
                        ? stopTimer
                        : startTimer
                    : null,
                child: Text(
                  timer.isActive ? 'STOP' : 'START',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ))
          ],
        ),
      ),
      floatingActionButton: enableTimer == 0
          ? FloatingActionButton(
              backgroundColor: Colors.yellow,
              onPressed: () {
                timer.cancel();
                startTimer();
              },
              child: const Icon(Icons.refresh),
            )
          : null,
    );
  }
}

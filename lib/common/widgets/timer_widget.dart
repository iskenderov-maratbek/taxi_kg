import 'dart:async';
import 'package:flutter/material.dart';
import 'package:taxi_kg/common/widgets/button_widgets.dart';
import 'package:taxi_kg/views/misc/misc_methods.dart';

class TimerWidget extends StatefulWidget {
  final int hours;
  final int munites;
  final int seconds;

  final Function endOfTimerFunction;

  final String endOfTimerText;

  const TimerWidget(
      {super.key,
      this.hours = 0,
      this.munites = 0,
      this.seconds = 0,
      required this.endOfTimerFunction,
      required this.endOfTimerText});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Timer? countdownTimer;
  late Duration startValue;
  @override
  void initState() {
    startValue = Duration(hours: widget.hours, minutes: widget.munites, seconds: widget.seconds);
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    countdownTimer!.cancel();
    super.dispose();
  }

  void startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void resetTimer() {
    stopTimer();
    setState(() => startValue =
        Duration(hours: widget.hours, minutes: widget.munites, seconds: widget.seconds));
  }

  void setCountDown() {
    setState(() {
      if (startValue.inSeconds - 1 < 0) {
        countdownTimer!.cancel();
      } else {
        startValue = Duration(seconds: startValue.inSeconds - 1);
        logInfo(' ${startValue.inSeconds - 1}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final hours = '${strDigits(startValue.inHours.remainder(24))}:';
    final minutes = '${strDigits(startValue.inMinutes.remainder(60))}:';
    final seconds = strDigits(startValue.inSeconds.remainder(60));
    final result = '${widget.hours > 0 ? hours : ''}$minutes$seconds';
    return startValue.inSeconds > 0
        ? alternativeSecondaryButton(result, onPressed: () {})
        : alternativeSecondaryButton(widget.endOfTimerText,
            onPressed: () => widget.endOfTimerFunction());
  }
}

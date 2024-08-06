// import 'dart:async';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:taxi_kg/views/misc/misc_methods.dart';

// class TimerService {
//   Timer? countdownTimer;
//   TimerService() {
//     _timerValue.add( const Duration(seconds: 0));
//   }
//   late Duration startValue;
//   void startTimer() {
//     countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
//   }

//   final _timerValue = StreamController<Duration>();
//   Stream<Duration> timerStateChanges() => _timerValue.stream;

//   void stopTimer() {
//     countdownTimer!.cancel();
//   }

//   void setCountDown() {
//     if (startValue.inSeconds - 1 < 0) {
//       countdownTimer!.cancel();
//     } else {
//       startValue = Duration(seconds: startValue.inSeconds - 1);
//       logInfo(' ${startValue.inSeconds - 1}');
//     }
//   }

//   dispose() {
//     _timerValue.close();
//   }
// }

// final timerServiceProvider = Provider.autoDispose<TimerService>((ref) {
//   final timer = TimerService();
//   ref.onDispose(() => timer.dispose());
//   return timer;
// }, name: 'Сервис авторизации');

// final timerStateChangesProvider = StreamProvider.autoDispose<Duration>((ref) {
//   return TimerService.timerStateChanges();
// }, name: 'TIME VALUE');

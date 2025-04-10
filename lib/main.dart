import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxi_kg/common/utils/app_theme.dart';
import 'package:taxi_kg/common/widgets/dialog_forms.dart';
import 'package:taxi_kg/providers/provider_logger.dart';
import 'package:taxi_kg/providers/providers.dart';
import 'package:taxi_kg/services/auth_service.dart';
import 'package:taxi_kg/views/auth/pin_code_view.dart';
import 'package:taxi_kg/views/main_view.dart';
import 'package:taxi_kg/views/misc/custom_transition.dart';
import 'package:taxi_kg/views/auth/authPage/auth_view.dart';
import 'package:taxi_kg/views/auth/register_view.dart';
import 'package:taxi_kg/views/home/home.dart';
import 'package:taxi_kg/views/misc/misc_methods.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      observers: [
        ProviderLogger(),
      ],
      child: const TaxiKg(),
    ),
  );
}

class TaxiKg extends ConsumerWidget {
  const TaxiKg({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    logBuild('Запуск приложения TaxiKG');
    Map<String, Widget> onGenerateRoute = {
      '/home': const Home(),
      '/auth': const AuthView(),
      '/register': const RegisterView(),
      '/pincode-email': const PinCodeView(),
      // '/pincode-phone': const PinCodeView(),
    };

    return MaterialApp(
      onGenerateRoute: (settings) {
        return CustomRoute(
          builder: (context) => onGenerateRoute[settings.name]!,
        );
      },
      debugShowCheckedModeBanner: false,
      title: 'TaxiKG',
      theme: AppTheme.appThemeData(),
      home: const AuthView(),
    );
  }
}

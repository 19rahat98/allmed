import 'package:allmed/common/contants/global_common_constants.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/address/user_address/presentation/cubit/address_cubit.dart';
import 'package:allmed/feature/auth/presentation/global_auth/cubit/global_auth_cubit.dart';
import 'package:allmed/feature/orders/presentation/order_history/cubit/order_history_cubit.dart';
import 'package:allmed/feature/splash/presentation/splash_screen.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:allmed/di/di_locator.dart' as di_locator;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di_locator.initLocator();
  /// установка ориентации
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GlobalAuthCubit>(
          create: (_) => GlobalAuthCubit()..startAuth(),
        ),
        BlocProvider<AddressCubit>(
          create: (_) => AddressCubit(),
        ),
        BlocProvider<OrderHistoryCubit>(
          create: (_) => OrderHistoryCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: GlobalCommonConstants.appName,
        locale: S.delegate.supportedLocales.first,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: AppThemeConstants.accentColor),
        ),
        home: const AppSplashScreen(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:iplay/core/functions/theme_colors.dart';
import 'package:iplay/core/injection/injecao_dependencias.dart';
import 'package:iplay/core/services/snackbar_service.dart';
import 'package:iplay/ui/redirecionamento/redirecionamento_presenter.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await injecaoDependencias();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
      child: MaterialApp(
        navigatorKey: SnackBarService.navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
          useMaterial3: true,
          scaffoldBackgroundColor: const Color.fromARGB(255, 218, 236, 250),
          appBarTheme: const AppBarTheme(
            backgroundColor: ThemeColors.primary,
            elevation: 0,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              textStyle: WidgetStateProperty.all(
                const TextStyle(color: Colors.white),
              ),
            ),
          ),
          cardTheme: const CardTheme(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            elevation: 2,
            margin: EdgeInsets.all(0),
          ),
          iconButtonTheme: IconButtonThemeData(
            style: ButtonStyle(
              padding: WidgetStateProperty.all(EdgeInsets.zero),
              visualDensity: VisualDensity.compact,
            ),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: ThemeColors.primary),
          dialogTheme: const DialogTheme(backgroundColor: ThemeColors.backgroundScreen),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: ThemeColors.primary,
            selectionHandleColor: ThemeColors.primary,
          ),
          progressIndicatorTheme: const ProgressIndicatorThemeData(color: ThemeColors.primary),
        ),
        home: const RedirecionamentoScreen(),
      ),
    );
  }
}

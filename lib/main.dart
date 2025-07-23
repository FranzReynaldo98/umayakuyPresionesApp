import 'package:app/services/local_storage.dart';
import 'package:app/ui/providers.dart';
import 'package:app/ui/routes.dart';
import 'package:app/utils/app_colors.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:sizing/sizing.dart';

/*Future<void> main() async {

  await dotenv.load(
    fileName: 'assets/.env', 
    isOptional: true
  ); 
  GlobalKey globalKey= GlobalKey();
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.configurePrefs();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MultiProvider(
      providers: Providers.providers(globalKey),
      child: MyApp(key: globalKey,)
    ))
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SizingBuilder(
      systemFontScale: true,
      builder:() => MaterialApp(
        title: 'Umayakuy',
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: colorPrincipal,
            toolbarHeight: 80.ss,
            foregroundColor: colorFondo,
            titleTextStyle: TextStyle(fontSize: 18.fs)
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: colorPrincipal,
          ),
          textTheme: TextTheme(
            labelMedium: TextStyle(
              fontSize: 18.ss,
              color: colorPrincipal
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: WidgetStateColor.resolveWith((state) {
                return colorPrincipal;
              }),
              foregroundColor: WidgetStateColor.resolveWith((state) {
                return colorFondo;
              }),
              fixedSize: WidgetStatePropertyAll(Size(100.sw, 50.ss)),
              textStyle: WidgetStatePropertyAll(
                TextStyle(fontSize: 18.fs)
              )
            )
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        initialRoute: Routes.routeInicial,
        routes: Routes.routes(context),
      ),
    );
  }
}
*/

Future<void> main() async {

  await dotenv.load(
    fileName: 'assets/.env', 
    isOptional: true
  ); 
  GlobalKey globalKey= GlobalKey();
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.configurePrefs();
  runApp(
    MultiProvider(
      providers: Providers.providers(globalKey),
      child: MyApp(key: globalKey,)
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SizingBuilder(
      systemFontScale: true,
      builder:() => MaterialApp(
        title: 'Umayakuy',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: colorPrincipal,
            toolbarHeight: 80.ss,
            foregroundColor: colorFondo,
            titleTextStyle: TextStyle(fontSize: 18.fs)
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: colorPrincipal,
          ),
          textTheme: TextTheme(
            labelMedium: TextStyle(
              fontSize: 18.ss,
              color: colorPrincipal
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: WidgetStateColor.resolveWith((state) {
                return colorPrincipal;
              }),
              foregroundColor: WidgetStateColor.resolveWith((state) {
                return colorFondo;
              }),
              fixedSize: WidgetStatePropertyAll(Size(100.sw, 50.ss)),
              textStyle: WidgetStatePropertyAll(
                TextStyle(fontSize: 18.fs)
              )
            )
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        initialRoute: Routes.routeInicial,
        routes: Routes.routes(context),
      ),
    );
  }
}
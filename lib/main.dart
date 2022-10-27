import 'package:flutter/material.dart';
import 'package:movies_application/controller/providers/app_provider.dart';
import 'package:movies_application/modules/movies/screens/movies_screen.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        builder: (context, child) => ResponsiveWrapper.builder(
            child,
            maxWidth: 1200,
            minWidth: 480,
            breakpoints: [
              ResponsiveBreakpoint.resize(800, name: MOBILE),
              ResponsiveBreakpoint.autoScale(800, name: TABLET),
              ResponsiveBreakpoint.resize(1000, name: DESKTOP),
            ],
          ),
        title: 'Movies app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
          ),
          scaffoldBackgroundColor: Colors.grey[900],
          primarySwatch: Colors.yellow,
        ),
        home: MoviesScreen(),
      ),
    );
  }
}

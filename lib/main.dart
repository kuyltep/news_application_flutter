import 'package:flutter/material.dart';
import 'package:news_application/newsPage.dart';
import 'package:news_application/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News application',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          textTheme: TextTheme(
              titleMedium: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w500),
              bodyMedium: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
              bodySmall: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(0.8)))),
      routes: routes,
      onGenerateRoute: (settings) {
        if (settings.name == "/news") {
          return PageRouteBuilder(
              settings:
                  settings, // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const NewsPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                const curve = Curves.ease;
                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));

                final curvedAnimation = CurvedAnimation(
                  parent: animation,
                  curve: curve,
                );

                return SlideTransition(
                  position: tween.animate(curvedAnimation),
                  child: child,
                );
              });
        }
        return null;
        // Unknown route
      },
    );
  }
}

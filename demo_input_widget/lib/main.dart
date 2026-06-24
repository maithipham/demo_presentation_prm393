// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'views/user_view.dart';
//
// void main() {
//   runApp(
//     // Wrap the root widget in a ProviderScope to enable Riverpod state management
//     const ProviderScope(
//       child: MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'User CRUD Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         brightness: Brightness.dark,
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: Colors.cyan,
//           brightness: Brightness.dark,
//         ),
//         useMaterial3: true,
//       ),
//       home: const UserView(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'views/user_view.dart';
import 'viewmodels/input_viewmodel.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final isLightTheme =
    ref.watch(isLightThemeProvider);

    return MaterialApp(
      title: 'User CRUD Demo',
      debugShowCheckedModeBanner: false,

      themeMode:
      isLightTheme
          ? ThemeMode.light
          : ThemeMode.dark,

      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.cyan,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.cyan,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),

      home: const UserView(),
    );
  }
}
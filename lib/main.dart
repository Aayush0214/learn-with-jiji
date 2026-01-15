import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiji/features/jiji/presentation/bloc/jiji_bloc.dart';
import 'features/jiji/presentation/pages/jiji_landing_page.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => JijiBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: ThemeData(useMaterial3: true, scaffoldBackgroundColor: Colors.white.withValues(alpha: 0.965)),
          home: const JijiLandingPage(),
        );
      },
    );
  }
}
// ignore: slash_for_doc_comments
/**
  Projeto iniciado no dia 21 de Junho de 2023
*/
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:movie_night/routes/index.dart';
import 'package:movie_night/shared/app_colors.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    

    return MaterialApp.router(
      title: 'Movie Night',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouterConfig,
      theme: _theme(context),
    );
  }
}

ThemeData _theme(BuildContext context){
  return ThemeData(
    useMaterial3: true,
    
    textTheme: GoogleFonts.merriweatherTextTheme(
      Theme.of(context).textTheme.apply(
        displayColor: AppColors.yellow,
        bodyColor: AppColors.white
      ),
    ),

    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: AppColors.white,
      background: AppColors.blue,
    )
  );
}
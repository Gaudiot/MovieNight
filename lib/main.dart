// ignore: slash_for_doc_comments
/**
  Projeto iniciado no dia 21 de Junho
*/

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:movie_night/routes/index.dart';

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
      routerConfig: appRouterConfig
    );
  }
}


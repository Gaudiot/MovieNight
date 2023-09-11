// ignore: slash_for_doc_comments
/**
  Projeto iniciado no dia 21 de Junho
*/

import 'package:flutter/material.dart';
import 'package:movie_night/routes/dashboard/dashboard.dart';

void main() async {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Movie Night',
      home: Dashboard()
    );
  }
}


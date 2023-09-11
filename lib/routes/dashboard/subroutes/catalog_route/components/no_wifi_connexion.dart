import 'package:flutter/material.dart';

class NoWifiConnexion extends StatelessWidget {
  const NoWifiConnexion({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.signal_wifi_off, size: 120),
          Text("Network error", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
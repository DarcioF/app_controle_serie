import 'package:app_controle_serie/views/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ByMySerie());
}

class ByMySerie extends StatelessWidget {
  const ByMySerie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: ListSereies()),
    );
  }
}

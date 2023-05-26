import "package:flutter/material.dart";
import "ui.dart";

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _App(),
    );
  }

}

class _App extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => AppState();
}

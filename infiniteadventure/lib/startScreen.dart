import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StartScreen extends StatelessWidget {
  final VoidCallback onStartPressed;

  StartScreen({required this.onStartPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Endless Adventure'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Toque para Iniciar',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onStartPressed,
              child: Text('Iniciar Jogo'),
            ),
          ],
        ),
      ),
    );
  }
}

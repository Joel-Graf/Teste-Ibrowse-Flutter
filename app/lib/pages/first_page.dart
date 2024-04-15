import 'package:flutter/material.dart';
import 'package:app/pages/second_page.dart';
import 'package:app/util/app_colors.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teste Flutter'),
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SecondPage(),
              ),
            );
          },
          label: const Text(
            'Ir para segunda tela',
            style: TextStyle(fontSize: 18),
          ),
          icon: const Icon(
            Icons.arrow_forward,
            size: 24,
          ),
          style: ElevatedButton.styleFrom(
            foregroundColor: AppColors.whiteText,
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
        ),
      ),
    );
  }
}

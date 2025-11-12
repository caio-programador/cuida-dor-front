import 'package:flutter/material.dart';

class ErroGenericoPage extends StatelessWidget {
  final VoidCallback? onRetry;
  final VoidCallback? onGoHome;

  const ErroGenericoPage({super.key, this.onRetry, this.onGoHome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF5C5C), // vermelho para erro
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24.0, top: 40),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(Icons.error_outline, size: 80, color: Colors.white),
                    SizedBox(height: 20),
                    Text(
                      'Ocorreu um erro',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                      width: 300,
                      child: Text(
                        'Algo deu errado durante o processo. '
                        'Por favor, tente novamente mais tarde.',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        onRetry?.call();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFFFF5C5C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Tentar novamente',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      onGoHome?.call();
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: const Text(
                      'Ir para o início',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

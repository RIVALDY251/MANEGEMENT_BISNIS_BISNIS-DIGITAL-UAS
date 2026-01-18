import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Kembali',
      button: true,
      child: IconButton(
        icon: const Icon(Icons.arrow_back),
        tooltip: 'Kembali',
        onPressed: () {
          try {
            // prefer go_router pop
            context.pop();
          } catch (_) {
            Navigator.maybePop(context);
          }
        },
      ),
    );
  }
}

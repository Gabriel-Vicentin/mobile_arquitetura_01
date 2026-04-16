import 'package:flutter/material.dart';
import 'package:product_app/presentation/pages/product_page.dart';
import 'package:product_app/presentation/viewmodels/product_viewmodel.dart';

class HomePage extends StatelessWidget {
  final ProductViewModel viewModel;

  const HomePage({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tela Inicial')),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductPage(viewModel: viewModel),
              ),
            );
          },
          icon: const Icon(Icons.shopping_bag_outlined),
          label: const Text('Abrir tela de produtos'),
        ),
      ),
    );
  }
}

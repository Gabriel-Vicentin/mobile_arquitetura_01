import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import '../session/favorites_controller.dart';

class ProductDetailPage extends StatefulWidget {
  final int productId;

  const ProductDetailPage({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final ProductService _service = ProductService();

  void _toggleFavorite() {
    setState(() {
      FavoritesController.instance.toggle(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isFavorite = FavoritesController.instance.isFavorite(widget.productId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Produto'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null,
            ),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: FutureBuilder<Product>(
        future: _service.getProductById(widget.productId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Erro: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text('Produto não encontrado'),
            );
          }

          final product = snapshot.data!;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Image.network(
                product.thumbnail,
                height: 180,
              ),
              const SizedBox(height: 16),
              Text(
                product.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text('Categoria: ${product.category}'),
              Text('Preço: R\$ ${product.price.toStringAsFixed(2)}'),
              Text('Avaliação: ${product.rating}'),
              Text('Estoque: ${product.stock}'),
              const SizedBox(height: 16),
              Text(product.description),
            ],
          );
        },
      ),
    );
  }
}

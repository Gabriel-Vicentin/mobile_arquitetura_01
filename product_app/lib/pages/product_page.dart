import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import '../session/session_controller.dart';
import '../session/favorites_controller.dart';
import 'login_page.dart';
import 'product_detail_page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ProductService _service = ProductService();

  Future<List<Product>>? _futureProducts;

  @override
  void initState() {
    super.initState();

    // Bloqueio de acesso sem login
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!SessionController.instance.isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      }
    });

    _futureProducts = _service.getProducts();
  }

  void _logout() {
    SessionController.instance.logout();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  void _toggleFavorite(int productId) {
    setState(() {
      FavoritesController.instance.toggle(productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = SessionController.instance.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        actions: [
          if (user != null)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Center(
                child: Text(user.firstName),
              ),
            ),
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: _futureProducts,
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

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Nenhum produto encontrado'),
            );
          }

          final products = snapshot.data!;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              final isFavorite =
                  FavoritesController.instance.isFavorite(product.id);

              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: ListTile(
                  leading: Image.network(
                    product.thumbnail,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                  ),
                  title: Text(product.title),
                  subtitle: Text(
                    'R\$ ${product.price.toStringAsFixed(2)} | Estoque: ${product.stock}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : null,
                        ),
                        onPressed: () => _toggleFavorite(product.id),
                      ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(
                          productId: product.id,
                        ),
                      ),
                    );
                    setState(() {});
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

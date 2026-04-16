import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  static const String baseUrl = 'https://fakestoreapi.com';

  final http.Client _client;

  ProductService({http.Client? client}) : _client = client ?? http.Client();

  /// Busca todos os produtos
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await _client.get(Uri.parse('$baseUrl/products'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData
            .map((json) => Product.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Falha ao carregar produtos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao buscar produtos: $e');
    }
  }

  /// Busca um produto específico por ID
  Future<Product> getProductById(String id) async {
    try {
      final response = await _client.get(Uri.parse('$baseUrl/products/$id'));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return Product.fromJson(json);
      } else if (response.statusCode == 404) {
        throw Exception('Produto não encontrado');
      } else {
        throw Exception('Falha ao carregar produto: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao buscar produto: $e');
    }
  }

  /// Adiciona um novo produto
  Future<Product> addProduct(Product product) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/products'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(product.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return Product.fromJson(json);
      } else {
        throw Exception('Falha ao adicionar produto: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao adicionar produto: $e');
    }
  }

  /// Atualiza um produto existente
  Future<Product> updateProduct(Product product) async {
    if (product.id == null) {
      throw Exception('Produto deve ter um ID para ser atualizado');
    }

    try {
      final response = await _client.put(
        Uri.parse('$baseUrl/products/${product.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(product.toJson()),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return Product.fromJson(json);
      } else {
        throw Exception('Falha ao atualizar produto: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao atualizar produto: $e');
    }
  }

  /// Deleta um produto
  Future<void> deleteProduct(String id) async {
    try {
      final response = await _client.delete(
        Uri.parse('$baseUrl/products/$id'),
      );

      if (response.statusCode != 200) {
        throw Exception('Falha ao deletar produto: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao deletar produto: $e');
    }
  }

  /// Busca produtos por categoria
  Future<List<Product>> getProductsByCategory(String category) async {
    try {
      final response =
          await _client.get(Uri.parse('$baseUrl/products/category/$category'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData
            .map((json) => Product.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Falha ao carregar categoria: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao buscar categoria: $e');
    }
  }
}

import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import '../widgets/product_form_fields.dart';

class ProductFormScreen extends StatefulWidget {
  final Product? product;

  const ProductFormScreen({
    Key? key,
    this.product,
  }) : super(key: key);

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  late TextEditingController _categoryController;
  late TextEditingController _imageController;
  late ProductService _service;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _service = ProductService();

    if (widget.product != null) {
      _titleController = TextEditingController(text: widget.product!.title);
      _priceController =
          TextEditingController(text: widget.product!.price.toString());
      _descriptionController =
          TextEditingController(text: widget.product!.description);
      _categoryController =
          TextEditingController(text: widget.product!.category);
      _imageController = TextEditingController(text: widget.product!.image);
    } else {
      _titleController = TextEditingController();
      _priceController = TextEditingController();
      _descriptionController = TextEditingController();
      _categoryController = TextEditingController();
      _imageController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  bool _validateForm() {
    if (!_formKey.currentState!.validate()) {
      return false;
    }

    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Título é obrigatório')),
      );
      return false;
    }

    if (_priceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preço é obrigatório')),
      );
      return false;
    }

    try {
      double.parse(_priceController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preço inválido')),
      );
      return false;
    }

    return true;
  }

  Future<void> _saveProduct() async {
    if (!_validateForm()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final newProduct = Product(
        id: widget.product?.id,
        title: _titleController.text,
        price: double.parse(_priceController.text),
        description: _descriptionController.text,
        category: _categoryController.text,
        image: _imageController.text,
        ratingRate: widget.product?.ratingRate,
        ratingCount: widget.product?.ratingCount,
      );

      if (widget.product == null) {
        // Novo produto (POST)
        await _service.addProduct(newProduct);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Produto criado com sucesso!')),
          );
        }
      } else {
        // Atualizar produto (PUT)
        await _service.updateProduct(newProduct);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Produto atualizado com sucesso!')),
          );
        }
      }

      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.product != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Produto' : 'Novo Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: ProductFormFields(
                  titleController: _titleController,
                  priceController: _priceController,
                  descriptionController: _descriptionController,
                  categoryController: _categoryController,
                  imageController: _imageController,
                  titleValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O título é obrigatório';
                    }
                    if (value.length < 3) {
                      return 'O título deve ter pelo menos 3 caracteres';
                    }
                    return null;
                  },
                  priceValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O preço é obrigatório';
                    }
                    try {
                      final price = double.parse(value);
                      if (price < 0) {
                        return 'O preço não pode ser negativo';
                      }
                    } catch (e) {
                      return 'O preço deve ser um número válido';
                    }
                    return null;
                  },
                  descriptionValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'A descrição é obrigatória';
                    }
                    if (value.length < 10) {
                      return 'A descrição deve ter pelo menos 10 caracteres';
                    }
                    return null;
                  },
                  categoryValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'A categoria é obrigatória';
                    }
                    return null;
                  },
                  imageValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'A URL da imagem é obrigatória';
                    }
                    if (!value.startsWith('http')) {
                      return 'A URL deve começar com http ou https';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 24.0),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      child: const Text('Cancelar'),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _saveProduct,
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : Text(isEditing ? 'Atualizar' : 'Criar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

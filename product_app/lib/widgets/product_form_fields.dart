import 'package:flutter/material.dart';

class ProductFormFields extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController priceController;
  final TextEditingController descriptionController;
  final TextEditingController categoryController;
  final TextEditingController imageController;
  final FormFieldValidator<String>? titleValidator;
  final FormFieldValidator<String>? priceValidator;
  final FormFieldValidator<String>? descriptionValidator;
  final FormFieldValidator<String>? categoryValidator;
  final FormFieldValidator<String>? imageValidator;

  const ProductFormFields({
    Key? key,
    required this.titleController,
    required this.priceController,
    required this.descriptionController,
    required this.categoryController,
    required this.imageController,
    this.titleValidator,
    this.priceValidator,
    this.descriptionValidator,
    this.categoryValidator,
    this.imageValidator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Campo de Título
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Título do Produto',
              hintText: 'Ex: Camiseta Azul',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.shopping_bag),
            ),
            validator: titleValidator,
          ),
          const SizedBox(height: 16.0),

          // Campo de Preço
          TextFormField(
            controller: priceController,
            decoration: const InputDecoration(
              labelText: 'Preço (R\$)',
              hintText: '0.00',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.attach_money),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: priceValidator,
          ),
          const SizedBox(height: 16.0),

          // Campo de Descrição
          TextFormField(
            controller: descriptionController,
            decoration: const InputDecoration(
              labelText: 'Descrição',
              hintText: 'Descreva o produto...',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.description),
            ),
            maxLines: 4,
            validator: descriptionValidator,
          ),
          const SizedBox(height: 16.0),

          // Campo de Categoria
          TextFormField(
            controller: categoryController,
            decoration: const InputDecoration(
              labelText: 'Categoria',
              hintText: 'Ex: Eletrônicos',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.category),
            ),
            validator: categoryValidator,
          ),
          const SizedBox(height: 16.0),

          // Campo de URL da Imagem
          TextFormField(
            controller: imageController,
            decoration: const InputDecoration(
              labelText: 'URL da Imagem',
              hintText: 'https://...',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.image),
            ),
            validator: imageValidator,
          ),
        ],
      ),
    );
  }
}

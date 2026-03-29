import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';
import 'edit_product_screen.dart'; // Importamos la nueva pantalla

class DetailScreen extends StatelessWidget {
  final Product product;
  final ApiService _apiService = ApiService(); // Instancia para usar el DELETE

  DetailScreen({super.key, required this.product});

  // Función para mostrar cuadro de confirmación y eliminar (DELETE)
  Future<void> _deleteProduct(BuildContext context) async {
    // 1. Mostrar cuadro de diálogo de confirmación
    final bool? confirmar = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¿Eliminar producto?'),
          content: const Text('Esta acción no se puede deshacer.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
            TextButton(
              onPressed: () => Navigator.pop(context, true), 
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );

    // 2. Si el usuario confirmó, hacemos la petición DELETE
    if (confirmar == true && context.mounted) {
      try {
        // Mostramos un indicador de carga rápido en el SnackBar
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Eliminando...')));
        
        final bool success = await _apiService.deleteProduct(product.id!);
        
        if (success && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Producto eliminado (Simulación exitosa)'), backgroundColor: Colors.redAccent),
          );
          // Regresamos a la pantalla principal
          Navigator.pop(context);
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        actions: [
          // Botón de Editar (PUT)
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Editar',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProductScreen(product: product)),
              );
            },
          ),
          // Botón de Eliminar (DELETE)
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Eliminar',
            onPressed: () => _deleteProduct(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.network(product.image, height: 300, fit: BoxFit.contain)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$${product.price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green)),
                Row(children: [const Icon(Icons.star, color: Colors.amber), Text(' ${product.rating}', style: const TextStyle(fontSize: 18))]),
              ],
            ),
            const SizedBox(height: 10),
            Text(product.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Chip(label: Text(product.category.toUpperCase(), style: const TextStyle(color: Colors.white)), backgroundColor: Colors.blueGrey),
            const SizedBox(height: 20),
            const Text('Descripción:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(product.description, style: const TextStyle(fontSize: 16, height: 1.5)),
          ],
        ),
      ),
    );
  }
}
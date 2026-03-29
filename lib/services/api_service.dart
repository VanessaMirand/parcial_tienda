import 'package:dio/dio.dart';
import '../models/product.dart';

class ApiService {
  // Configuración de la Base URL solicitada en el parcial
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://fakestoreapi.com'));

  // ==========================================
  // 1. OBTENER TODOS LOS PRODUCTOS (GET)
  // Endpoint: GET /products
  // ==========================================
  Future<List<Product>> getProducts() async {
    try {
      final response = await _dio.get('/products');
      // Convertimos la respuesta cruda en una Lista de objetos Product
      final List<dynamic> data = response.data;
      return data.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      // El manejo de errores es evaluado en la rúbrica
      throw Exception('Error al cargar los productos: $e');
    }
  }

  // ==========================================
  // 2. CREAR UN PRODUCTO (POST)
  // Endpoint: POST /products
  // ==========================================
  Future<int> createProduct(Product product) async {
    try {
      final response = await _dio.post(
        '/products',
        data: product.toJson(), // Convertimos el objeto a JSON
      );
      // La Fake Store API devuelve un JSON con el ID generado (ej: {id: 21})
      // Retornamos este ID para mostrarlo en el SnackBar después
      return response.data['id'];
    } catch (e) {
      throw Exception('Error al crear el producto: $e');
    }
  }

  // ==========================================
  // 3. ACTUALIZAR UN PRODUCTO (PUT) - BONIFICACIÓN
  // ==========================================
  Future<bool> updateProduct(int id, Product product) async {
    try {
      final response = await _dio.put(
        '/products/$id',
        data: product.toJson(),
      );
      // Retorna true si la petición fue exitosa (código 200)
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Error al actualizar el producto: $e');
    }
  }

  // ==========================================
  // 4. ELIMINAR UN PRODUCTO (DELETE) - BONIFICACIÓN
  // ==========================================
  Future<bool> deleteProduct(int id) async {
    try {
      final response = await _dio.delete('/products/$id');
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Error al eliminar el producto: $e');
    }
  }
}
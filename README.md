# Parcial - Tienda FakeStore (Flutter)

Aplicación móvil desarrollada en Flutter para la evaluación práctica de peticiones HTTP, manejo de estados y arquitectura de UI.

## Características Implementadas
* **Listado de Productos (GET):** Cuadrícula de productos obtenida desde `https://fakestoreapi.com/products`.
* **Detalle del Producto:** Visualización ampliada con descripción, categoría, precio y calificación.
* **Creación de Producto (POST):** Formulario validado para enviar nuevos productos a la API.
* **Actualización (PUT) - Bonificación:** Formulario pre-llenado para simular la edición de un producto.
* **Eliminación (DELETE) - Bonificación:** Cuadro de diálogo de confirmación para simular el borrado de un producto.

## Arquitectura
El proyecto sigue una separación por capas:
* `/models`: Clases de datos (`Product`) con métodos `fromJson` y `toJson`.
* `/services`: Lógica de red (`ApiService`) utilizando el paquete `dio`.
* `/screens`: Interfaz de usuario (`HomeScreen`, `DetailScreen`, `CreateProductScreen`, `EditProductScreen`).

## Instrucciones de Ejecución
Para ejecutar este proyecto en su máquina local, siga estos pasos:

1. Asegúrese de tener Flutter instalado y un emulador (o dispositivo físico) conectado.
2. Clone este repositorio.
3. Abra una terminal en la raíz del proyecto y ejecute el siguiente comando para instalar las dependencias:
   ```bash
   flutter pub get
import 'category_api.dart';

void main() async {
  final productService = ProductService();

  try {
    // Fetch products from different categories
    List<Product> drinks = await productService.getProducts('drinks');
    List<Product> bread = await productService.getProducts('bread');
    List<Product> meat = await productService.getProducts('meat');
    List<Product> vegetables = await productService.getProducts('vegetables');
    List<Product> snacks = await productService.getProducts('snacks');

    // Use the retrieved product lists as needed
    print('Drinks: $drinks');
    print('Bread: $bread');
    print('Meat: $meat');
    print('Vegetables: $vegetables');
    print('Snacks: $snacks');
  } catch (e) {
    print('Error: $e');
  }
}

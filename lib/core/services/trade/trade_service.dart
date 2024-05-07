import 'dart:async';
import 'dart:math';

import 'package:cerrado_vivo/core/models/product.dart';

class TradeService {
  static final List<Product> _products = [
    Product(
      id: Random().nextDouble().toString(),
      name: 'Jenipapo',
      price: 99.99,
      description: 'Lorem ipsum dolor sit amet. Vel minus quisquam',
      imageURL: 'assets/images/jenipapo-semente.jpg'
    ),
    Product(
      id: Random().nextDouble().toString(),
      name: 'Pequi',
      price: 89.99,
      description: 'Lorem ipsum dolor sit amet. Vel minus quisquam',
      imageURL: 'assets/images/pequi-semente.jpg'
    ),
    Product(
      id: Random().nextDouble().toString(),
      name: 'Jatobá',
      price: 109.99,
      description: 'Lorem ipsum dolor sit amet. Vel minus quisquam',
      imageURL: 'assets/images/jatoba-semente.jpg'
    )
  ];

  static List<Product> getProducts() {
    return _products;
  }

//  static MultiStreamController<List<Product>>? _controller;
//  static final _prdStream = Stream<List<Product>>.multi((controller) {
//    _controller = controller;
//    controller.add(_products);
//  });
//
//  Stream<List<Product>> _productsStream() {
//    return _prdStream;
//  }
}

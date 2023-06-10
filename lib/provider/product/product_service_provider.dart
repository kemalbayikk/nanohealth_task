import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanohealth_task/service/product/product_service.dart';

final productServiceProvider =
    ChangeNotifierProvider<ProductService>((ref) => ProductService());

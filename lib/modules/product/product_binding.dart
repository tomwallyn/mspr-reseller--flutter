import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mspr/core/providers/dio_provider.dart';
import 'package:mspr/modules/product/controller/product_controller.dart';
import 'package:mspr/modules/product/data/models/product.dart';
import 'package:mspr/modules/product/data/product_api_provider.dart';
import 'package:mspr/modules/product/data/product_repository.dart';

// Api
final _productApiProvider = Provider(
  (ref) => ProductApiProvider(ref.read(dioProvider), ref),
);

// Repository
final _productRepositoryProvider = Provider(
  (ref) => ProductRepository(
    apiProvider: ref.read(_productApiProvider),
  ),
);

// final storeIdProvider =
//     Provider<String?>((ref) => ref.watch(userProvider.select((user) => user.asData?.value?.storeId)));

// Controller
final productControllerProvider = StateNotifierProvider.family<ProductController, AsyncValue<Product?>, String>(
  (ref, productId) => ProductController(
    productRepository: ref.read(_productRepositoryProvider),
  )..getProduct(productId: productId),
);

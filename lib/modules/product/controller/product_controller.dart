import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mspr/modules/product/data/models/product.dart';
import 'package:mspr/modules/product/data/product_repository.dart';

class ProductController extends StateNotifier<AsyncValue<Product?>> {
  ProductController({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(const AsyncValue.data(null));

  final ProductRepository _productRepository;

  void getProduct({
    required String productId,
  }) async {
    state = const AsyncValue.loading();

    final result = await _productRepository.getProduct(productId: productId);

    result.fold(
      (failure) => state = AsyncValue.error(failure.message),
      (product) {
        state = AsyncValue.data(product);
      },
    );
  }
}

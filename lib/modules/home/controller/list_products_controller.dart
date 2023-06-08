import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mspr/modules/home/data/list_products_repository.dart';
import 'package:mspr/modules/product/data/models/product.dart';

class ListProductController extends StateNotifier<AsyncValue<List<Product>?>> {
  ListProductController({required ListProductRepository productRepository})
      : _productRepository = productRepository,
        super(const AsyncValue.data(null));

  final ListProductRepository _productRepository;

  void getProducts() async {
    state = const AsyncValue.loading();

    final result = await _productRepository.getProducts();

    result.fold(
      (failure) => state = AsyncValue.error(failure.message),
      (products) {
        state = AsyncValue.data(products);
      },
    );
  }
}

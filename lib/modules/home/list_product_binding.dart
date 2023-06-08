import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mspr/core/providers/dio_provider.dart';
import 'package:mspr/modules/home/controller/list_products_controller.dart';
import 'package:mspr/modules/home/data/list_products_api_provider.dart';
import 'package:mspr/modules/home/data/list_products_repository.dart';
import 'package:mspr/modules/product/data/models/product.dart';

// Api
final _listProductApiProvider = Provider(
  (ref) => ListProductApiProvider(ref.read(dioProvider), ref),
);

// Repository
final _listProductRepositoryProvider = Provider(
  (ref) => ListProductRepository(
    apiProvider: ref.read(_listProductApiProvider),
  ),
);

// final storeIdProvider =
//     Provider<String?>((ref) => ref.watch(userProvider.select((user) => user.asData?.value?.storeId)));

// Controller
final listProductControllerProvider = StateNotifierProvider<ListProductController, AsyncValue<List<Product>?>>(
  (ref) => ListProductController(
    productRepository: ref.read(_listProductRepositoryProvider),
  )..getProducts(),
);

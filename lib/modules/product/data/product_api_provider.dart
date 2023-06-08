import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mspr/core/providers/global_provider_binding.dart';
import 'package:mspr/modules/product/data/models/product.dart';

class ProductApiProvider {
  ProductApiProvider(this._dio, this._ref);

  final Dio _dio;
  final ProviderRef _ref;

  Future<Product> getProduct({required String productId}) async {
    final response = await _dio.get(
      '${_ref.read(environmentConfigServiceProvider).backendApiUrl}products/$productId',
    );

    return Product.fromJson(response.data);
  }
}

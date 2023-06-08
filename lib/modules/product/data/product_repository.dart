import 'package:dartz/dartz.dart';
import 'package:mspr/core/values/failures.dart';
import 'package:mspr/modules/product/data/models/product.dart';
import 'package:mspr/modules/product/data/product_api_provider.dart';

class ProductRepository {
  ProductRepository({required ProductApiProvider apiProvider}) : _apiProvider = apiProvider;

  final ProductApiProvider _apiProvider;

  Future<Either<ProductsFailure, Product>> getProduct({
    required String productId,
  }) async {
    try {
      final response = await _apiProvider.getProduct(
        productId: productId,
      );

      return Right(response);
    } catch (e) {
      return Left(
        ProductsFailure(message: e.toString()),
      );
    }
  }
}

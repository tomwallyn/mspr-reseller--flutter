import 'package:dartz/dartz.dart';
import 'package:mspr/core/values/failures.dart';
import 'package:mspr/modules/home/data/list_products_api_provider.dart';
import 'package:mspr/modules/product/data/models/product.dart';

class ListProductRepository {
  ListProductRepository({required ListProductApiProvider apiProvider}) : _apiProvider = apiProvider;

  final ListProductApiProvider _apiProvider;

  Future<Either<ProductsFailure, List<Product>>> getProducts() async {
    try {
      final response = await _apiProvider.getProducts();

      return Right(response);
    } catch (e) {
      return Left(
        ProductsFailure(message: e.toString()),
      );
    }
  }
}

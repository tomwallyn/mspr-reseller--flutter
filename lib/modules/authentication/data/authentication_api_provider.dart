import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mspr/core/models/user/custom_user.dart';
import 'package:mspr/core/providers/global_provider_binding.dart';
import 'package:mspr/modules/product/data/models/product.dart';

class AuthenticationApiProvider {
  AuthenticationApiProvider(this._dio, this._ref);

  final Dio _dio;
  final ProviderRef _ref;

  Future<CustomUser> checkUser(
      {required String username, required String password}) async {
    final response = await _dio.get(
      '${_ref.read(environmentConfigServiceProvider).backendApiUrl}authentication/$username/$password',
    );

    return CustomUser.fromJson(response.data);
  }

  Future<Product> getProduct({required String productId}) async {
    final response = await _dio.get(
      '${_ref.read(environmentConfigServiceProvider).backendApiUrl}products/$productId',
    );

    return Product.fromJson(response.data);
  }

  Future<List<Product>> checkToken({required String token}) async {
    final response = await _dio.get(
      '${_ref.read(environmentConfigServiceProvider).backendApiUrl}products',
      options: Options(headers: {'token': token}),
    );

    return List<Product>.from(
        response.data.map((model) => Product.fromJson(model)));
  }
}

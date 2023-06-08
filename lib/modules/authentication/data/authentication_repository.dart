import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mspr/core/models/user/custom_user.dart';
import 'package:mspr/core/values/failures.dart';
import 'package:mspr/modules/authentication/data/authentication_api_provider.dart';

class AuthenticationRepository {
  AuthenticationRepository({required AuthenticationApiProvider apiProvider}) : _apiProvider = apiProvider;

  final AuthenticationApiProvider _apiProvider;

  Future<Either<UserFailure, CustomUser>> checkUser({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _apiProvider.checkUser(username: username, password: password);

      return Right(response);
    } catch (e) {
      if (e is DioError && e.response != null) {
        final errorResponse = e.response!;
        final error = UserFailure(message: errorResponse.data['message'] ?? '');
        return Left(error);
      } else {
        return Left(UserFailure(message: e.toString()));
      }
    }
  }
}

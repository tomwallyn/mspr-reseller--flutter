import 'dart:core';

abstract class Failure {}

// Products
class ProductsFailure extends Failure {
  final String message;
  final Object? exception;

  ProductsFailure({
    required this.message,
    this.exception,
  });
}

// User
class UserFailure extends Failure {
  final String message;
  final Object? exception;

  UserFailure({
    required this.message,
    this.exception,
  });
}

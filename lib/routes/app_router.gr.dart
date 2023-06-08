// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../modules/authentication/presentation/authentication_page.dart' as _i1;
import '../modules/product/presentation/product_page.dart' as _i2;
import 'guards/auth_guards.dart' as _i5;

class AppRouter extends _i3.RootStackRouter {
  AppRouter({
    _i4.GlobalKey<_i4.NavigatorState>? navigatorKey,
    required this.authGuard,
  }) : super(navigatorKey);

  final _i5.AuthGuard authGuard;

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    AuthenticationRoute.name: (routeData) {
      return _i3.MaterialPageX<_i4.Widget>(
        routeData: routeData,
        child: const _i1.AuthenticationPage(),
      );
    },
    ProductRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProductRouteArgs>(
          orElse: () =>
              ProductRouteArgs(productId: pathParams.optString('productId')));
      return _i3.MaterialPageX<_i4.Widget>(
        routeData: routeData,
        child: _i2.ProductPage(args.productId),
      );
    },
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/product/:productId',
          fullMatch: true,
        ),
        _i3.RouteConfig(
          AuthenticationRoute.name,
          path: '/login',
        ),
        _i3.RouteConfig(
          ProductRoute.name,
          path: '/product/:productId',
          guards: [authGuard],
        ),
      ];
}

/// generated route for
/// [_i1.AuthenticationPage]
class AuthenticationRoute extends _i3.PageRouteInfo<void> {
  const AuthenticationRoute()
      : super(
          AuthenticationRoute.name,
          path: '/login',
        );

  static const String name = 'AuthenticationRoute';
}

/// generated route for
/// [_i2.ProductPage]
class ProductRoute extends _i3.PageRouteInfo<ProductRouteArgs> {
  ProductRoute({required String? productId})
      : super(
          ProductRoute.name,
          path: '/product/:productId',
          args: ProductRouteArgs(productId: productId),
          rawPathParams: {'productId': productId},
        );

  static const String name = 'ProductRoute';
}

class ProductRouteArgs {
  const ProductRouteArgs({required this.productId});

  final String? productId;

  @override
  String toString() {
    return 'ProductRouteArgs{productId: $productId}';
  }
}

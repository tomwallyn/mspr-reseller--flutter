import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mspr/modules/authentication/presentation/authentication_page.dart';
import 'package:mspr/modules/product/presentation/product_page.dart';
import 'package:mspr/routes/guards/auth_guards.dart';

const loginPath = '/login';
const productPath = '/product/:productId';

@MaterialAutoRouter(replaceInRouteName: 'Page,Route', routes: <AutoRoute>[
  AutoRoute<Widget>(path: loginPath, page: AuthenticationPage),
  AutoRoute<Widget>(path: productPath, initial: true, page: ProductPage, guards: [AuthGuard]),
])
class $AppRouter {}

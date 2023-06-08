import 'package:auto_route/auto_route.dart';
import 'package:mspr/core/providers/auth_provider.dart';
import 'package:mspr/routes/guards/guard_router_utils.dart';

class AuthGuard extends AutoRouteGuard {
  AuthGuard(this._user);

  final AuthProvider _user;

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    if (_user.state?.username != null) {
      resolver.next();
    } else {
      await router.pushAuthPage(resolver);
    }
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:mspr/routes/app_router.gr.dart';

extension GuardExt on StackRouter {
  Future<void> pushAuthPage(NavigationResolver resolver) => replace(
        const AuthenticationRoute(),
      );
}

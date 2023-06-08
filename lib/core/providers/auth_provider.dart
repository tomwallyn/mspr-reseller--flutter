import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mspr/core/models/user/custom_user.dart';

class AuthProvider extends StateNotifier<CustomUser?> {
  AuthProvider() : super(null);

  void setAuthUser(CustomUser user) async {
    state = user;
  }
}

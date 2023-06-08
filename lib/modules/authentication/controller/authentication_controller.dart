import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mspr/core/models/user/custom_user.dart';
import 'package:mspr/modules/authentication/data/authentication_repository.dart';

class AuthenticationController extends StateNotifier<AsyncValue<CustomUser?>> {
  AuthenticationController({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const AsyncValue.data(null));

  final AuthenticationRepository _authenticationRepository;

  void checkUser({required String username, required String password}) async {
    state = const AsyncValue.loading();

    final result = await _authenticationRepository.checkUser(username: username, password: password);

    result.fold(
      (failure) => state = AsyncValue.error(failure.message),
      (user) {
        state = AsyncValue.data(user);
      },
    );
  }
}

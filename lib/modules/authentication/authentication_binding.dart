// Api
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mspr/core/models/user/custom_user.dart';
import 'package:mspr/core/providers/dio_provider.dart';
import 'package:mspr/modules/authentication/controller/authentication_controller.dart';
import 'package:mspr/modules/authentication/data/authentication_api_provider.dart';
import 'package:mspr/modules/authentication/data/authentication_repository.dart';

final _authenticationApiProvider = Provider(
  (ref) => AuthenticationApiProvider(ref.read(dioProviderAuth), ref),
);

// Repository
final _authenticationRepositoryProvider = Provider(
  (ref) => AuthenticationRepository(
    apiProvider: ref.read(_authenticationApiProvider),
  ),
);

// final storeIdProvider =
//     Provider<String?>((ref) => ref.watch(userProvider.select((user) => user.asData?.value?.storeId)));

// Controller
final authenticationControllerProvider =
    StateNotifierProvider<AuthenticationController, AsyncValue<CustomUser?>>(
  (ref) => AuthenticationController(
      authenticationRepository: ref.watch(_authenticationRepositoryProvider)),
);

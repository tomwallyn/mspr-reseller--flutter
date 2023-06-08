import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mspr/core/models/user/custom_user.dart';
import 'package:mspr/core/providers/auth_provider.dart';
import 'package:mspr/core/services/environment_config_service.dart';
import 'package:mspr/core/utils/environment_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';

final environmentConfigServiceProvider = Provider<EnvironmentConfigService>(
  (ref) => throw UnimplementedError(),
);

final environmentUtilsProvider = Provider<EnvironmentUtils>(
  (ref) => throw UnimplementedError(),
);

final packageInfoProvider = Provider<PackageInfo>(
  (ref) => throw UnimplementedError(),
);

final userProvider = StateNotifierProvider<AuthProvider, CustomUser?>((ref) => AuthProvider());

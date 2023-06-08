import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mspr/core/providers/global_provider_binding.dart';
import 'package:mspr/core/services/environment_config_service.dart';
import 'package:mspr/core/theme/theme.dart';
import 'package:mspr/core/utils/environment_utils.dart';
import 'package:mspr/core/widgets/restart_widget.dart';
import 'package:mspr/routes/app_router.gr.dart';
import 'package:mspr/routes/guards/auth_guards.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  final _packageInfo = await PackageInfo.fromPlatform();
  final _environmentUtils = EnvironmentUtils();
  final environment = _environmentUtils.getEnvironment();

  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..maskType = EasyLoadingMaskType.black
    ..backgroundColor = Colors.white
    ..indicatorColor = primaryColor
    ..textColor = primaryColor
    ..dismissOnTap = false
    ..displayDuration = const Duration(seconds: 3);

  final _environmentConfig = EnvironmentConfigService(
    environment: environment,
    firebaseRemoteConfig: FirebaseRemoteConfig.instance,
    rootBundle: PlatformAssetBundle(),
  );

  await _environmentConfig.load();

  runZonedGuarded(
    () {
      runApp(
        RestartWidget(
          child: ProviderScope(
            overrides: [
              environmentConfigServiceProvider.overrideWithValue(_environmentConfig),
              environmentUtilsProvider.overrideWithValue(_environmentUtils),
              packageInfoProvider.overrideWithValue(_packageInfo)
            ],
            child: KeyboardVisibilityProvider(
              child: App(),
            ),
          ),
        ),
      );
    },
    (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack),
  );
}

class App extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = useState(AppRouter(authGuard: AuthGuard(ref.watch(userProvider.notifier))));
    return _wrapWithBannerEnvironment(
      MaterialApp.router(
        routerDelegate: appRouter.value.delegate(),
        routeInformationParser: appRouter.value.defaultRouteParser(),
        title: 'Bakery',
        theme: AppTheme.getDefault(context),
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
      ),
    );
  }

  Widget _wrapWithBannerEnvironment(Widget child) {
    const environment = String.fromEnvironment('ENV');
    if (environment != 'prod') {
      return Banner(
        message: environment,
        location: BannerLocation.topEnd,
        layoutDirection: TextDirection.ltr,
        textDirection: TextDirection.ltr,
        child: child,
      );
    }

    return child;
  }
}

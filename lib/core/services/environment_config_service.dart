import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:mspr/core/enum/environment_utils.dart';
import 'package:mspr/core/values/configs.dart';

class EnvironmentConfigService {
  EnvironmentConfigService({
    required Environment environment,
    required FirebaseRemoteConfig firebaseRemoteConfig,
    required AssetBundle rootBundle,
    RemoteConfigSettings? configSettings,
  })  : _environment = environment,
        _remoteConfig = firebaseRemoteConfig,
        _rootBundle = rootBundle,
        _remoteConfigSettings = configSettings ??
            RemoteConfigSettings(
              fetchTimeout: const Duration(seconds: 6),
              minimumFetchInterval: Duration.zero,
            );

  final Environment _environment;
  final AssetBundle _rootBundle;
  final FirebaseRemoteConfig _remoteConfig;
  final RemoteConfigSettings _remoteConfigSettings;

  static const _backendApiKey = 'BACKEND_KEY';
  static const _backendApiUrl = 'BACKEND_URL';

  String get backendApiKey => _getConfigValue(_backendApiKey);
  String get backendApiUrl => _getConfigValue(_backendApiUrl);

  String _getConfigValue(String key) {
    return _configuration[key] as String? ?? '';
  }

  late Map<String, dynamic> _configuration;

  RemoteConfigSettings get configSettings => _remoteConfigSettings;

  Future<void> load() async {
    var env = <String, dynamic>{};
    await _remoteConfig.ensureInitialized();
    await _remoteConfig.setConfigSettings(_remoteConfigSettings);
    try {
      env = await _loadJsonEnvironment(_environment);
      await _remoteConfig.setDefaults(env);
    } catch (e) {
      debugPrint(e.toString());
    }
    try {
      await _remoteConfig.fetchAndActivate();
    } catch (e) {
      debugPrint(e.toString());
    }
    final result = _remoteConfig.getString('config');

    if (_environment == Environment.ref) {
      _configuration = env;
    } else {
      if (result.isNotEmpty) {
        _configuration = jsonDecode(
          _remoteConfig.getString('config'),
        ) as Map<String, dynamic>;
      } else {
        _configuration = env;
      }
    }
  }

  Future<Map<String, dynamic>> _loadJsonEnvironment(
    Environment environment,
  ) async {
    final path = _getJsonWithPathEnvironment(environment);
    final data = await _rootBundle.loadString(path);
    return json.decode(data) as Map<String, dynamic>;
  }

  String _getJsonWithPathEnvironment(Environment environment) {
    switch (environment) {
      case Environment.prod:
        return prodConfig;
      case Environment.ref:
        return refConfig;
    }
  }
}

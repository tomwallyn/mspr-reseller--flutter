import 'package:mspr/core/enum/environment_utils.dart';

class EnvironmentUtils {
  EnvironmentUtils();

  Environment getEnvironment() {
    return Environment.values.asNameMap()[const String.fromEnvironment('ENV')] ?? Environment.prod;
  }
}

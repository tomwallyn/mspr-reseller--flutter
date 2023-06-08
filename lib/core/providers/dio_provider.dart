// Dio
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mspr/core/providers/global_provider_binding.dart';

final dioProvider = Provider(
  (ref) => Dio()
    ..interceptors.add(
      ref.watch(customInterceptorProvider),
    ),
);

final customInterceptorProvider =
    Provider((ref) => CustomInterceptors(ref: ref));

class CustomInterceptors extends Interceptor {
  CustomInterceptors({
    required this.ref,
  });

  final ProviderRef ref;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['token'] = ref.watch(userProvider)?.token;

    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // ref.read(redirectProvider.notifier).redirect(Routes.LOGIN);
    }
    super.onError(err, handler);
  }
}

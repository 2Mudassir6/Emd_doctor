// // custom_dio.dart
// import 'package:dio/dio.dart';
//
// import 'auth_manager.dart';
//
// class CustomDio extends Dio {
//   CustomDio() {
//     interceptors.add(InterceptorsWrapper(
//       onRequest: (options, handler) async {
//         // Inject access token to headers
//         options.headers["Authorization"] = "Bearer ${AuthManager.accessToken}";
//         return handler.next(options);
//       },
//       onResponse: (response, handler) async {
//         // Handle token expiration and refresh
//         if (response.statusCode == 401 && AuthManager.isTokenExpired()) {
//           await AuthManager.refreshToken();
//           // Reattempt the request with the new token
//           return dio.fetch(response.requestOptions.path, options: response.requestOptions);
//         }
//         return handler.next(response);
//       },
//     ));
//   }
// }

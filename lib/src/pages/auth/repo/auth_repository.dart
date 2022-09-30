import 'package:greengrocer/src/constants/endpoints.dart';
import 'package:greengrocer/src/models/user_model.dart';
import 'package:greengrocer/src/pages/auth/repo/auth_errors.dart'
    as auth_errors;
import 'package:greengrocer/src/pages/auth/result/auth_result.dart';
import 'package:greengrocer/src/services/http_manager.dart';

class AuthRepository {
  final _httpManager = HttpManager();

  _handleUserOrError(Map<dynamic, dynamic> result) {
    if (result['result'] != null) {
      final user = UserModel.fromJson(result['result']);
      return AuthResult.success(user);
    } else {
      return AuthResult.error(auth_errors.authErrorMessage(result['error']));
    }
  }

  Future<AuthResult> validateToken(String token) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.validateToken,
      method: HttpMethods.post,
      headers: {
        'X-Parse-Session-Token': token,
      },
    );

    return _handleUserOrError(result);
  }

  Future<AuthResult> signIn(
      {required String email, required String password}) async {
    final result = await _httpManager
        .restRequest(url: Endpoints.signin, method: HttpMethods.post, body: {
      'email': email.trim(),
      'password': password.trim(),
    });

    return _handleUserOrError(result);
  }

  Future<AuthResult> signUp(UserModel user) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.signup,
      method: HttpMethods.post,
      body: user.toJson(),
    );

    return _handleUserOrError(result);
  }

  Future<void> resetPassword(String email) async {
    await _httpManager.restRequest(
      url: Endpoints.resetPassword,
      method: HttpMethods.post,
      body: {
        'email': email,
      },
    );
  }

  Future<bool> changePassword({
    required String token,
    required String email,
    required String currentPassword,
    required String newPassword,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.changePassword,
      method: HttpMethods.post,
      headers: {
        'X-Parse-Session-Token': token,
      },
      body: {
        'email': email,
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      },
    );
    return result['error'] == null;
  }
}

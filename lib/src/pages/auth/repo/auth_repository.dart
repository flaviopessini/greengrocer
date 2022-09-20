import 'package:greengrocer/src/constants/endpoints.dart';
import 'package:greengrocer/src/models/user_model.dart';
import 'package:greengrocer/src/pages/auth/repo/auth_errors.dart' as auth_errors;
import 'package:greengrocer/src/pages/auth/result/auth_result.dart';
import 'package:greengrocer/src/services/http_manager.dart';

class AuthRepository {
  final httpManager = HttpManager();

  Future<AuthResult> signIn(
      {required String email, required String password}) async {
    final result = await httpManager
        .restRequest(url: Endpoints.signin, method: HttpMethods.post, body: {
      'email': email.trim(),
      'password': password.trim(),
    });

    if (result['result'] != null) {
      final user = UserModel.fromJson(result['result']);
      return AuthResult.success(user);
    } else {
      return AuthResult.error(auth_errors.authErrorMessage(result['error']));
    }
  }
}

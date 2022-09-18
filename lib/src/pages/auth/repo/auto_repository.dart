import 'package:greengrocer/src/constants/endpoints.dart';
import 'package:greengrocer/src/services/http_manager.dart';

class AuthRepository {
  final httpManager = HttpManager();

  Future signIn({required String email, required String password}) async {
    final result = await httpManager
        .restRequest(url: Endpoints.signin, method: HttpMethods.post, body: {
      'email': email.trim(),
      'password': password.trim(),
    });

    if (result['result'] != null) {
      //
    } else {
      // Deu erro
    }
  }
}

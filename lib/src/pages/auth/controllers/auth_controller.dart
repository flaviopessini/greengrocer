import 'package:get/get.dart';
import 'package:greengrocer/src/pages/auth/repo/auth_repository.dart';

class AuthController extends GetxController {
  final authRepository = AuthRepository();

  RxBool isLoading = false.obs;

  Future<void> signIn({required String email, required String password}) async {
    isLoading.value = true;
    await authRepository.signIn(email: email, password: password);
    isLoading.value = false;
  }
}